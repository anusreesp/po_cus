import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/features/clubs/data/models/club_list_api_response.dart';
import 'package:htp_customer/features/clubs/data/models/fire_club_details.dart';
import 'package:htp_customer/features/clubs/data/models/products_model.dart';

import '../../../../authentication/data/service/firebase_auth_service.dart';
import '../../../../networking/http_client.dart';

final clubServiceProvider = Provider<ClubServices>((ref) {
  final client = ref.watch(clientProvider);
  final fire = ref.watch(firebaseAuthServiceProvider);
  return ClubServices(client, fire);
});

class ClubServices {
  final NetworkClient _client;
  final FirebaseAuthenticate _fireService;
  ClubServices(this._client, this._fireService);

  final _fireStore = FirebaseFirestore.instance;

  Future<FireClubDetails> clubDetails(String clubId) async {
    try {
      final DocumentSnapshot clubData =
          await _fireStore.collection('clubs').doc(clubId).get();
      Map<String, dynamic> clubMap = clubData.data() as Map<String, dynamic>;
      final data = ClubDataModel.fromJson(clubMap);

      return FireClubDetails(data: data);
      // final DocumentSnapshot clubContacts = await _fireStore.collection('club_contacts').doc(clubId).get();
      // final DocumentSnapshot schedule = await _fireStore.collection('club_schedules').doc(clubId).get();
      // // final DocumentSnapshot policies = await _fireStore.collection('club_policies').doc(clubId).get();
      //
      // final scheduleMap = schedule.data() as Map<String, dynamic>?;
      // final scheduleList = scheduleMap?['schedules'] == null ? [] : scheduleMap!['schedules'] as List;
      // print(scheduleList);
      //
      // //Photos
      // final DocumentSnapshot photos = await _fireStore.collection('photos').doc(clubId).get();
      // final photoMap = photos.data() as Map<String, dynamic>?;
      // final photosList = photoMap == null ? [] : photoMap[clubId] as List;
      //
      // final parsedClub = ClubData.fromJson(clubData.data() as Map<String, dynamic>);
      //
      // //City
      // final citySnapshot = await parsedClub.city?.get();
      // final cityData = citySnapshot?.data() as Map<String, dynamic>?;
      // final cityName = cityData != null ? cityData['name'] : null;
      //
      // return FireClubDetails(
      //     data: parsedClub,
      //     photos: photosList.map((e) => e as String).toList(),
      //   cityName: cityName
      // );
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<List> getUpcomingBooking(
    String clubId,
  ) async {
    List newbookingList = [];

    // try {
    final DateTime today = DateTime.now();
    final bookingData = await _fireStore
        .collection("club_entry_bookings")
        .where('club_id', isEqualTo: clubId)
        .where("status", isEqualTo: "Approved")
        .where('booking_date',
            isGreaterThanOrEqualTo:
                DateTime(today.year, today.month, today.day))
        .where('user_id', isEqualTo: _fireService.uid)
        .get();

    // Map<String, dynamic> bookingMap =
    //     bookingData.docs as Map<String, dynamic>;

    Map<String, dynamic> bookingMap;
    // final data;

    for (var element in bookingData.docs) {
      bookingMap = element.data();
      // data = BookingDetailsModel.fromJson(bookingMap);

      newbookingList.add(bookingMap);
    }

    return newbookingList;
    // } catch (e) {
    //   debugPrint(e.toString());
    //   rethrow;
    // }
    // return null;
  }

  Future ladiesClubList(String clubId) async {
    try {
      final ladiesNightDays = await _fireStore
          .collection('clubs')
          .doc(clubId)
          .collection('ladies_night_days')
          .get();

      for (var element in ladiesNightDays.docs) {
        return element.data();
      }
    } catch (e) {
      // rethrow;
      return {};
    }

    // return ladiesNightList;

    // return List<String>.from(ladiesNightDays.docs.map((e) => e.data()));
  }

  // Future<List<ClubData>> getClubList(FilterEnum filterType) async {
  //   try {
  //     // final response = await _client.getRequest(
  //     //     '/club/v1/clubList?city=ecf4cd36-abb6-46ce-9c42-559b5e96ada6');
  //     // // final response = await _client.demoDataRequest('assets/samples/clubs.json');
  //     // final ClubsListResponse data = ClubsListResponse.fromJson(response.data);
  //     // return data.data;
  //
  //     final QuerySnapshot data = await getFilteredQuery(filterType);
  //     final clubs = data.docs.map((e) => ClubData.fromJson(e.data() as Map<String, dynamic>)).toList();
  //
  //     return clubs;
  //   } catch (e) {
  //     debugPrint(e.toString());
  //     rethrow;
  //   }
  // }

  // Future<QuerySnapshot> getFilteredQuery(FilterEnum filterEnum) async{
  //   switch(filterEnum){
  //     case FilterEnum.nearby:
  //         return await _fireStore.collection('clubs').limit(40).get();
  //     case FilterEnum.aToz:
  //       return await _fireStore.collection('clubs').limit(40).orderBy('name', descending: false).get();
  //     case FilterEnum.zToa:
  //       return await _fireStore.collection('clubs').limit(40).orderBy('name', descending: true).get();
  //     case FilterEnum.popular:
  //       return await _fireStore.collection('clubs').where('featured', isEqualTo: true).limit(40).get();
  //
  //     default:
  //       return await _fireStore.collection('clubs').limit(40).get();
  //   }
  // }

  Future<void> markFav(ClubDataModel clubDetails) async {
    debugPrint("FAV MARKED");
    try {
      final uid = _fireService.geCurrentUser();
      // await _fireStore.collection('fav_clubs').doc(uid!.uid).collection(clubId).doc('fav_data').set({'createdAt': DateTime.now()});
      await _fireStore
          .collection('users')
          .doc(uid!.uid)
          .collection('favorite_clubs')
          .doc(clubDetails.id)
          .set(clubDetails.toFavJson(), SetOptions(merge: true));
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> checkFav(String clubId) async {
    debugPrint("Fav Check");
    try {
      final uid = _fireService.geCurrentUser();
      // final check = await _fireStore.collection('fav_clubs').doc(uid!.uid).collection(clubId).get();
      final check = await _fireStore
          .collection('users')
          .doc(uid!.uid)
          .collection('favorite_clubs')
          .doc(clubId)
          .get();
      if (check.exists) {
        return true;
      } else {
        return false;
      }
      // final validation = check.data()?[clubId];
      // return  validation != null;
    } catch (e) {
      rethrow;
    }
  }

  deleteFav(String clubId) async {
    try {
      final uid = _fireService.geCurrentUser();
      // await _fireStore.collection('fav_clubs').doc(uid!.uid).collection(clubId).doc('fav_data').delete();
      // await _fireStore.collection('fav_clubs').doc(uid!.uid).update({
      //   clubId: FieldValue.delete()
      // });

      await _fireStore
          .collection('users')
          .doc(uid!.uid)
          .collection('favorite_clubs')
          .doc(clubId)
          .delete();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ClubDataModel>> getAllFavClubs() async {
    debugPrint("ALL ClUBS");
    List<ClubDataModel> clubs = [];
    try {
      final uid = _fireService.geCurrentUser();
      final clubsList = await _fireStore
          .collection('users')
          .doc(uid!.uid)
          .collection('favorite_clubs')
          .get();
      final data = clubsList.docs;
      for (final c in data) {
        // final clubData = await _fireStore.doc(c.value).get();
        // final club = ClubData.fromJson(clubData.data() as Map<String, dynamic>);
        // clubs.add(club);
        final clubData = ClubDataModel.fromJson(c.data());
        clubs.add(clubData);
      }
      return clubs;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ClubDataNew>> getClubsFromApi(
    String city,
    String day,
    int time, {
    double? lat,
    double? lng,
  }) async {
    final url = (lat != null && lng != null)
        ? '/club/v3/clubList?city_name=$city&current_lat=$lat&current_long=$lng&day=$day&time_in_mins=$time'
        : '/club/v3/clubList?city_name=$city&day=$day&time_in_mins=$time';

    debugPrint(" ---- $url");
    try {
      final response = await _client.getRequest(url);
      final data = ClubListApiResponse.fromJson(response.data);

      final result =
          data.message.where((element) => element.status == 'Active').toList();

      return data.message;
    } catch (e) {
      print("$e");
      rethrow;
    }
  }

  Future<List<DateTime>> closingDates(String clubId) async {
    // print("CLOSING DATE");
    try {
      final snapshot = await _fireStore
          .collection('clubs')
          .doc(clubId)
          .collection('closed_bookings')
          .get();
      // print(snapshot.docs);
      return List<DateTime>.from(
          snapshot.docs.map((e) => DateTime.parse(e['date'])));
    } catch (_) {
      rethrow;
    }
  }

  Future<List<DateTime>> upcomingClosingDates(String clubId) async {
    // print("CLOSING DATE");
    try {
      final snapshot = await _fireStore
          .collection('clubs')
          .doc(clubId)
          .collection('closed_bookings')
          .get();
      // print(snapshot.docs);
      final today = DateTime.now().subtract(Duration(days: 1));
      final todayDate = DateTime(today.year, today.month, today.day);

      final sorted = snapshot.docs;
      sorted.sort((a, b) => a['date'].compareTo(b['date']));
      for (var i = 0; i < (sorted.length - 1); i++) {
        final sortDate = sorted[i]['date'].toDate();
      }

      return List<DateTime>.from(
          sorted.map((e) => (e['date'] as Timestamp).toDate()).where((element) {
        final elementDate = DateTime(element.year, element.month, element.day);
        print(elementDate);
        return todayDate.isBefore(elementDate);
      }));
    } catch (err) {
      print("closing>>>>>>>>>>>>>>>>>>>${err.toString()}");
      rethrow;
    }
  }

  Future<List<ProductModel>> drinksList(String clubId) async {
    try {
      final snapshot = await _fireStore
          .collection('clubs')
          .doc(clubId)
          .collection('drink_category')
          .get();
      // print(snapshot.docs);
      return List<ProductModel>.from(
          snapshot.docs.map((e) => ProductModel.fromJson(e.data())));
    } catch (_) {
      rethrow;
    }
  }

  Future<List<ProductModel>> smokesList(String clubId) async {
    try {
      final snapshot = await _fireStore
          .collection('clubs')
          .doc(clubId)
          .collection('smoke_category')
          .get();
      // print(snapshot.docs);
      return List<ProductModel>.from(
          snapshot.docs.map((e) => ProductModel.fromJson(e.data())));
    } catch (_) {
      rethrow;
    }
  }
}
