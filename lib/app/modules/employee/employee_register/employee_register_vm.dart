import 'package:asyncstate/asyncstate.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/exceptions/repository_exception.dart';
import '../../../core/fp/fp.dart';
import '../../../core/providers/application_providers.dart';
import '../../../data/models/barbershop_model.dart';
import '../../../data/repositories/user/i_user_repository.dart';
import 'employee_register_state.dart';

part 'employee_register_vm.g.dart';

@Riverpod()
class EmployeeRegisterVm extends _$EmployeeRegisterVm {
  @override
  EmployeeRegisterState build() => EmployeeRegisterState.initial();

  void setAdmRegister(bool isAdmRegister) {
    state = state.copyWith(isRegisterAdmin: isAdmRegister);
  }

  void addOrRemoveOpenDays(String weekDay) {
    final EmployeeRegisterState(:workDays) = state;

    if (workDays.contains(weekDay)) {
      workDays.remove(weekDay);
    } else {
      workDays.add(weekDay);
    }

    state = state.copyWith(workDays: workDays);
  }

  void addOrRemoveOpenHours(int hour) {
    final EmployeeRegisterState(:workHours) = state;

    if (workHours.contains(hour)) {
      workHours.remove(hour);
    } else {
      workHours.add(hour);
    }

    state = state.copyWith(workHours: workHours);
  }

  Future<void> register({String? name, String? email, String? password}) async {
    final EmployeeRegisterState(:isRegisterAdmin, :workDays, :workHours) = state;

    final asyncLoaderHandler = AsyncLoaderHandler()..start();

    final IUserRepository(:registerAdminAsEmployee, :registerEmployee) =
        ref.read(userRepositoryProvider);

    final Either<RepositoryException, Nil> registerResponse;

    if (isRegisterAdmin) {
      final data = (
        workDays: workDays,
        workHours: workHours,
      );

      registerResponse = await registerAdminAsEmployee(data);
    } else {
      final BarbershopModel(:id) = await ref.read(getMyBarbershopProvider.future);

      final data = (
        barbershopId: id,
        name: name!,
        email: email!,
        password: password!,
        workDays: workDays,
        workHours: workHours,
      );

      registerResponse = await registerEmployee(data);
    }

    switch (registerResponse) {
      case Success():
        state = state.copyWith(status: EmployeeRegisterStatus.success);
      case Failure():
        state = state.copyWith(status: EmployeeRegisterStatus.error);
    }

    asyncLoaderHandler.close();
  }
}
