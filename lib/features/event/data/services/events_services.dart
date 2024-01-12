import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/features/event/data/models/event_list_response.dart';
import 'package:htp_customer/features/event/data/models/event_model.dart';

import '../../../../networking/http_client.dart';

final eventServiceProvider = Provider((ref) {
  final client = ref.watch(clientProvider);
  return EventsServices(client);
});

class EventsServices {
  final NetworkClient _client;
  EventsServices(this._client);

  final _db = FirebaseFirestore.instance;

  Future<List<EventDataApi>> getAllEvents(String city,
      {double? lat, double? lng}) async {
    // List<EventModel> events = [];
    try {
      //   final dbRef =await _db.collection('events').limit(40).get();
      //   final data = dbRef.docs;
      //   for(final item in data){
      //     events.add(EventModel.fromJson(item.data()));
      //   }
      //   return events;
      //TODO: Remove below url
      // final url = '/event/v3/events?city_name=Bengaluru&current_lat=28.5491985&current_long=77.3628109';

      debugPrint(city);
      debugPrint("$lat");
      debugPrint("$lng");

      final url = (lat == null || lng == null)
          ? '/event/v3/events?city_name=$city'
          : '/event/v3/events?city_name=$city&current_lat=$lat&current_long=$lng';
      debugPrint("--------------$url");

      final response = await _client.getRequest(url);

      debugPrint("$response");

      final data = EventListApiResponse.fromJson(response.data);
      return data.message;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<EventModel> getSingleEvent(String id) async {
    try {
      final snapshot = await _db.collection('events').doc(id).get();
      // print(snapshot.data());
      return EventModel.fromJson(snapshot.data()!);
    } catch (_) {
      rethrow;
    }
  }

  Future<List<EventModel>> getUpcomingEvents(String currentEventId) async {
    List<EventModel> events = [];
    try {
      final dbRef = await _db
          .collection('events')
          .limit(4)
          .where('date_and_time',
              isGreaterThanOrEqualTo: Timestamp.fromDate(DateTime.now()))
          .get();
      final data = dbRef.docs;
      for (final item in data) {
        if (item.id != currentEventId) {
          events.add(EventModel.fromJson(item.data()));
        }
      }
      return events;
    } catch (_) {
      rethrow;
    }
  }
}
