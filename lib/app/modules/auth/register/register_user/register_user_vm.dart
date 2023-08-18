import 'package:asyncstate/asyncstate.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/fp/either.dart';
import '../../../../core/providers/application_providers.dart';
import 'register_user_providers.dart';

part 'register_user_vm.g.dart';

enum RegisterUserStatus { initial, success, error }

@Riverpod()
class RegisterUserVm extends _$RegisterUserVm {
  @override
  RegisterUserStatus build() => RegisterUserStatus.initial;

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final userRegisterAdmService = ref.read(userRegisterAdmServiceProvider);

    final userData = (
      name: name,
      email: email,
      password: password,
    );

    final response = await userRegisterAdmService.execute(userData).asyncLoader();

    switch (response) {
      case Success():
        ref.invalidate(getMeProvider);

        state = RegisterUserStatus.success;
      case Failure():
        state = RegisterUserStatus.error;
    }
  }
}
