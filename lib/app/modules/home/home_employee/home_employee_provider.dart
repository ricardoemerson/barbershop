import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/fp/either.dart';
import '../../../core/providers/application_providers.dart';

part 'home_employee_provider.g.dart';

@Riverpod()
Future<int> getTotalSchedulesToday(GetTotalSchedulesTodayRef ref, int userId) async {
  final DateTime(:year, :month, :day) = DateTime.now();

  final filter = (
    date: DateTime(year, month, day),
    userId: userId,
  );

  final scheduleRepository = ref.read(scheduleRepositoryProvider);
  final response = await scheduleRepository.findByDate(filter);

  return switch (response) {
    Success(value: List(length: final totalSchedules)) => totalSchedules,
    Failure(:final exception) => throw exception,
  };
}
