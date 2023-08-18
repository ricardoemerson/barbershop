import '../../../core/exceptions/repository_exception.dart';
import '../../../core/fp/fp.dart';
import '../../models/user_model.dart';

abstract interface class IUserRepository {
  Future<Either<RepositoryException, UserModel>> me();
  Future<Either<RepositoryException, Nil>> registerAdim(
    ({
      String name,
      String email,
      String password,
    }) userData,
  );
}
