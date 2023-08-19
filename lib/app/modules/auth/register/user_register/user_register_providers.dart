import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/providers/application_providers.dart';
import '../../../../data/services/user_register_adm/i_user_register_adm_service.dart';
import '../../../../data/services/user_register_adm/user_register_adm_service.dart';

part 'user_register_providers.g.dart';

@Riverpod(keepAlive: true)
IUserRegisterAdmService userRegisterAdmService(UserRegisterAdmServiceRef ref) =>
    UserRegisterAdmService(
      userRepository: ref.read(userRepositoryProvider),
      userLoginService: ref.read(userLoginServiceProvider),
    );
