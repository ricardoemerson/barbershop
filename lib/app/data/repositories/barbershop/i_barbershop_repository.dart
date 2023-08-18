import '../../../core/exceptions/repository_exception.dart';
import '../../../core/fp/fp.dart';
import '../../models/barbershop_model.dart';
import '../../models/user_model.dart';

abstract interface class IBarbershopRepository {
  Future<Either<RepositoryException, BarbershopModel>> getMyBarbershop(UserModel user);
}
