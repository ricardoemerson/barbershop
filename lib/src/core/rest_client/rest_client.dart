import 'package:dio/dio.dart';
import 'package:dio/io.dart';

import '../helpers/env_helper.dart';
import 'auth_interceptor.dart';

final class RestClient extends DioForNative {
  late AuthInterceptor _authInterceptor;

  RestClient()
      : super(
          BaseOptions(
            baseUrl: EnvHelper.instance.get('BACKEND_BASE_URL'),
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 60),
          ),
        ) {
    interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
      ),
    );

    _authInterceptor = AuthInterceptor(restClient: this);
  }

  RestClient authRequest() {
    if (!interceptors.contains(_authInterceptor)) {
      interceptors.add(_authInterceptor);
    }

    return this;
  }

  RestClient publicRequest() {
    interceptors.remove(_authInterceptor);

    return this;
  }
}
