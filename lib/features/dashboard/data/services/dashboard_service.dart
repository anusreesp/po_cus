import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/features/dashboard/data/models/ad_banners.dart';
import 'package:htp_customer/features/dashboard/data/models/app_settings.dart';
import 'package:htp_customer/features/dashboard/data/models/notifications_model.dart';
import 'package:htp_customer/features/dashboard/data/models/search_result.dart';
import 'package:uuid/uuid.dart';

import '../../../../networking/http_client.dart';
import '../models/popups_model.dart';

final dashboardServiceProvider = Provider((ref) {
  final client = ref.watch(clientProvider);
  return DashboardService(client);
});

class DashboardService {
  final NetworkClient _client;
  DashboardService(this._client);

  final _fire = FirebaseFirestore.instance;
  ///
  Future<List<SearchResult>> getSearchResult(String pattern) async{
    final response = await _client.getRequest('/elastic/v1/search?search_string=$pattern');
    final data = SearchResultResponse.fromJson(response.data);
    return data.data;
    // List<SearchResult> results = [];
    // final lowerPattern = pattern.toLowerCase();
    // // final titlePattern = lowerPattern.toTitleCase();
    // try{
    //   // final clubs = await _fire.collection('clubs').limit(4).startAt([pattern]).get();
    //   // final clubs = await _fire.collection('clubs').orderBy('name').startAt([titlePattern]).endAt(['$titlePattern\uf8ff']).limit(4).get();
    //   final clubs = await _fire.collection('clubs')
    //       .orderBy('name_lower_case')
    //       .startAt([lowerPattern]).endAt(['$lowerPattern\uf8ff'])
    //       .where('status', isEqualTo: 'Active')
    //       .limit(4).get();
    //   // final events = await _fire.collection('events')
    //   //     .orderBy('name')
    //   //     .startAt([titlePattern]).endAt(['$titlePattern\uf8ff'])
    //   //     // .where('date_and_time', isGreaterThanOrEqualTo: Timestamp.fromDate(DateTime.now()))
    //   //     .limit(4).get();
    //   final events = await _fire.collection('events')
    //       .orderBy('name_lowercase')
    //       .startAt([lowerPattern])
    //       .endAt(['$lowerPattern\uf8ff'])
    //       // .where('date_and_time', isGreaterThanOrEqualTo: Timestamp.fromDate(DateTime.now()))
    //       .limit(4).get();
    //   for(final item in clubs.docs){
    //     final data = item.data();
    //     results.add(SearchResult(
    //         id: data['id'],
    //         name: data['name'],
    //         city: data['city_name'],
    //         type: SearchType.club));
    //   }
    //   for(final item in events.docs){
    //     final data = item.data();
    //     final eventTimeStamp = data['date_and_time'] as Timestamp;
    //     final eventDate = eventTimeStamp.toDate();
    //     if(eventDate.isAfter(DateTime.now())){
    //       results.add(SearchResult(
    //         id: data['id'],
    //         name: data['name'],
    //         city: data['city_name_lower_case'],
    //         type: SearchType.event,));
    //     }
    //   }
    //
    //   //Location search
    //   final cities = await _fire.collection('cities')
    //   .where('party_location', isEqualTo: true)
    //       .orderBy('name_lower_case')
    //       .startAt([lowerPattern])
    //       .endAt(['$lowerPattern\uf8ff'])
    //       .limit(4).get();
    //   for(final city in cities.docs){
    //     final data = city.data();
    //     results.add(SearchResult(id: data['id'], name: data['name'], type: SearchType.location));
    //   }
    //
    //   results.shuffle();
    //   return results;
    //   // clubs.docs.forEach((element) {print(element.data());});
    // }catch(e){
    //   print(e.toString());
    //   rethrow;
    // }
  }

  Future<List<AdBanner>> getAdBanner(String? cityName) async{
    List<AdBanner> adsList = [];
    try{
      final globalAdsResponse = await _fire.collection('advertisements')
          .where('status', isEqualTo: 'Active')
          .where('global', isEqualTo: true)
          .get();
      final globalAds = List<AdBanner>.from(globalAdsResponse.docs.map((e) => AdBanner.fromJson(e.data())));
      adsList = globalAds;

      if(cityName != null){
        final cityAdsResponse = await _fire.collection('advertisements')
            .where('status', isEqualTo: 'Active')
            .where('cities', arrayContains: cityName)
            .get();
        final citySpecificAds = List<AdBanner>.from(cityAdsResponse.docs.map((e) => AdBanner.fromJson(e.data())));
        adsList = [...adsList, ...citySpecificAds];
      }

      return adsList;
    }catch(_){
      rethrow;
    }
  }

