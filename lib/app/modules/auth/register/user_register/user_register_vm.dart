import 'package:asyncstate/asyncstate.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/fp/either.dart';
import '../../../../core/providers/application_providers.dart';
import 'user_register_providers.dart';

part 'user_register_vm.g.dart';

enum UserRegisterStatus { initial, success, error }

@Riverpod()
class UserRegisterVm extends _$UserRegisterVm {
  @override
  UserRegisterStatus build() => UserRegisterStatus.initial;

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

        state = UserRegisterStatus.success;
      case Failure():
        state = UserRegisterStatus.error;
    }
  }
}
