import 'dart:io';

import 'package:elbaraa/presentation/screens/calendar/data/event.dart';
import 'package:elbaraa/presentation/screens/calendar/widgets/overlay_card.dart';
import 'package:elbaraa/presentation/screens/calendar/widgets/tile_components.dart';
import 'package:elbaraa/presentation/screens/calendar/widgets/zoom.dart';
import 'package:flutter/material.dart';
import 'package:kalender/kalender.dart';
import 'package:localization/localization.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});
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
  void initState() {
    super.initState();
    addWeeklyRecurringEvent(  DateTime.now(),   10);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('week_calendar'.i18n()),
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
        child: ValueListenableBuilder(
          valueListenable: viewConfiguration1,
          builder: (context, value, child) {
            return CalendarView<Event>(
              eventsController: eventsController,
              calendarController: controller1,
              viewConfiguration: value,
              callbacks: callbacks,
              header: Material(
                color: Theme.of(context).colorScheme.surface,
                surfaceTintColor: Theme.of(context).colorScheme.surfaceTint,
                elevation: 2,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 4,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ValueListenableBuilder(
                            valueListenable:
                                controller1.visibleDateTimeRangeUtc,
                            builder: (context, value, child) {
                              final String month;
                              final int year;

                              if (controller1.viewController?.viewConfiguration
                                  is MonthViewConfiguration) {
                                final secondWeek = value.start.addDays(7);
                                year = secondWeek.year;
                                month = secondWeek.monthNameLocalized();
                              } else {
                                year = value.start.year;
                                month = value.start.monthNameLocalized();
                              }

                              return FilledButton.tonal(
                                onPressed: () {},
                                style: FilledButton.styleFrom(
                                  minimumSize: const Size(
                                    150,
                                    kMinInteractiveDimension,
                                  ),
                                ),
                                child: Text('$month $year'),
                              );
                            },
                          ),
                          if (!Platform.isAndroid && !Platform.isIOS) ...[
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
                          ],
                          const SizedBox(width: 4),
                          IconButton.filledTonal(
                            onPressed: () {
                              controller1.animateToDate(DateTime.now());
                            },
                            icon: const Icon(Icons.today),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                DropdownMenu(
                                  dropdownMenuEntries:
                                      viewConfigurations.map((e) {
                                        return DropdownMenuEntry(
                                          value: e,
                                          label: e.name,
                                        );
                                      }).toList(),
                                  inputDecorationTheme: InputDecorationTheme(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                        kMinInteractiveDimension,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                        kMinInteractiveDimension,
                                      ),
                                      borderSide: BorderSide(
                                        width: 2,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.outline,
                                      ),
                                    ),
                                  ),
                                  initialSelection: viewConfiguration1.value,
                                  onSelected: (value) {
                                    if (value == null) return;
                                    viewConfiguration1.value = value;
                                  },
                                ),
                              ],
                            ),
                          ),
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
            );
          },
        )
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

  void addWeeklyRecurringEvent( DateTime fromDate, int weeksCount, ) {
     
      DateTime nextMonday = fromDate.weekday == DateTime.monday
          ? fromDate
          : fromDate.add(Duration(days: 0));

      for (int i = 0; i < weeksCount; i++) {
        final start = DateTime(
          nextMonday.year,
          nextMonday.month,
          nextMonday.day,
          14, // 2 PM
        ).add(Duration(days: i * 7));

        final end = start.add(Duration(hours: 5)); // 3 PM

        eventsController.addEvent(
          CalendarEvent(
            dateTimeRange: DateTimeRange(start: start, end: end),
            data: const Event(title: '', color: Colors.amber),
          ),
        );
      }
    }
}
