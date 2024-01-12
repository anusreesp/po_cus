import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/features/profile/data/models/loyalty_points_model.dart';
import 'package:htp_customer/features/profile/data/models/profile_response.dart';
import '../../../../authentication/data/service/firebase_auth_service.dart';
import '../../../../networking/http_client.dart';
import '../models/additional_profile_info.dart';
import '../models/booking_details.dart';

final profileServiceProvider = Provider((ref) {
  final client = ref.watch(clientProvider);
  final fire = ref.watch(firebaseAuthServiceProvider);
  return ProfileServices(client, fire);
});

class ProfileServices {
  final NetworkClient _client;
  final FirebaseAuthenticate _authService;

  ProfileServices(this._client, this._authService);

  final _fire = FirebaseFirestore.instance;
  //---------------get profile data--------------------------------------
  Future<UserProfiledData> getProfileData() async {
    try {
      final response =
          await _fire.collection('users').doc(_authService.uid).get();
      final data = ProfileData.fromJson(response.data()!);
      final editData = UserEditModel.fromJson(response.data()!);
      return UserProfiledData(data, editData);
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<void> updateProfile(UserEditModel data) async {
    try {
      final jsonData = data.toJson();
      jsonData['updatedAt'] = FieldValue.serverTimestamp();
      await _fire
          .collection('users')
          .doc(_authService.uid)
          .set(jsonData, SetOptions(merge: true));
      print("-------------${jsonData}");
    } catch (_) {
      rethrow;
    }
  }

  Future<ProfileInfo> getAdditionalProfileData() async {
    try {
      final response = await _fire
          .collection("users_additional_info")
          .doc(_authService.uid)
          .get();
      //print(response.data());
      final responseData = response.data();
      if (responseData == null) {
        return ProfileInfo();
      }
      final data = ProfileInfo.fromJson(response.data()!);
      return data;
    } catch (_) {
      rethrow;
    }
  }

  Future<List<BookingData>> getMyBookings() async {
    try {
      final response = await _fire
          .collection('club_entry_bookings')
          .where('user_id', isEqualTo: _authService.uid)
          .orderBy('booking_date')
          .get();
      final responseEvent = await _fire
          .collection('event_entry_bookings')
          .where('user_id', isEqualTo: _authService.uid)
          .orderBy(
            'booking_date',
          )
          .get();
      // print("Booking data ${response.docs}");
      final data = response.docs;
      final data2 = responseEvent.docs;
      final bookings = List<BookingData>.from(
          data.map((e) => BookingData.fromJson(e.data())));
      final events = List<BookingData>.from(
          data2.map((e) => BookingData.fromJson(e.data())));
      return [...bookings, ...events];
      // return bookings;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<List<BookingData>> getPastBookings() async {
    try {
      final response = await _fire
          .collection('club_entry_bookings')
          .where('user_id', isEqualTo: _authService.uid)
          .get();
      // print("Booking data ${response.docs}");
      final data = response.docs;
      final bookings = List<BookingData>.from(
          data.map((e) => BookingData.fromJson(e.data())));
      return bookings;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future deleteAccount() async {
    try {
      final result = await _client
          .deleteRequest('/user/v1/deleteUser', {'uid': _authService.uid});
      return result;
    } catch (_) {
      rethrow;
    }
  }

  Future<void> updateProfileImage(String filePath) async {
    try {
      final url = await _client.uploadFile(filePath);
      await _fire
          .collection('users')
          .doc(_authService.uid)
          .set({'profile_image': url}, SetOptions(merge: true));
    } catch (_) {
      rethrow;
    }
  }

  Future<List<LoyaltyModel>> getLoyaltyPoints(String uid) async {
    // uid
    try {
      final response = await _fire
          .collection('users')
          .doc(uid)
          .collection('loyality_point_history')
          .get();
      return response.docs.map((e) => LoyaltyModel.fromJson(e.data())).toList();
    } catch (_) {
      rethrow;
    }
  }

  Future updateEmail(String? email, String uid) async {
    try {
      final data = {"uid": uid, "email": email};
      final res = await _client.postRequest('/user/v1/updateUser', data);
      print("------------------------res->${res}");
      return res;
    } catch (err) {
      print(err.toString());
      rethrow;
    }
  }

  Future<void> updatePhone(String mobile) async {
    try {
      final data = {
        "uid": _authService.uid,
        "contacts": [
          {
            "contact_no": mobile,
            "mode": 'phone',
            "is_active": true,
            'is_verified': true
          }
        ],
      };
      await _client.postRequest('/user/v2/update', data);
    } catch (_) {
      rethrow;
    }
  }

  Future<void> sendEmailOtp(String? uid, String? email) async {
    try {
      final data = {"user_id": uid, "email": email};
      final response =
          await _client.postRequest('/user/v1/sendVerifyEmailOtp', data);
    } catch (err) {
      rethrow;
    }
  }

  Future<void> deleteAccountEmailOtp(
    String? uid,
  ) async {
    try {
      final data = {"user_id": uid};
      final response =
          await _client.postRequest('/user/v1/sendAccountDeleteEmailOtp', data);
    } catch (err) {
      rethrow;
    }
  }

  Future<bool> verifyEmailOtp(String otp, String email) async {
    try {
      final data = {
        "otp": otp,
        "email": email,
      };
      print(data);
      final response =
          await _client.postRequest('/user/v1/VerifyEmailOtp', data);
      if (response.data['success'] == true) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      rethrow;
    }
  }

  Future<bool> afterVerifyEmailUsingOtp(String email) async {
    try {
      final request = {"email": email};
      final response =
          await _client.postRequest('/user/v1/verifyUserEmail', request);

      if (response.data['success'] == true) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }
}
