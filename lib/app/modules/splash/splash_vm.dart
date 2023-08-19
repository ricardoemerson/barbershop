import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/config/config.dart';
import '../../core/providers/application_providers.dart';
import '../../data/models/user_model.dart';

part 'splash_vm.g.dart';

enum SplashStatus { initial, login, loggedAdm, loggedEmployee, error }

@Riverpod()
class SplashVm extends _$SplashVm {
  @override
  Future<SplashStatus> build() async {
    final storage = await SharedPreferences.getInstance();

    if (storage.containsKey(LocalStorageKeys.accessToken)) {
      ref.invalidate(getMeProvider);
      ref.invalidate(getMyBarbershopProvider);

      try {
        final user = await ref.read(getMeProvider.future);

        return switch (user) {
          UserAdmModel() => SplashStatus.loggedAdm,
          UserEmployeeModel() => SplashStatus.loggedEmployee,
        };
      } catch (err, s) {
        log('Erro ao verificar se o usuário já estava autenticado.', error: err, stackTrace: s);

        return SplashStatus.login;
      }
    }

    return SplashStatus.login;
  }
}
