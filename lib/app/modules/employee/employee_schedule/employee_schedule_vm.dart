import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/exceptions/repository_exception.dart';
import '../../../core/fp/fp.dart';
import '../../../core/providers/application_providers.dart';
import '../../../data/models/schedule_model.dart';

part 'employee_schedule_vm.g.dart';

@Riverpod()
class EmployeeScheduleVm extends _$EmployeeScheduleVm {
  Future<Either<RepositoryException, List<ScheduleModel>>> _getSchedules(
    int userId,
    DateTime date,
  ) {
    final repository = ref.read(scheduleRepositoryProvider);

    return repository.findByDate((userId: userId, date: date));
  }

  @override
  Future<List<ScheduleModel>> build(int userId, DateTime date) async {
    final response = await _getSchedules(userId, date);

    return switch (response) {
      Success(value: final schedules) => schedules,
      Failure(:final exception) => throw Exception(exception),
    };
  }

  Future<void> changeDate(int userId, DateTime date) async {
    final response = await _getSchedules(userId, date);

    state = switch (response) {
      Success(value: final schedules) => AsyncData(schedules),
      Failure(:final exception) => AsyncError(Exception(exception), StackTrace.current),
    };
  }
}
