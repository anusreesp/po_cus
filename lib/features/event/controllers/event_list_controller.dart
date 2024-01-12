import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/features/dashboard/controllers/location_controller.dart';
import 'package:htp_customer/features/event/data/models/event_list_response.dart';
import 'package:htp_customer/features/event/data/services/events_services.dart';

final eventListProvider = FutureProvider<List<EventDataApi>>((ref) async {
  final service = ref.watch(eventServiceProvider);
  final location = ref.watch(userLocationProvider);
  if (location is LocationLoaded) {
    return await service.getAllEvents(location.cityName,
        lat: location.lat, lng: location.lng);
  }

  return [];
});

// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:htp_customer/features/event/data/models/event_model.dart';
// import 'package:htp_customer/features/event/data/services/events_services.dart';
//
// final eventListProvider = StateNotifierProvider((ref) {
//   final service = ref.watch(eventServiceProvider);
//   return EventListController(service);
// });
//
// class EventListController extends StateNotifier<EventListStates> {
//   final EventsServices _services;
//   EventListController(this._services) : super(EventsLoading()) {
//     //Used when call api on page load
//     getClubs();
//   }
//
//   getClubs() async {
//     try {
//       state = EventsLoading();
//       final data = await _services.getAllEvents();
//       state = EventLoaded(data);
//     } catch (e) {
//       state = EventError(e.toString());
//     }
//   }
// }
//
// abstract class EventListStates {}
//
// //Classes for various stages and all will extend abstract class
// class EventsLoading extends EventListStates {}
//
// class EventLoaded extends EventListStates {
//   final List<EventModel> clubs;
//   EventLoaded(this.clubs);
// }
//
// class EventError extends EventListStates {
//   final String msg;
//   EventError(this.msg);
// }
