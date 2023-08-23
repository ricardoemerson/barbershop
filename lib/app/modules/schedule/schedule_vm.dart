import 'package:asyncstate/asyncstate.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/fp/fp.dart';
import '../../core/providers/application_providers.dart';
import '../../data/models/barbershop_model.dart';
import '../../data/models/user_model.dart';
import 'schedule_state.dart';

part 'schedule_vm.g.dart';

@Riverpod()
class ScheduleVm extends _$ScheduleVm {
  @override
  ScheduleState build() => ScheduleState.initial();

  void selectDate(DateTime date) {
    state = state.copyWith(scheduleDate: () => date);
  }

  void selectHour(int hour) {
    if (hour == state.scheduleHour) {
      state = state.copyWith(scheduleHour: () => null);
    } else {
      state = state.copyWith(scheduleHour: () => hour);
    }
  }

  Future<void> register({required UserModel user, required String clientName}) async {
    final asyncLoaderHandler = AsyncLoaderHandler()..start();

    final ScheduleState(:scheduleDate, :scheduleHour) = state;

    final scheduleRepository = ref.read(scheduleRepositoryProvider);

    final BarbershopModel(id: barbershopId) = await ref.watch(getMyBarbershopProvider.future);

    final scheduleData = (
      barbershopId: barbershopId,
      userId: user.id,
      clientName: clientName,
      date: scheduleDate!,
      time: scheduleHour!,
    );

    final response = await scheduleRepository.scheduleClient(scheduleData);

    switch (response) {
      case Success():
        state = state.copyWith(status: ScheduleStatus.success);
      case Failure():
        state = state.copyWith(status: ScheduleStatus.error);
    }

    asyncLoaderHandler.close();
  }
}
