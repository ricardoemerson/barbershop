import 'package:asyncstate/asyncstate.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/fp/fp.dart';
import '../../../../core/providers/application_providers.dart';
import 'barbershop_register_state.dart';

part 'barbershop_register_vm.g.dart';

@Riverpod()
class BarbershopRegisterVm extends _$BarbershopRegisterVm {
  @override
  BarbershopRegisterState build() => BarbershopRegisterState.initial();

  Future<void> register({required String name, required String email}) async {
    final barbershopRepository = ref.read(barbershopRepositoryProvider);

    final BarbershopRegisterState(:openingDays, :openingHours) = state;

    final barbershopData = (
      name: name,
      email: email,
      openingDays: openingDays,
      openingHours: openingHours,
    );

    final response = await barbershopRepository.save(barbershopData).asyncLoader();

    switch (response) {
      case Success():
        ref.invalidate(getMyBarbershopProvider);

        state = state.copyWith(status: BarbershopRegisterStatus.success);
      case Failure():
        state = state.copyWith(status: BarbershopRegisterStatus.error);
    }
  }

  void addOrRemoveOpenDay(String weekDay) {
    final openingDays = state.openingDays;

    if (openingDays.contains(weekDay)) {
      openingDays.remove(weekDay);
    } else {
      openingDays.add(weekDay);
    }

    state = state.copyWith(openingDays: openingDays);
  }

  void addOrRemoveOpenHour(int hour) {
    final openingHours = state.openingHours;

    if (openingHours.contains(hour)) {
      openingHours.remove(hour);
    } else {
      openingHours.add(hour);
    }

    state = state.copyWith(openingHours: openingHours);
  }
}
