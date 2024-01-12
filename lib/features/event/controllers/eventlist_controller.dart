import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../dashboard/controllers/location_controller.dart';
import '../data/models/event_list_response.dart';
import '../data/services/events_services.dart';

final eventsListApiProvider =
    StateNotifierProvider<EventListApiController, EventsListApiStates>((ref) {
  final service = ref.watch(eventServiceProvider);
  final location = ref.watch(userLocationProvider);
  return EventListApiController(service, location);
});

class EventListApiController extends StateNotifier<EventsListApiStates> {
  final EventsServices _services;
  final LocationStates _userLocation;
  EventListApiController(this._services, this._userLocation)
      : super(EventsListApiLoading()) {
    getEvents();
  }

  getEvents() async {
    try {
      state = EventsListApiLoading();

      if (_userLocation is LocationLoaded) {
        final location = _userLocation as LocationLoaded;
        final newList = await _services.getAllEvents(location.cityName,
            lat: location.lat, lng: location.lng);
        final newL =
            newList.where((element) => element.status != 'Inactive').toList();

        state = EventsListApiLoaded(newL);
      } else {
        state = EventsListApiError('Location data unavailable!');
      }
    } catch (e) {
      if (mounted) {
        state = EventsListApiError(e.toString());
      }
    }
  }
}

abstract class EventsListApiStates {}

class EventsListApiLoading extends EventsListApiStates {}

class EventsListApiLoaded extends EventsListApiStates {
  final List<EventDataApi> events;

  EventsListApiLoaded(this.events);
}

class EventsListApiError extends EventsListApiStates {
  final String msg;
  EventsListApiError(this.msg);
}
