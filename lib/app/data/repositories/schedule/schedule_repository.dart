import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../core/exceptions/repository_exception.dart';
import '../../../core/fp/either.dart';
import '../../../core/fp/nil.dart';
import '../../../core/rest_client/rest_client.dart';
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
}
