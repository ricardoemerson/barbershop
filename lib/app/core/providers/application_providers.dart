import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../models/barbershop_model.dart';
import '../../models/user_model.dart';
import '../../repositories/auth/auth_repository.dart';
import '../../repositories/auth/i_auth_repository.dart';
import '../../repositories/barbershop/barbershop_repository.dart';
import '../../repositories/barbershop/i_barbershop_repository.dart';
import '../../repositories/user/i_user_repository.dart';
import '../../repositories/user/user_repository.dart';
import '../../services/user_login/i_user_login_service.dart';
import '../../services/user_login/user_login_service.dart';
import '../fp/either.dart';
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

@Riverpod(keepAlive: true)
IUserRepository userRepository(UserRepositoryRef ref) =>
    UserRepository(restClient: ref.read(restClientProvider));

@Riverpod(keepAlive: true)
Future<UserModel> getMe(GetMeRef ref) async {
  final response = await ref.watch(userRepositoryProvider).me();

  return switch (response) {
    Success(value: final user) => user,
    Failure(:final exception) => throw exception,
  };
}

@Riverpod(keepAlive: true)
IBarbershopRepository barbershopRepository(BarbershopRepositoryRef ref) =>
    BarbershopRepository(restClient: ref.read(restClientProvider));

@Riverpod(keepAlive: true)
Future<BarbershopModel> getMyBarbershop(GetMyBarbershopRef ref) async {
  final user = await ref.watch(getMeProvider.future);

  final response = await ref.watch(barbershopRepositoryProvider).getMyBarbershop(user);

  return switch (response) {
    Success(value: final barbershop) => barbershop,
    Failure(:final exception) => throw exception,
  };
}
