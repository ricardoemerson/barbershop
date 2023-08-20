import 'package:asyncstate/asyncstate.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/fp/either.dart';
import '../../../core/providers/application_providers.dart';
import '../../../data/models/barbershop_model.dart';
import '../../../data/models/user_model.dart';
import 'home_adm_state.dart';

part 'home_adm_vm.g.dart';

@Riverpod()
class HomeAdmVm extends _$HomeAdmVm {
  @override
  Future<HomeAdmState> build() async {
    final repository = ref.read(userRepositoryProvider);
    final BarbershopModel(id: barbershopId) = await ref.read(getMyBarbershopProvider.future);

    final me = await ref.watch(getMeProvider.future);

    final response = await repository.getEmployees(barbershopId);

    switch (response) {
      case Success(value: final employeesData):
        final employees = <UserModel>[];

        if (me case UserAdmModel(workDays: _?, workHours: _?)) {
          employees.add(me);
        }

        employees.addAll(employeesData);

        return HomeAdmState(status: HomeAdmStatus.loaded, employees: employees);
      case Failure():
        return HomeAdmState(status: HomeAdmStatus.error, employees: []);
    }
  }

  Future<void> logout() => ref.read(logoutProvider.future).asyncLoader();
}
