import 'package:syncfusion_flutter_calendar/calendar.dart';

class AppointmentDataSource extends CalendarDataSource {
  @override
  List<dynamic>? get appointments => [
        Appointment(
          startTime: DateTime.now(),
          endTime: DateTime.now().add(const Duration(hours: 1)),
          subject: 'Ricardo Emerson',
          location: 'pt_BR',
        ),
        Appointment(
          startTime: DateTime.now().add(const Duration(hours: 2)),
          endTime: DateTime.now().add(const Duration(hours: 3)),
          subject: 'Maria José',
          location: 'pt_BR',
        ),
      ];
}
