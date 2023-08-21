import '../../../core/exceptions/service_exception.dart';
import '../../../core/fp/either.dart';
import '../../../core/fp/nil.dart';
import '../../repositories/user/i_user_repository.dart';
import '../user_login/i_user_login_service.dart';
import 'i_user_register_adm_service.dart';

class UserRegisterAdmService implements IUserRegisterAdmService {
  final IUserRepository _userRepository;
  final IUserLoginService _userLoginService;

  UserRegisterAdmService({
    required IUserRepository userRepository,
    required IUserLoginService userLoginService,
  })  : _userRepository = userRepository,
        _userLoginService = userLoginService;

  @override
  Future<Either<ServiceException, Nil>> execute(
    ({String email, String name, String password}) userData,
  ) async {
    final response = await _userRepository.registerAdmin(userData);

    switch (response) {
      case Success():
        return _userLoginService.execute(userData.email, userData.password);
      case Failure(:final exception):
        return Failure(ServiceException(exception.message));
    }
  }
}
