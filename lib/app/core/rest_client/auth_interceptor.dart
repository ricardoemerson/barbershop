import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

// import '../contexts/global_context.dart';
import '../config/config.dart';
import '../contexts/global_context.dart';
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
    final DioException(requestOptions: RequestOptions(:extra, :path), :response) = err;

    if (extra case {'DIO_AUTH_REQUEST': true}) {
      if (response?.statusCode == HttpStatus.unauthorized) {
        try {
          if (path != '/auth/refresh') {
            await _refreshToken();
            await _retryRequest(err, handler);
          } else {
            _expireLogin();
          }
        } catch (err) {
          _expireLogin();
        }
      }
    } else {
      handler.next(err);
    }
  }

  Future<void> _refreshToken() async {
    try {
      final storage = await SharedPreferences.getInstance();
      final refreshToken = storage.getString(LocalStorageKeys.refreshToken);

      if (refreshToken == null) {
        _expireLogin();

        return;
      }

      final Response(:data) = await _restClient.authRequest.put(
        '/auth/refresh',
        data: {
          'refresh_token': refreshToken,
        },
      );

      storage.setString(LocalStorageKeys.accessToken, data['access_token']);
      storage.setString(LocalStorageKeys.refreshToken, data['refresh_token']);
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

  Future<void> _expireLogin() async {
    final context = GlobalContext.instance.navigatorKey.currentContext;
    final navigatorState = GlobalContext.instance.navigatorKey.currentState;

    final storage = await SharedPreferences.getInstance();
    storage.clear();

    showTopSnackBar(
      navigatorState!.overlay!,
      const CustomSnackBar.error(
        message: 'Seu login expirou. Faça o login novamente.',
      ),
    );

    Navigator.of(context!).pushNamedAndRemoveUntil('/auth/login', (route) => false);
  }
}
