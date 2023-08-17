import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import '../contexts/global_context.dart';
import '../config/config.dart';
import '../exceptions/token_expired_exception.dart';
import 'rest_client.dart';

class AuthInterceptor extends Interceptor {
  final RestClient _restClient;

  AuthInterceptor({
    required RestClient restClient,
  }) : _restClient = restClient;

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final RequestOptions(:extra, :headers) = options;

    const authHeaderKey = 'Authorization';
    headers.remove(authHeaderKey);

    if (extra case {'DIO_AUTH_REQUEST': true}) {
      final storage = await SharedPreferences.getInstance();
      final accessToken = storage.getString(LocalStorageKeys.accessToken);

      headers.addAll({authHeaderKey: 'Bearer $accessToken'});
    }

    handler.next(options);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      try {
        if (err.requestOptions.path != '/auth/refresh') {
          await _refreshToken();
          await _retryRequest(err, handler);
        } else {
          // GlobalContext.instance.expireLogin();
        }
      } catch (err) {
        // GlobalContext.instance.expireLogin();
      }
    } else {
      handler.next(err);
    }
  }

  Future<void> _refreshToken() async {
    try {
      final storage = await SharedPreferences.getInstance();
      final refreshToken = storage.getString('refreshToken');

      if (refreshToken == null) {
        return;
      }

      final response = await _restClient.authRequest().put(
        '/auth/refresh',
        data: {
          'refresh_token': refreshToken,
        },
      );

      storage.setString('accessToken', response.data.accessToken);
      storage.setString('refreshToken', response.data.refreshToken);
    } on DioException catch (err, s) {
      const message = 'Refresh token expirado.';

      log(message, error: err, stackTrace: s);

      throw TokenExpiredException(message);
    }
  }

  Future<void> _retryRequest(DioException err, ErrorInterceptorHandler handler) async {
    final requestOptions = err.requestOptions;

    final response = await _restClient.request(
      requestOptions.path,
      options: Options(
        headers: requestOptions.headers,
        method: requestOptions.method,
      ),
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
    );

    handler.resolve(
      Response(
        requestOptions: requestOptions,
        data: response.data,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
        headers: response.headers,
      ),
    );
  }
}
