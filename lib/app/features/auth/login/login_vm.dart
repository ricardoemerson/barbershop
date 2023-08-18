import 'package:asyncstate/asyncstate.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/exceptions/service_exception.dart';
import '../../../core/fp/either.dart';
import '../../../core/providers/application_providers.dart';
import 'login_state.dart';

part 'login_vm.g.dart';

@Riverpod()
class LoginVm extends _$LoginVm {
  @override
  LoginState build() => LoginState.initial();

  Future<void> login(String email, String password) async {
    final loaderHandle = AsyncLoaderHandler()..start();

    final loginService = ref.read(userLoginServiceProvider);

    final response = await loginService.execute(email, password);

    switch (response) {
      case Success():
        break;
      case Failure(exception: ServiceException(:final message)):
        state = state.copyWith(
          status: LoginStatus.error,
          errorMessage: () => message,
        );
        break;
    }

    loaderHandle.close();
  }
}
