import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:table_calendar/table_calendar.dart';

import '../extensions/extensions.dart';
import '../helpers/message_helper.dart';
import '../theme/theme.dart';

class ScheduleCalendar extends StatefulWidget {
  final VoidCallback onCancel;
  final ValueChanged<DateTime> onSelectDate;

  const ScheduleCalendar({
    super.key,
    required this.onCancel,
    required this.onSelectDate,
  });

  @override
  State<ScheduleCalendar> createState() => _ScheduleCalendarState();
}

class _ScheduleCalendarState extends State<ScheduleCalendar> {
  DateTime? selectedDay;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 470,
      width: context.screenWidth,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.inputs,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TableCalendar(
            daysOfWeekHeight: 30,
            availableGestures: AvailableGestures.none,
            headerStyle: HeaderStyle(
              titleCentered: true,
              leftChevronIcon: PhosphorIcon(
                PhosphorIcons.bold.caretLeft,
                color: AppColors.primary,
              ),
              rightChevronIcon: PhosphorIcon(
                PhosphorIcons.bold.caretRight,
                color: AppColors.primary,
              ),
            ),
            focusedDay: DateTime.now(),
            firstDay: DateTime.utc(2010),
            lastDay: DateTime.now().add(const Duration(days: 365 * 10)),
            locale: 'pt_BR',
            availableCalendarFormats: const {CalendarFormat.month: 'Month'},
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                this.selectedDay = selectedDay;
              });
            },
            selectedDayPredicate: (day) {
              return isSameDay(selectedDay, day);
            },
            calendarStyle: const CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: AppColors.secondary,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(onPressed: widget.onCancel, child: const Text('Cancelar')),
              TextButton(
                onPressed: () {
                  if (selectedDay == null) {
                    MessageHelper.showError('Por favor, selecione um dia.', context);

                    return;
                  }

                  widget.onSelectDate(selectedDay!);
                },
                child: const Text('OK'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
