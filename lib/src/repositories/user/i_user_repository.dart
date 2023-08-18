import '../../../app/core/exceptions/repository_exception.dart';
import '../../../app/core/fp/either.dart';
import '../../../app/models/user_model.dart';

abstract class IUserRepository {
  Future<Either<RepositoryException, UserModel>> me();
}
