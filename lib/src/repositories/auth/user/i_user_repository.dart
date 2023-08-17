import '../../../core/exceptions/repository_exception.dart';
import '../../../core/fp/either.dart';
import '../../../models/user_model.dart';

abstract class IUserRepository {
  Future<Either<RepositoryException, UserModel>> me();
}
