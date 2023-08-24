import '../../../core/exceptions/repository_exception.dart';
import '../../../core/fp/fp.dart';
import '../../models/schedule_model.dart';

abstract interface class IScheduleRepository {
  Future<Either<RepositoryException, Nil>> scheduleClient(
    ({int barbershopId, int userId, String clientName, DateTime date, int time}) scheduleData,
  );
  Future<Either<RepositoryException, List<ScheduleModel>>> findByDate(
    ({
      int userId,
      DateTime date,
    }) filter,
  );
}
