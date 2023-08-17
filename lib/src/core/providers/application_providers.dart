import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../repositories/auth/auth_repository.dart';
import '../../repositories/auth/i_auth_repository.dart';
import '../../services/user_login/i_user_login_service.dart';
import '../../services/user_login/user_login_service.dart';
import '../rest_client/rest_client.dart';

part 'application_providers.g.dart';

@Riverpod(keepAlive: true)
RestClient restClient(RestClientRef ref) => RestClient();

@Riverpod(keepAlive: true)
IAuthRepository authRepository(AuthRepositoryRef ref) =>
    AuthRepository(restClient: ref.read(restClientProvider));

@Riverpod(keepAlive: true)
IUserLoginService userLoginService(UserLoginServiceRef ref) =>
    UserLoginService(authRepository: ref.read(authRepositoryProvider));
