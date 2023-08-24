import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../data/models/schedule_model.dart';

class AppointmentDataSource extends CalendarDataSource {
  final List<ScheduleModel> schedules;

  AppointmentDataSource({
    required this.schedules,
  });

  @override
  List<dynamic>? get appointments {
    return schedules.map((e) {
      final ScheduleModel(date: DateTime(:year, :month, :day), :hour, :clientName) = e;

      final startTime = DateTime(year, month, day, hour);
      final endTime = DateTime(year, month, day, hour + 1);

      return Appointment(
        startTime: startTime,
        endTime: endTime,
        subject: clientName,
      );
    }).toList();
  }

  // [
  //       Appointment(
  //         startTime: DateTime.now(),
  //         endTime: DateTime.now().add(const Duration(hours: 1)),
  //         subject: 'Ricardo Emerson',
  //         location: 'pt_BR',
  //       ),
  //       Appointment(
  //         startTime: DateTime.now().add(const Duration(hours: 2)),
  //         endTime: DateTime.now().add(const Duration(hours: 3)),
  //         subject: 'Maria José',
  //         location: 'pt_BR',
  //       ),
  //     ];
}