  Future<void> contactRequest({
    required String name,
    required String mobile,
    required String email,
    required String message
}) async{
    try{
      await _client.postRequest('/contact_us/v1/contact', {
        "name":name,
        "mobile_no":mobile,
        "email_id":email,
        "message":message
      });
    }catch(e){
      rethrow;
    }
  }

  Future<List<NotificationsModel>> getAllNotifications(String uid) async{
    // print(uid);
    try{
      final snapshot = await _fire.collection('notifications').where('user', isEqualTo: uid).orderBy('createdAt', descending: true).get();
      // snapshot.docs.forEach((element) {
        // print("+++++++++++++++++================${element.data()}");
      // });
      return List<NotificationsModel>.from(snapshot.docs.map((e) => NotificationsModel.fromJson(e.data())));
    }catch(_){
      rethrow;
    }
  }

  Future<void> deleteNotification(String id) async{
    print("DELETE ID $id");
    try{
      await _fire.collection('notifications').doc(id).delete();
    }catch(e){
      rethrow;
    }
  }

  Future<void> updateNotificationRead(String id) async{
    try{
      await _fire.collection('notifications').doc(id).update({
        'read_status': true,
        'updatedAt': FieldValue.serverTimestamp()
      });
    }catch(_){
      rethrow;
    }
  }

  Future<File> downloadIntroVideo(String videoUrl)async{
    try{
      final location = await _client.downloadVideoFile(videoUrl, 'intro.mp4');
      return File(location);
    }catch(_){
      rethrow;
    }
  }

  Future<String?> getVideoUrl()async{
    try{
      final response = await _fire.collection('videos').get();
      if(response.docs.isNotEmpty){
        final data = response.docs.first.data();
        if(data.containsKey('video_url')){
          return data['video_url'];
        }
      }
      return null;
    }on FirebaseException catch(e){
      throw e.message ?? e.code;
    }catch(_){
      rethrow;
    }
  }

  Future<AppSettings> getAppSettings() async{
    try{
      final response = await _fire.collection('app_settings').doc('updates').get();
      return AppSettings.fromJson(response.data()!);
    }on FirebaseException catch(e){
      throw e.message ?? e.code;
    }catch(_){
      rethrow;
    }
  }

  Future<List<PopupsModels>> getPopups() async{
    try{
      final response = await _fire.collection('popups').get();
      // print(">>>>>>>>>>>>>:${response.docs[0].data()}");
      return response.docs.map((e) => PopupsModels.fromJson(e.data())).toList();
    }on FirebaseException catch(e){
      throw e.message ?? e.code;
    }catch(_){
      rethrow;
    }
  }

  Future<void> saveCurrentLocation(String city, country, uid)async{
    if(uid == ''){ //if user data is not available return
      return;
    }
    try{
      await _fire.collection('users').doc(uid).update({
        'active_location': {
          'city_name': city,
          'country_name': country
        }
      });
    }catch(e){
      //
    }
  }

  Future<void> saveLocationHistory(String city, country, uid)async {
    if(uid == ''){ //if user data is not available return
      return;
    }
    try {
      final id = const Uuid().v4();
      await _fire.collection('users').doc(uid).collection('location_history').doc(id).set({
        'city_name': city,
        'country_name': country,
        'createdAt': FieldValue.serverTimestamp(),
        'id': id
      });
    } catch (e) {
      //
    }
  }

  Future<Map<String,dynamic>?> getSupportDetails()async{
    try{
      final response = await _fire.collection("support").doc('contact').get();
      print(">>>>>>>>>>>>>>>${response.data()}");
      return response.data();
    }catch(err){
      rethrow;
    }
  }
}






//--------------------------------Advertisement Images--------------------
// final AdvertisingImageServiceProvider = Provider((ref) {
//   return;
// });

// class AdvertisingImageServices {
//   final NetworkClient _client;
//   AdvertisingImageServices(this._client);
//
//   Future getAllAdvImages() async {
//     try {
//       final response = await _client.getRequest("");
//     } catch (e) {
//       rethrow;
//     }
//   }
// }
