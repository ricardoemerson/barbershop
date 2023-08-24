import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../core/exceptions/repository_exception.dart';
import '../../../core/fp/either.dart';
import '../../../core/fp/nil.dart';
import '../../../core/rest_client/rest_client.dart';
import '../../models/schedule_model.dart';
import 'i_schedule_repository.dart';

class ScheduleRepository implements IScheduleRepository {
  final RestClient _restClient;

  ScheduleRepository({
    required RestClient restClient,
  }) : _restClient = restClient;

  @override
  Future<Either<RepositoryException, Nil>> scheduleClient(
    ({int barbershopId, String clientName, DateTime date, int time, int userId}) scheduleData,
  ) async {
    try {
      await _restClient.authRequest.post(
        '/schedules',
        data: {
          'barbershop_id': scheduleData.barbershopId,
          'user_id': scheduleData.userId,
          'client_name': scheduleData.clientName,
          'date': scheduleData.date.toIso8601String(),
          'time': scheduleData.time,
        },
      );

      return Success(nil);
    } on DioException catch (err, s) {
      const message = 'Erro ao registrar agendamento.';

      log(message, error: err, stackTrace: s);

      return Failure(RepositoryException(message));
    }
  }

  @override
  Future<Either<RepositoryException, List<ScheduleModel>>> findByDate(
    ({DateTime date, int userId}) filter,
  ) async {
    try {
      final Response(:List data) = await _restClient.authRequest.get(
        '/schedules',
        queryParameters: {
          'user_id': filter.userId,
          'date': filter.date.toIso8601String(),
        },
      );

      final schedules = data.map((e) => ScheduleModel.fromMap(e)).toList();

      return Success(schedules);
    } on DioException catch (err, s) {
      const message = 'Erro ao buscar agendamentos.';

      log(message, error: err, stackTrace: s);

      return Failure(RepositoryException(message));
    } on ArgumentError catch (err, s) {
      log(err.message, error: err, stackTrace: s);

      return Failure(RepositoryException(err.message));
    }
  }
}
