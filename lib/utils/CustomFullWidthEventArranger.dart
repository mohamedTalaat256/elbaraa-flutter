/* import 'package:calendar_view/calendar_view.dart';

class FixedSizeEventArranger extends EventArranger {
  @override
  List<PositionedEvent> arrange(
    List<CalendarEventData> events,
    double heightPerMinute,
  ) {
    List<PositionedEvent> arrangedEvents = [];

    const double fixedWidth = 150.0;
    const double horizontalGap = 5.0;

    for (int index = 0; index < events.length; index++) {
      final event = events[index];
      final startMinutes = event.startTime.hour * 60 + event.startTime.minute;
      final endMinutes = event.endTime.hour * 60 + event.endTime.minute;

      final top = startMinutes * heightPerMinute;
      final height = (endMinutes - startMinutes) * heightPerMinute;
      final left = index * (fixedWidth + horizontalGap);

      arrangedEvents.add(PositionedEvent(
        left: left,
        top: top,
        width: fixedWidth,
        height: height,
        event: event,
      ));
    }

    return arrangedEvents;
  }
}
 */