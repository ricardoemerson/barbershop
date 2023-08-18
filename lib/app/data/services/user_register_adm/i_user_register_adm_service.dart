import '../../../core/exceptions/service_exception.dart';
import '../../../core/fp/fp.dart';

abstract interface class IUserRegisterAdmService {
  Future<Either<ServiceException, Nil>> execute(
    ({
      String name,
      String email,
      String password,
    }) userData,
  );
}
