import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../../core/exceptions/unauthorized_exception.dart';
import '../../../core/fp/either.dart';
import '../../../core/rest_client/rest_client.dart';
import 'i_auth_repository.dart';

class AuthRepository implements IAuthRepository {
  final RestClient _restClient;

  AuthRepository({
    required RestClient restClient,
  }) : _restClient = restClient;

  @override
  Future<Either<UnauthorizedException, String>> login(String email, String password) async {
    try {
      final Response(:data) = await _restClient.publicRequest.post(
        '/auth',
        data: {
          'email': email,
          'password': password,
        },
      );

      return Success(data['access_token']);
    } on DioException catch (err, s) {
      const message = 'Erro ao realizar o login.';

      log(message, error: err, stackTrace: s);

      if (err.response != null) {
        final Response(:statusCode) = err.response!;

        if (statusCode == HttpStatus.unauthorized) {
          return Failure(UnauthorizedException('e-Mail ou senha inválidos.'));
        }
      }

      return Failure(UnauthorizedException(message));
    }
  }
}
