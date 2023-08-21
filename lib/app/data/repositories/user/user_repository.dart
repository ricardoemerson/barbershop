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
  Future<Either<RepositoryException, List<UserModel>>> getEmployees(int barbershopId) async {
    try {
      final Response(:List data) = await _restClient.authRequest.get(
        '/users',
        queryParameters: {
          'barbershop_id': barbershopId,
        },
      );

      final employees = data.map((e) => UserEmployeeModel.fromMap(e)).toList();

      return Success(employees);
    } on DioException catch (err, s) {
      const message = 'Erro ao buscar colaboradores.';

      log(message, error: err, stackTrace: s);

      return Failure(RepositoryException(message));
    } on ArgumentError catch (err, s) {
      log(err.message, error: err, stackTrace: s);

      return Failure(RepositoryException(err.message));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> registerAdmin(
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

  @override
  Future<Either<RepositoryException, Nil>> registerAdminAsEmployee(
    ({List<String> workDays, List<int> workHours}) userData,
  ) async {
    try {
      final currentUserResponse = await me();
      final int currentUserId;

      switch (currentUserResponse) {
        case Success(value: UserModel(:final id)):
          currentUserId = id;
        case Failure(:final exception):
          return Failure(exception);
      }

      await _restClient.publicRequest.put(
        '/users/$currentUserId',
        data: {
          'work_days': userData.workDays,
          'work_hours': userData.workHours,
        },
      );

      return Success(nil);
    } on DioException catch (err, s) {
      const message = 'Erro ao atualizar administrador como colaborador.';

      log(message, error: err, stackTrace: s);

      return Failure(RepositoryException(message));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> registerEmployee(
    ({
      int barbershopId,
      String email,
      String name,
      String password,
      List<String> workDays,
      List<int> workHours
    }) userData,
  ) async {
    try {
      await _restClient.publicRequest.post(
        '/users',
        data: {
          'barbershop_id': userData.barbershopId,
          'name': userData.name,
          'email': userData.email,
          'password': userData.password,
          'profile': 'EMPLOYEE',
          'work_days': userData.workDays,
          'work_hours': userData.workHours,
        },
      );

      return Success(nil);
    } on DioException catch (err, s) {
      const message = 'Erro ao registrar colaborador.';

      log(message, error: err, stackTrace: s);

      return Failure(RepositoryException(message));
    }
  }
}
