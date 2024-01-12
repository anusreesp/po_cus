import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/authentication/data/service/firebase_auth_service.dart';
import 'package:htp_customer/features/booking/data/models/booking_details.dart';
import 'package:htp_customer/features/booking/data/models/booking_response.dart';
import '../../../../networking/http_client.dart';
import '../models/guest_model.dart';

final bookingServiceProvider = Provider.autoDispose((ref) {
  final client = ref.watch(clientProvider);
  final auth = ref.watch(firebaseAuthServiceProvider);
  return BookingService(client, auth);
});

class BookingService {
  final NetworkClient _client;
  final FirebaseAuthenticate _auth;
  BookingService(this._client, this._auth);

  final _fire = FirebaseFirestore.instance;

//Define all functions below
  getDrinkDetails() async {}

  getSmokeDetails() async {}

  getGuestsDetails() async {}

  Future<BookingResponse> submitTableBooking(
      {required String clubId,
      required String clubName,
      required String date,
      required List<GuestModel> guest,
      required List<Map<String, dynamic>> products,
      // required int amount,
      required String arrivalTime,
      Map<String, dynamic>? table}) async {
    try {
      final requestData = {
        "booking_type": "table_booking",
        "user_id": _auth.uid,
        "club_id": clubId,
        "club_name": clubName,
        "booking_date": date,
        "attendee_count": guest.length,
        "amount": 0,
        "expected_arrival_time": arrivalTime,
        "preferred_products": products,
        "people": guest.map((e) => e.toJson()).toList(),
        "tables": [
          if (table != null)
            {
              "table_type": table['name'],
              "count": table['count'],
              "minimum_spend": table['minimum_spent']
            }
        ]
      };
      print(requestData);
      final response =
          await _client.postRequest('/booking/v2/clubBooking', requestData);
      print(response.data);
      final data = BookingResponse.fromJson(response.data);
      return data;
    } catch (_) {
      rethrow;
    }
  }

  Future<BookingResponse> submitEntryBooking({
    required String clubId,
    required String clubName,
    required String date,
    required List<GuestModel> guest,
    required String arrivalTime,
  }) async {
    try {
      final requestData = {
        "booking_type": "club_entry_booking",
        "user_id": _auth.uid,
        "club_id": clubId,
        "club_name": clubName,
        "booking_date": date,
        "attendee_count": guest.length,
        "amount": 0,
        "expected_arrival_time": arrivalTime,
        "people": guest.map((e) => e.toJson()).toList(),
      };
      print(requestData);
      final response =
          await _client.postRequest('/booking/v2/clubBooking', requestData);
      print(response.data);
      final data = BookingResponse.fromJson(response.data);
      return data;
    } catch (_) {
      rethrow;
    }
  }

  Future<BookingResponse> submitEventBooking(String eventId,
      List<GuestModel> guest, String eventName, num amount) async {
    try {
      final requestData = {
        "booking_type": "event_entry_booking",
        "user_id": _auth.uid,
        "event_id": eventId,
        "event_name": eventName,
        "attendee_count": guest.length,
        // "booking_date": DateFormat('yyyy-MM-dd').format(eventDate),
        "amount": amount,
        "people": guest.map((e) => e.toJson()).toList(),
      };
      final response =
          await _client.postRequest('/booking/v2/eventBooking', requestData);
      print(response.data);
      return BookingResponse.fromJson(response.data);
    } catch (_) {
      rethrow;
    }
  }

  // Future<BookingResponseData> getEventBookingData(String id) async{
  //   try{
  //     final snapshot = await _fire.collection('event_entry_bookings').doc(id).get();
  //     final eventData = EventBookingData.fromJson(snapshot.data()!);
  //     final eventRef = eventData.eventRef as DocumentReference;
  //     final eventSnapshot = await eventRef.get();
  //     final event = EventModel.fromJson(eventSnapshot.data()! as Map<String, dynamic>);
  //     //City
  //     // final clubRef = event.clubRef as DocumentReference;
  //     // final clubSnapshot = await clubRef.get();
  //     // final clubMap = clubSnapshot.data() as Map<String, dynamic>?;
  //     // final cityRef = clubMap?['city'] == null ? null : clubMap!['city'] as DocumentReference;
  //     // final cityDoc = await cityRef?.get();
  //     // final city = cityDoc?.data();
  //     // final cityName = city != null ? (city as Map<String, dynamic>)['name'] : null;
  //
  //     return BookingResponseData(
  //         data: BookingDetailsModel(
  //           bookingDate: event.eventData,
  //           attendeeCount: eventData.attendeeCount,
  //           bookingId: eventData.bookingId,
  //           bookingStatus: eventData.bookingStatus,
  //           id: eventData.id,
  //         ),
  //         cityName: 'Not available',
  //         clubName: event.name);
  //   }catch(_){
  //     rethrow;
  //   }
  // }

  Future<BookingResponseData> getBookingData(String id, String type) async {
    try {
      debugPrint(
          '------------------------/booking/v2/bookingDetails?id=$id&type=$type');

      final response = await _client
          .getRequest('/booking/v2/bookingDetails?id=$id&type=$type');
      return BookingResponseData.fromJson(response.data);
      // final snapshot = await _fire.collection('club_entry_bookings').doc(id).get();
      // final bookingData = BookingDetailsModel.fromJson(snapshot.data()!);
      //
      // final clubRef = bookingData.clubRef as DocumentReference;
      // final clubMap = await clubRef.get();
      // final clubName = clubMap['name'];
      // final cityRef = clubMap['city'] as DocumentReference;
      // final cityMap = await cityRef.get();
      // final cityName = cityMap["name"];
      // return BookingResponseData(data: bookingData, cityName: cityName, clubName: clubName);

      // final response = await _client.getRequest(
      //     '/booking/v1/bookingDetails?id=e3da6e87-d598-45cb-8dcc-d75b766931da');
      // final data = BookingDetailsResponse.fromJson(response.data);
      // return data.data.first;
      // return BookingData(id: 'id', user: 'user', club: 'club', amount: 22, bookingDate: DateTime.now(), attendeeCount: 2, bookingId: 'bookingId', bookingStatus: 'bookingStatus', checkedIn: false, qrCode: 'qrCode', clubName: 'clubName', clubAddress: 'clubAddress', clubCity: 'clubCity', userName: 'userName', userProfileImage: 'userProfileImage', bookingPeople: [], preferredProducts: []);
    } catch (_) {
      rethrow;
    }
  }
}
