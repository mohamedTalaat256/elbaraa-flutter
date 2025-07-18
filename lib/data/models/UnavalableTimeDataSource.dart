
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class UnavalableTimeDataSource extends CalendarDataSource {
  UnavalableTimeDataSource(List<Appointment> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].start;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].end;
  }

  @override
  String getSubject(int index) {
    return appointments![index].title;
  }

  @override
  Color getColor(int index) {
    return const Color.fromARGB(255, 37, 148, 221); //appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return false;//appointments![index].rrule;
  }
}