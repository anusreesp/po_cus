import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/features/event/controllers/event_list_controller.dart';
import 'package:htp_customer/features/event/data/models/event_list_response.dart';
import 'package:intl/intl.dart';

import 'eventlist_controller.dart';

enum FilterEnum {
  allTime,
  today,
  tomorrow,
}

final eventsFilterListProvider =
    StateNotifierProvider<EventsFilterController, List<EventDataApi>>((ref) {
  final eventListApiController = ref.watch(eventsListApiProvider);

  if (eventListApiController is EventsListApiLoaded) {
    return EventsFilterController(eventListApiController.events);
  } else {
    return EventsFilterController([]);
  }
});

class EventsFilterController extends StateNotifier<List<EventDataApi>> {
  final List<EventDataApi> eventList;

  EventsFilterController(this.eventList) : super(eventList);

  FilterEnum? selectedFilter;

  filterEvents(FilterEnum filterType) {
    selectedFilter = filterType;

    switch (filterType) {
      case FilterEnum.today:
        todaySort();
        break;

      case FilterEnum.tomorrow:
        tomorrowSort();
        break;

      case FilterEnum.allTime:
        allTimeSort();
        break;
    }
  }

  allTimeSort() {
    debugPrint("allTimeSort");
    state = eventList;
  }

  todaySort() {
    debugPrint("today");

    final today = DateFormat('dd MMMM yyyy').format(DateTime.now());
    List<EventDataApi> list = eventList
        .where((element) =>
            (DateFormat('dd MMMM yyyy').format(element.dateAndTime) == today))
        .toList();

    state = list;
  }

  tomorrowSort() {
    debugPrint("tomorrow");
    final tomarrow = DateFormat('dd MMMM yyyy')
        .format(DateTime.now().add(const Duration(days: 1)));
    List<EventDataApi> list = eventList
        .where((element) =>
            (DateFormat('dd MMMM yyyy').format(element.dateAndTime) ==
                tomarrow))
        .toList();

    state = list;
  }
}
