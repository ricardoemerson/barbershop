import 'package:asyncstate/asyncstate.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/exceptions/service_exception.dart';
import '../../../core/fp/either.dart';
import '../../../core/providers/application_providers.dart';
import '../../../data/models/user_model.dart';
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
        ref.invalidate(getMeProvider);
        ref.invalidate(getMyBarbershopProvider);

        final user = await ref.read(getMeProvider.future);

        switch (user) {
          case UserAdmModel():
            state = state.copyWith(status: LoginStatus.admLogin);
          case UserEmployeeModel():
            state = state.copyWith(status: LoginStatus.employeeLogin);
        }

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
