import 'package:elbaraa/presentation/screens/calendar/data/event.dart';
import 'package:elbaraa/presentation/screens/calendar/widgets/calendar_widget.dart';
import 'package:elbaraa/presentation/screens/calendar/widgets/overlay_card.dart';
import 'package:flutter/material.dart';
import 'package:kalender/kalender.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  static _CalendarScreenState? of(BuildContext context) =>
      context.findAncestorStateOfType<_CalendarScreenState>();

  static EventsController<Event> eventsController(BuildContext context) =>
      of(context)!.eventsController;
  static List<ViewConfiguration> views(BuildContext context) =>
      of(context)!.viewConfigurations;

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final eventsController = DefaultEventsController<Event>();

  final controller1 = CalendarController<Event>();
  late final viewConfiguration1 = ValueNotifier(viewConfigurations[1]);

  final viewConfigurations = [
    MultiDayViewConfiguration.singleDay(),
    MultiDayViewConfiguration.week(),
    MultiDayViewConfiguration.custom(numberOfDays: 3),
    MonthViewConfiguration.singleMonth(),
  ];

  late final callbacks = CalendarCallbacks<Event>(
    onEventTapped: (event, renderBox) => createOverlay(event, renderBox),
    onEventCreate: (event) => event.copyWith(data: const Event(title: 'New Event')),
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kalender Demo"),
        backgroundColor: Theme.of(context).colorScheme.surface,
        surfaceTintColor: Theme.of(context).colorScheme.surfaceTint,
        elevation: 2,
        actions: [
          /*  IconButton.filledTonal(
            onPressed: () => CalendarScreen.of(context)!.toggleTheme(),
            icon: Icon(
              CalendarScreen.of(context)!.themeMode == ThemeMode.dark ? Icons.brightness_2_rounded : Icons.brightness_7_rounded,
            ),
          ), */
        ],
      ),
      body: OverlayPortal(
        controller: portalController,
        overlayChildBuilder: buildOverlay,
        child: CalendarWidget(
          controller: controller1,
          view: viewConfiguration1,
          callbacks: callbacks,
        ),
      ),
    );
  }

  BuildContext get context;

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
