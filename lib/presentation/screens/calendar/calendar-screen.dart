import 'package:elbaraa/data/business_logic/session/session_cubit.dart';
import 'package:elbaraa/data/business_logic/session/session_state.dart';
import 'package:elbaraa/data/models/session.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:localization/localization.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final CalendarController _calendarController = CalendarController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<SessionCubit>(context).getUserCalendar();
    _calendarController.view = CalendarView.week; // default view
  }

  late List<Meeting> _meetings = [];
  final ValueNotifier<int> _tabIndexBasicToggleCounter = ValueNotifier(1);
  final CalendarView _calendarView = CalendarView.week;
  late final _listTextTabToggleCounter = [
    DataTab(
      title: "today".i18n(),
      counterWidget: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: Text(
              "1",
              style: Theme.of(
                context,
              ).textTheme.labelSmall?.copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    ),
    DataTab(title: "week".i18n()),
    DataTab(title: "month".i18n()),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(
      builder: (context, state) {
        if (state is SessionsLoaded) {
          _convertSessionsToMeetings(state.sessions);
          return Scaffold(
            appBar: AppBar(
              title: Text("week_calendar".i18n()),
              elevation: 0,
              backgroundColor: Colors.white,
            ),
            body: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 8,
                  ),
                  child: _basicTabToggleWithCounter(),
                ),
                Expanded(
                  child: SfCalendar(
                    controller: _calendarController,
                    view: _calendarView,
                    headerStyle: CalendarHeaderStyle(
                      backgroundColor: Color.fromARGB(255, 255, 255, 255),
                    ),
                    dataSource: MeetingDataSource(_meetings),
                    monthViewSettings: const MonthViewSettings(
                      appointmentDisplayMode:
                          MonthAppointmentDisplayMode.appointment,
                    ),
                    onTap: (CalendarTapDetails details) {
                      if (details.targetElement ==
                          CalendarElement.calendarCell) {
                        final DateTime selectedDate = details.date!;
                        _showAddEventDialog(context, selectedDate);
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return Text("data");
        }
      },
    );
  }

  void _convertSessionsToMeetings(List<Session> sessions) {
    _meetings = sessions.map((session) {
      return Meeting(
        session.subscription!.plan!.title,
        DateTime.parse(session.start!),
        DateTime.parse(session.end!),
      );
    }).toList();
  }

  void _showAddEventDialog(BuildContext context, DateTime selectedDate) {
    final TextEditingController _titleController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Event"),
          content: TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Event Title'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                final newMeeting = Meeting(
                  _titleController.text,
                  selectedDate,
                  selectedDate.add(const Duration(hours: 1)),
                );

                setState(() {
                  _meetings.add(newMeeting);
                });

                Navigator.pop(context);
              },
              child: Text('save'.i18n()),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('close'.i18n()),
            ),
          ],
        );
      },
    );
  }

  Widget _basicTabToggleWithCounter() => Column(
    children: [
      ValueListenableBuilder(
        valueListenable: _tabIndexBasicToggleCounter,
        builder: (context, currentIndex, _) {
          return FlutterToggleTab(
            width: 90,
            borderRadius: 30,
            height: 40,
            selectedIndex: currentIndex,
            selectedBackgroundColors: const [Colors.blue, Colors.blueAccent],
            selectedTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
            unSelectedTextStyle: const TextStyle(
              color: Colors.black87,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            dataTabs: _listTextTabToggleCounter,
            selectedLabelIndex: (index) {
              _tabIndexBasicToggleCounter.value = index;
              _tabIndexBasicToggleCounter.value = index;
              setState(() {
                switch (index) {
                  case 0:
                    _calendarController.view = CalendarView.day;
                    break;
                  case 1:
                    _calendarController.view = CalendarView.week;
                    break;
                  case 2:
                    _calendarController.view = CalendarView.month;
                    break;
                }
                print(_calendarView);
              });
            },

            isScroll: false,
          );
        },
      ),
    ],
  );
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
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
    return false; //appointments![index].isAllDay;
  }
}

class Meeting {
  Meeting(this.title, this.start, this.end);

  String title;
  DateTime start;
  DateTime end;
}
