import 'package:flutter/material.dart';
import '../models/event_model.dart';

/// Global saved events state using ValueNotifier
class SavedEventsState {
  static final ValueNotifier<List<EventModel>> savedEvents =
      ValueNotifier<List<EventModel>>([]);

  static bool isSaved(EventModel event) {
    return savedEvents.value.any((e) => e.title == event.title);
  }

  static void toggle(EventModel event) {
    final list = List<EventModel>.from(savedEvents.value);
    if (isSaved(event)) {
      list.removeWhere((e) => e.title == event.title);
    } else {
      list.add(event);
    }
    savedEvents.value = list;
  }

  static void remove(EventModel event) {
    final list = List<EventModel>.from(savedEvents.value);
    list.removeWhere((e) => e.title == event.title);
    savedEvents.value = list;
  }
}
