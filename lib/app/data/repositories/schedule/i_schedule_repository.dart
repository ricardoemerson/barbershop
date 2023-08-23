import '../../../core/exceptions/repository_exception.dart';
import '../../../core/fp/fp.dart';

abstract interface class IScheduleRepository {
  Future<Either<RepositoryException, Nil>> scheduleClient(
    ({int barbershopId, int userId, String clientName, DateTime date, int time}) scheduleData,
  );
}
