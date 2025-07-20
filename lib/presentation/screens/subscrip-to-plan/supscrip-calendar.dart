import 'package:elbaraa/presentation/screens/calendar/data/event.dart';
import 'package:elbaraa/presentation/screens/calendar/widgets/overlay_card.dart';
import 'package:elbaraa/presentation/screens/calendar/widgets/tile_components.dart';
import 'package:elbaraa/presentation/screens/calendar/widgets/zoom.dart';
import 'package:flutter/material.dart';
import 'package:kalender/kalender.dart';

class SubscripCalendar extends StatefulWidget {
  final List<Object?> calendarEvents;

  const SubscripCalendar({super.key, required this.calendarEvents});

  @override
  State<SubscripCalendar> createState() => _SubscripCalendarState();
}

class _SubscripCalendarState extends State<SubscripCalendar> {
  final eventsController = DefaultEventsController<Event>();
  final controller1 = CalendarController<Event>();

  late final callbacks = CalendarCallbacks<Event>(
    onEventTapped: (event, renderBox) => createOverlay(event, renderBox),
    onEventCreate: (event) => event.copyWith(data: Event(title: 'New Event')),
    onEventCreated: (event) => eventsController.addEvent(event),
    onTapped: (date) {
      eventsController.addEvent(
        CalendarEvent(
          dateTimeRange: DateTimeRange(
            start: date,
            end: date.add(const Duration(hours: 1)),
          ),
          data: const Event(title: 'New Event'),
        ),
      );
    },
    onMultiDayTapped: (dateRange) {
      eventsController.addEvent(
        CalendarEvent(
          dateTimeRange: dateRange,
          data: const Event(title: 'New Event'),
        ),
      );
    },
  );

 

@override
void didUpdateWidget(covariant SubscripCalendar oldWidget) {
  super.didUpdateWidget(oldWidget);

  if (widget.calendarEvents != oldWidget.calendarEvents) {
    final castedEvents = widget.calendarEvents.cast<CalendarEvent<Event>>();
    eventsController.clearEvents();
    eventsController.addEvents(castedEvents);
  }
}
  @override
  Widget build(BuildContext context) {
    return OverlayPortal(
      controller: portalController,
      overlayChildBuilder: buildOverlay,
      child: CalendarView<Event>(
        
        eventsController: eventsController,
        calendarController: controller1,
        viewConfiguration: MultiDayViewConfiguration.week(firstDayOfWeek: 6),
        callbacks: callbacks,
        header: Material(
          color: Colors.white,
          surfaceTintColor: Colors.white,
          
          elevation: 2,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                   /*  if (!Platform.isAndroid && !Platform.isIOS) ...[
                      const SizedBox(width: 4),
                      IconButton.filledTonal(
                        onPressed: () async {
                          await controller1.animateToPreviousPage();
                        },
                        icon: const Icon(Icons.navigate_before),
                      ),
                    ],
                    if (!Platform.isAndroid && !Platform.isIOS) ...[
                      const SizedBox(width: 4),
                      IconButton.filledTonal(
                        onPressed: () {
                          controller1.animateToNextPage();
                        },
                        icon: const Icon(Icons.navigate_next),
                      ),
                    ], */
                  ],
                ),
              ),
              CalendarHeader(
                multiDayTileComponents: multiDayHeaderTileComponents,
              ),
            ],
          ),
        ),
        body: CalendarZoomDetector(
          controller: controller1,
          child: CalendarBody(
            multiDayTileComponents: multiDayBodyComponents,
            monthTileComponents: multiDayHeaderTileComponents,
            scheduleTileComponents: scheduleTileComponents,
          ),
        ),
      ),
    );
  }

  final portalController = OverlayPortalController();
  CalendarEvent<Event>? selectedEvent;
  RenderBox? selectedRenderBox;

  void createOverlay(CalendarEvent<Event> event, RenderBox renderBox) {
    selectedEvent = event;
    selectedRenderBox = renderBox;
    portalController.show();
  }

  Widget buildOverlay(BuildContext overlayContext) {
    var position = selectedRenderBox!.localToGlobal(Offset.zero);
    const height = 230.0;
    const width = 300.0;

    final size = MediaQuery.sizeOf(context);

    if (position.dy + height > size.height) {
      position = position.translate(
        0,
        size.height - (position.dy + height) - 25,
      );
    } else if (position.dy < 0) {
      position = position.translate(0, -position.dy);
    }

    if (position.dx + width + selectedRenderBox!.size.width > size.width) {
      position = position.translate(-width - 16, 0);
    } else {
      position = position.translate(selectedRenderBox!.size.width, 0);
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned.fill(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: portalController.hide,
          ),
        ),
        Positioned(
          top: position.dy,
          left: position.dx,
          child: OverlayCard(
            event: selectedEvent!,
            position: position,
            height: height,
            width: width,
            onDismiss: portalController.hide,
            eventsController: eventsController,
          ),
        ),
      ],
    );
  }

   
}
