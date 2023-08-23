import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../core/theme/theme.dart';
import '../../../data/models/user_model.dart';
import 'appointment_data_source.dart';

class EmployeeSchedulePage extends StatelessWidget {
  const EmployeeSchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)?.settings.arguments as UserModel;

    final employeeData = switch (user) {
      UserAdmModel(:final workDays, :final workHours) => (
          workDays: workDays!,
          workHours: workHours!
        ),
      UserEmployeeModel(:final workDays, :final workHours) => (
          workDays: workDays,
          workHours: workHours
        ),
    };
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
              user.name,
              style: AppTextStyles.textMedium.copyWith(
                fontSize: 20,
                color: AppColors.primary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 28),
            Expanded(
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
                                Text('Client: ${calendarTapDetails.appointments?.first.subject}'),
                                Text('Horário: ${dateFormat.format(calendarTapDetails.date!)}'),
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
                dataSource: AppointmentDataSource(),
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
            )
          ],
        ),
      ),
    );
  }
}
