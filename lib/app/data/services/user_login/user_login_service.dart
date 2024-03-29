import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/config/local_storage_keys.dart';
import '../../../core/exceptions/service_exception.dart';
import '../../../core/fp/fp.dart';
import '../../repositories/auth/i_auth_repository.dart';
import 'i_user_login_service.dart';

class UserLoginService implements IUserLoginService {
  final IAuthRepository _authRepository;

  UserLoginService({
    required IAuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  Future<Either<ServiceException, Nil>> execute(String email, String password) async {
    final response = await _authRepository.login(email, password);

    switch (response) {
      case Success(value: (:final accessToken, :final refreshToken)):
        final storage = await SharedPreferences.getInstance();
        storage.setString(LocalStorageKeys.accessToken, accessToken);
        storage.setString(LocalStorageKeys.refreshToken, refreshToken);

        return Success(nil);
      case Failure(:final exception):
        return Failure(ServiceException(exception.message));
    }
  }
}
