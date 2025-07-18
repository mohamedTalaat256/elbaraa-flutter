 
import 'package:elbaraa/presentation/screens/calendar/data/event.dart';
import 'package:elbaraa/presentation/screens/calendar/widgets/tile/resize_handles.dart';
import 'package:elbaraa/presentation/screens/calendar/widgets/tile/tiles.dart';
import 'package:flutter/material.dart';
import 'package:kalender/kalender.dart'; 
TileComponents<Event> get multiDayBodyComponents {
  const margin = EdgeInsets.symmetric(horizontal: 0);
  const titlePadding = EdgeInsets.all(0);
  return TileComponents(
    tileBuilder: (event, tileRange) => EventTile(event: event, margin: margin, titlePadding: titlePadding),
    dropTargetTile: (event) => DropTargetTile(event: event, margin: margin),
    tileWhenDraggingBuilder: (event) => TileWhenDragging(event: event, margin: margin),
    feedbackTileBuilder: (event, size) => FeedbackTile(event: event, margin: margin, size: size),
    horizontalResizeHandle: const HorizontalResizeHandle(),
    verticalResizeHandle: const VerticalResizeHandle(),
  );
}

TileComponents<Event> get multiDayHeaderTileComponents {
  const margin = EdgeInsets.symmetric(vertical: 0);
  const titlePadding = EdgeInsets.symmetric(vertical: 0, horizontal: 0);
  return TileComponents(
    tileBuilder: (event, tileRange) => EventTile(event: event, margin: margin, titlePadding: titlePadding),
    dropTargetTile: (event) => DropTargetTile(event: event, margin: margin),
    tileWhenDraggingBuilder: (event) => TileWhenDragging(event: event, margin: margin),
    feedbackTileBuilder: (event, size) => FeedbackTile(event: event, margin: margin, size: size),
    horizontalResizeHandle: const HorizontalResizeHandle(),
    verticalResizeHandle: const VerticalResizeHandle(),
  );
}

ScheduleTileComponents<Event> get scheduleTileComponents {
  const margin = EdgeInsets.symmetric(vertical: 0);
  const titlePadding = EdgeInsets.all(0);
  return ScheduleTileComponents(
    tileBuilder: (event, tileRange) => EventTile(event: event, margin: margin, titlePadding: titlePadding),
    dropTargetTile: (event) => DropTargetTile(event: event, margin: margin),
    tileWhenDraggingBuilder: (event) => TileWhenDragging(event: event, margin: margin),
    feedbackTileBuilder: (event, size) => FeedbackTile(event: event, margin: margin, size: size),
  );
}
