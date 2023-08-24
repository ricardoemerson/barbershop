import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../core/theme/theme.dart';
import '../../../core/widgets/app_loader.dart';
import '../../../data/models/user_model.dart';
import 'appointment_data_source.dart';
import 'employee_schedule_vm.dart';

class EmployeeSchedulePage extends ConsumerStatefulWidget {
  const EmployeeSchedulePage({super.key});

  @override
  ConsumerState<EmployeeSchedulePage> createState() => _EmployeeSchedulePageState();
}

class _EmployeeSchedulePageState extends ConsumerState<EmployeeSchedulePage> {
  late DateTime dateSelected;
  var ignoreFirstLoad = true;

  @override
  void initState() {
    super.initState();

    final DateTime(:year, :month, :day) = DateTime.now();
    dateSelected = DateTime(year, month, day);
  }

  @override
  Widget build(BuildContext context) {
    final UserModel(id: userId, :name) = ModalRoute.of(context)?.settings.arguments as UserModel;

    final scheduleAsync = ref.watch(employeeScheduleVmProvider(userId, dateSelected));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agenda'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        child: Column(
          children: [
            Text(
              name,
              style: AppTextStyles.textMedium.copyWith(
                fontSize: 20,
                color: AppColors.primary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 28),
            scheduleAsync.when(
              loading: () => const AppLoader(),
              error: (error, stackTrace) {
                log('Erro ao carregar agendamentos', error: error, stackTrace: stackTrace);

                return const Center(
                  child: Text('Erro ao carregar agendamentos.'),
                );
              },
              data: (schedules) {
                return Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SfCalendar(
                      onTap: (calendarTapDetails) {
                        if (calendarTapDetails.appointments != null &&
                            calendarTapDetails.appointments!.isNotEmpty) {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              final dateFormat = DateFormat('dd/MM/yyyy HH:mm:ss');
                              return SizedBox(
                                height: 200,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Client: ${calendarTapDetails.appointments?.first.subject}',
                                      ),
                                      Text(
                                        'Horário: ${dateFormat.format(calendarTapDetails.date!)}',
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                      allowViewNavigation: true,
                      showNavigationArrow: true,
                      showDatePickerButton: true,
                      showTodayButton: true,
                      todayHighlightColor: AppColors.primary,
                      backgroundColor: AppColors.shape,
                      cellBorderColor: AppColors.grey,
                      headerStyle: CalendarHeaderStyle(
                        backgroundColor: AppColors.inputs,
                        textStyle: AppTextStyles.textMedium.copyWith(color: AppColors.white),
                      ),
                      weekNumberStyle: const WeekNumberStyle(
                        textStyle: TextStyle(color: AppColors.grey),
                      ),
                      viewHeaderStyle: ViewHeaderStyle(
                        dayTextStyle: const TextStyle(color: AppColors.white),
                        dateTextStyle: AppTextStyles.textMedium.copyWith(color: AppColors.white),
                      ),
                      timeSlotViewSettings: const TimeSlotViewSettings(
                        timeTextStyle: TextStyle(color: AppColors.grey),
                      ),
                      dataSource: AppointmentDataSource(schedules: schedules),
                      onViewChanged: (viewChangedDetails) {
                        if (ignoreFirstLoad) {
                          ignoreFirstLoad = false;
                          return;
                        }

                        ref
                            .read(employeeScheduleVmProvider(userId, dateSelected).notifier)
                            .changeDate(userId, viewChangedDetails.visibleDates.first);
                      },
                      appointmentBuilder: (context, calendarAppointmentDetails) {
                        return DecoratedBox(
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Text(
                              calendarAppointmentDetails.appointments.first.subject,
                              style: AppTextStyles.textRegular.copyWith(fontSize: 14),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
