import 'package:elbaraa/data/models/session.model.dart';
import 'package:elbaraa/data/models/unavailableTime.model.dart';
import 'package:elbaraa/presentation/screens/calendar/data/event.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:kalender/kalender.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

List<Appointment> modifyListTimesAfterChangeTimeZoneUnavailableTimes(
  List<UnavailableTime> list,
) {
  final seen = <String>{};

  final filteredList = list.where((event) {
    final key =
        '${event.day}_${event.start.toIso8601String()}_${event.end.toIso8601String()}';
    if (seen.contains(key)) return false;
    seen.add(key);
    return true;
  }).toList();

  return filteredList.map((event) {
    final DateTime localStart = event.start.toLocal();
    final DateTime localEnd = event.end.toLocal();
    final String weekday = event.day.substring(0, 2).toUpperCase();

    final String formattedStart = Jiffy.parseFromDateTime(
      localStart,
    ).format(pattern: "yyyyMMdd'T'HHmmss");

    return Appointment(
      id: event.id,
      subject: event.id.toString(),
      color: Colors.red,
      startTime: localStart,
      endTime: localEnd,
      notes: 'Discuss quarterly earnings',
      recurrenceRule: 'FREQ=WEEKLY;BYDAY=$weekday;DTSTART=$formattedStart',
    );
  }).toList();
}

List<Appointment> modifySessionsAfterChangeTimeZone(List<Session> list) {
  return list.map((event) {
    final DateTime localStart = DateTime.parse(event.start!);
    final DateTime localEnd = DateTime.parse(event.end!);

    return Appointment(
      subject: event.id.toString(),
      color: Colors.blueAccent,
      startTime: localStart,
      endTime: localEnd,
    );
  }).toList();
}

List<Appointment> modifyStudentSessionsAfterChangeTimeZone(List<Session> list) {
  return list.map((event) {
    final DateTime localStart = DateTime.parse(event.start!);
    final DateTime localEnd = DateTime.parse(event.end!);

    return Appointment(
      subject: event.id.toString(),
      color: Colors.black,
      startTime: localStart,
      endTime: localEnd,
    );
  }).toList();
}

List<Appointment> mergeAllEvents(
  List<Session> StudentSessions,
  List<Session> instructorSessions,
  List<UnavailableTime> unavailableTimes,
) {
  List<Appointment> all = [
    ...modifyStudentSessionsAfterChangeTimeZone(StudentSessions),
    ...modifySessionsAfterChangeTimeZone(instructorSessions),
    ...modifyListTimesAfterChangeTimeZoneUnavailableTimes(unavailableTimes),
  ];

  all.sort(
    (a, b) => a.endTime
        .difference(a.startTime)
        .inMinutes
        .compareTo(b.endTime.difference(b.startTime).inMinutes),
  );

  return all;
}

List<CalendarEvent> convertSessionsToEvent(List<Session> list) {
  return list.map((event) {
    final DateTime localStart = DateTime.parse(event.start!);
    final DateTime localEnd = DateTime.parse(event.end!);

    return CalendarEvent(
      dateTimeRange: DateTimeRange(start: localStart, end: localEnd),
      data: Event(title: '', color: Colors.amber),
    );
  }).toList();
}

List<CalendarEvent> convertInstructorToEvent(List<Session> list) {
  return list.map((event) {
    final DateTime localStart = DateTime.parse(event.start!);
    final DateTime localEnd = DateTime.parse(event.end!);

    return CalendarEvent(
      dateTimeRange: DateTimeRange(start: localStart, end: localEnd),
      data: Event(title: '', color: Colors.blueAccent),
    );
  }).toList();
}

List<CalendarEvent> mergeAllEventsNew(
  List<Session> StudentSessions,
  List<Session> instructorSessions,
  List<UnavailableTime> unavailableTimes,
) {
  List<CalendarEvent> all = [
    ...convertSessionsToEvent(StudentSessions),
    ...convertInstructorToEvent(instructorSessions),
    ...getRepeatingEvents(unavailableTimes).cast<CalendarEvent<Object>>(),
  ];

  return all;
}

List<Object> getRepeatingEvents(List<UnavailableTime> unavailableTimes) {
  List<Object> events = [];

  for (var unavailableTime in unavailableTimes) {
    int weekday = _getWeekdayFromString(unavailableTime.day);
    DateTime currentStartTime = unavailableTime.start.toLocal();
    DateTime currentEndTime = unavailableTime.end.toLocal();
    DateTime localStart = DateTime(
      currentStartTime.year,
      currentStartTime.month,
      currentStartTime.day,
      currentStartTime.hour,
      currentStartTime.minute,
    );
    DateTime localEnd = DateTime(
      currentEndTime.year,
      currentEndTime.month,
      currentEndTime.day,
      currentEndTime.hour,
      currentEndTime.minute,
    );
    for (int i = 0; i < 12; i++) {
      DateTime eventDate = _getNextWeekdayDate(weekday, localStart);
      events.add(
        CalendarEvent(
          dateTimeRange: DateTimeRange(
            start: eventDate,
            end: eventDate.add(
              Duration(minutes: localEnd.difference(localStart).inMinutes),
            ),
          ),
          data: Event(
            title: '${unavailableTime.id}',
            color: const Color.fromARGB(255, 255, 68, 68),
          ),
        ),
      );
      localStart = localStart.add(Duration(days: 7));
      localEnd = localEnd.add(Duration(days: 7));
    }
  }
  return events;
}

int _getWeekdayFromString(String dayOfWeek) {
  switch (dayOfWeek.toLowerCase()) {
    case 'monday':
      return DateTime.monday;
    case 'tuesday':
      return DateTime.tuesday;
    case 'wednesday':
      return DateTime.wednesday;
    case 'thursday':
      return DateTime.thursday;
    case 'friday':
      return DateTime.friday;
    case 'saturday':
      return DateTime.saturday;
    case 'sunday':
      return DateTime.sunday;
    default:
      throw ArgumentError('Invalid day of the week: $dayOfWeek');
  }
}

DateTime _getNextWeekdayDate(int weekday, DateTime referenceDate) {
  int daysToAdd = (weekday - referenceDate.weekday + 7) % 7;
  return referenceDate.add(Duration(days: daysToAdd));
}
