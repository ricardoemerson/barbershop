import '../../../core/exceptions/unauthorized_exception.dart';
import '../../../core/fp/fp.dart';

abstract interface class IAuthRepository {
  Future<Either<UnauthorizedException, String>> login(String email, String password);
}
