import 'package:dio/dio.dart';
import 'package:dio/io.dart';

import '../helpers/env_helper.dart';
import 'auth_interceptor.dart';

final class RestClient extends DioForNative {
  RestClient()
      : super(
          BaseOptions(
            baseUrl: EnvHelper.instance.get('BACKEND_BASE_URL'),
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 60),
          ),
        ) {
    interceptors.addAll([
      LogInterceptor(
        requestBody: true,
        responseBody: true,
      ),
      AuthInterceptor(restClient: this),
    ]);
  }

  RestClient authRequest() {
    options.extra['DIO_AUTH_REQUEST'] = true;

    return this;
  }

  RestClient publicRequest() {
    options.extra['DIO_AUTH_REQUEST'] = false;

    return this;
  }
}
