import 'package:elbaraa/data/models/session.model.dart';
import 'package:elbaraa/data/models/unavailableTime.model.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

List<Appointment> modifyListTimesAfterChangeTimeZoneUnavailableTimes(
  List<UnavailableTime> list,
) { 
   final seen = <String>{};

  final filteredList = list.where((event) {
    final key = '${event.day}_${event.start.toIso8601String()}_${event.end.toIso8601String()}';
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
    List<Appointment> all =[
      ...modifyStudentSessionsAfterChangeTimeZone(StudentSessions),
      ...modifySessionsAfterChangeTimeZone(instructorSessions),
     ...modifyListTimesAfterChangeTimeZoneUnavailableTimes(unavailableTimes),
  ];

  all.sort((a, b) =>
    a.endTime.difference(a.startTime).inMinutes.compareTo(
      b.endTime.difference(b.startTime).inMinutes
    )
  );

  return all;
}