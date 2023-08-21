import '../../../core/exceptions/repository_exception.dart';
import '../../../core/fp/fp.dart';
import '../../models/user_model.dart';

abstract interface class IUserRepository {
  Future<Either<RepositoryException, UserModel>> me();
  Future<Either<RepositoryException, List<UserModel>>> getEmployees(int barbershopId);
  Future<Either<RepositoryException, Nil>> registerAdmin(
    ({
      String name,
      String email,
      String password,
    }) userData,
  );
  Future<Either<RepositoryException, Nil>> registerAdminAsEmployee(
    ({
      List<String> workDays,
      List<int> workHours,
    }) userData,
  );
  Future<Either<RepositoryException, Nil>> registerEmployee(
    ({
      int barbershopId,
      String name,
      String email,
      String password,
      List<String> workDays,
      List<int> workHours,
    }) userData,
  );
}
