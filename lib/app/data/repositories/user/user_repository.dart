import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../core/exceptions/repository_exception.dart';
import '../../../core/fp/fp.dart';
import '../../../core/rest_client/rest_client.dart';
import '../../models/user_model.dart';
import 'i_user_repository.dart';

class UserRepository implements IUserRepository {
  final RestClient _restClient;

  UserRepository({
    required RestClient restClient,
  }) : _restClient = restClient;

  @override
  Future<Either<RepositoryException, UserModel>> me() async {
    try {
      final Response(:data) = await _restClient.authRequest.get('/me');

      return Success(UserModel.fromMap(data));
    } on DioException catch (err, s) {
      const message = 'Erro ao buscar dados do usuário autenticado.';

      log(message, error: err, stackTrace: s);

      return Failure(RepositoryException(message));
    } on ArgumentError catch (err, s) {
      log(err.message, error: err, stackTrace: s);

      return Failure(RepositoryException(err.message));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> registerAdim(
    ({
      String email,
      String name,
      String password,
    }) userData,
  ) async {
    try {
      await _restClient.publicRequest.post(
        '/users',
        data: {
          'name': userData.name,
          'email': userData.email,
          'password': userData.password,
          'profile': 'ADM',
        },
      );

      return Success(nil);
    } on DioException catch (err, s) {
      const message = 'Erro ao registrar usuário admin.';

      log(message, error: err, stackTrace: s);

      return Failure(RepositoryException(message));
    }
  }
}
