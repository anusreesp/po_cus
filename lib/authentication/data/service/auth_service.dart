import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/app_config.dart';
import 'package:htp_customer/authentication/data/models/city_list.dart';
import 'package:htp_customer/authentication/data/models/country_list.dart';
import 'package:htp_customer/authentication/data/models/signup_data.dart';
import 'package:htp_customer/authentication/data/models/state_list.dart';

final authServiceProvider = Provider((ref) {
  final config = ref.watch(appConfigProvider);
  return AuthService(FirebaseFirestore.instance, config.baseUrl);
});

class AuthService {
  final FirebaseFirestore _fireStore;
  final String baseUrl;
  AuthService(this._fireStore, this.baseUrl);

  final Dio _dio = Dio();

  CollectionReference<SignupData> get _userRef =>
      _fireStore.collection('users').withConverter(
          fromFirestore: (snapshot, _) => SignupData.fromJson(snapshot.data()!),
          toFirestore: (data, _) => data.toJson());

  Future<void> createLog(String uid) async {
    // _fireStore.collection('collectionPath').doc('').collection('collectionPath').add({})
    try {
      await _fireStore.collection('users').doc(uid).set(
          {'logged': DateTime.now().toIso8601String()},
          SetOptions(merge: true));
    } catch (_) {
      rethrow;
    }
  }

  Future<void> signup(SignupData data, String uid, String? deviceToken) async {
    try {
      final dataWithId = data.copyWith(id: uid, deviceToken: deviceToken);
      await _userRef.doc(uid).set(dataWithId);
      // await _fireStore.collection('user_contacts').doc(uid).set(data.contact.toJson());
    } catch (_) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> readUserData(String uid) async {
    try {
      final result = await _fireStore.collection('users').doc(uid).get();
      return result.data();
    } catch (_) {
      rethrow;
    }
  }

  Future<List<CountryData>> getCountries() async {
    try {
      // final response = await _client.getRequestNoToken('/location/v1/countries');
      final response =
          await Dio().get('$baseUrl/location/v2/countries');
      final data = CountryListResponse.fromJson(response.data);
      return data.data;
    } catch (_) {
      rethrow;
    }
  }

  Future<List<StateData>> getStates(int countryId, {String? name}) async {
    try {
      final url = name == null || name.isEmpty
          ? '$baseUrl/location/v1/userState?country=$countryId'
          : '$baseUrl/location/v1/userState?country=$countryId&name=$name';
      // ? '/location/v2/userCities?country=$countryId'
      // : '/location/v2/userCities?country=$countryId&name=$name';

      print(">>>>:$url");
      // final response = await _client.getRequestNoToken(url);
      final response = await _dio.get(url);
      // print(response.data);
      final data = StateListResponse.fromJson(response.data);
      return data.data;
    } catch (_) {
      rethrow;
    }
  }

  Future<List<CityData>> getCitiesV3(int countryId, int stateId, {String? name}) async {
    try {
      final url = name == null || name.isEmpty
          ? '$baseUrl/location/v3/userCities?country=$countryId&state=$stateId'
          : '$baseUrl/location/v3/userCities?country=$countryId&state=$stateId&name=$name';
      // ? '/location/v2/userCities?country=$countryId'
      // : '/location/v2/userCities?country=$countryId&name=$name';

      print(url);
      // final response = await _client.getRequestNoToken(url);
      final response = await _dio.get(url);
      // print(response.data);
      final data = CityListResponse.fromJson(response.data);
      return data.data;
    } catch (_) {
      rethrow;
    }
  }

  @Deprecated('Use get getCitiesV3 where cities comes as per state selection')
  Future<List<CityData>> getCities(int countryId, {String? name}) async {
    try {
      final url = name == null || name.isEmpty
          ? '$baseUrl/location/v3/userCities?country=$countryId'
          : '$baseUrl/location/v3/userCities?country=$countryId&name=$name';
      // ? '/location/v2/userCities?country=$countryId'
      // : '/location/v2/userCities?country=$countryId&name=$name';

      print(url);
      // final response = await _client.getRequestNoToken(url);
      final response = await _dio.get(url);
      // print(response.data);
      final data = CityListResponse.fromJson(response.data);
      return data.data;
    } catch (_) {
      rethrow;
    }
  }

  Future<void> sendWhatsAppOtp(String mobile) async {
    print(mobile);
    try {
      const url =
          'https://verify.twilio.com/v2/Services/VA35b079180f60fe16aa5cf3b8c08cb7bc/Verifications';
      final auth = 'Basic ${base64Encode(utf8.encode(
          "AC8b4ccb9e14dec3e639b266481057347c:72dfb92988629a753248e00db9eb3daa"))}';
      _dio.options.headers['authorization'] = auth;
      _dio.options.contentType = 'application/x-www-form-urlencoded';
      final response = await _dio.post(
        url,
        data: {
          'To': mobile,
          // 'Channel': 'sms'
          'Channel': 'whatsapp'
        },
      );
      print("---------------------${response.data}");
    } on DioException catch(e){
      if (e.response != null) {
        throw e.response!.data['message'];
      } else {
        rethrow;
      }
    }
    catch (err) {
      rethrow;
    }
  }

  Future<void> sendOtp(String mobile) async {
    print(mobile);
    try {
      const url =
          'https://verify.twilio.com/v2/Services/VA35b079180f60fe16aa5cf3b8c08cb7bc/Verifications';
      final auth = 'Basic ${base64Encode(utf8.encode(
              "AC8b4ccb9e14dec3e639b266481057347c:72dfb92988629a753248e00db9eb3daa"))}';
      _dio.options.headers['authorization'] = auth;
      _dio.options.contentType = 'application/x-www-form-urlencoded';
      final response = await _dio.post(
          url,
          data: {
            'To': mobile,
            'Channel': 'sms'
            // 'Channel': 'whatsapp'
          },
      );
      print("---------------------${response.data}");
    } on DioException catch(e){
      if (e.response != null) {
        throw e.response!.data['message'];
      } else {
        rethrow;
      }
    }
    catch (err) {
      rethrow;
    }
  }

  Future<bool> verifyOtp(String mobile, String otp) async {
    try {
      // const url = 'https://verify.twilio.com/v2/Services/VAc4ee2611d5f502e137e84d85a684fb0d/VerificationCheck';
      const url =
          'https://verify.twilio.com/v2/Services/VA35b079180f60fe16aa5cf3b8c08cb7bc/VerificationCheck';
      // final auth = 'Basic ' + base64Encode(utf8.encode("ACd0ebb09d1ee26e7c22bbc99a9a8655d4:837a9780d2fe48cfbeedc7ee7652022a"));
      final auth = 'Basic ${base64Encode(utf8.encode(
              "AC8b4ccb9e14dec3e639b266481057347c:72dfb92988629a753248e00db9eb3daa"))}';
      _dio.options.headers['authorization'] = auth;
      _dio.options.contentType = 'application/x-www-form-urlencoded';
      final response = await _dio.post(
          url,
          data: {'To': mobile, 'Code': otp},
      );
      print(">>>>>>>>>>>.${response.data}");
      return response.data['valid'];
    } catch (_) {
      rethrow;
    }
  }

  Future<void> updateDeviceToken(String token, String uid) async {
    try {
      await _fireStore.collection('users').doc(uid).update({
        'device_token': FieldValue.arrayUnion([token]),
        'status': 'Active'
      });
    } catch (e) {
      print(e.toString());
      // rethrow;
    }
  }

  Future<void> removeDeviceToken(String token, String uid) async {
    try {
      await _fireStore.collection('users').doc(uid).update({
        'device_token': FieldValue.arrayRemove([token])
      });
    } catch (e) {
      print(e.toString());
      // rethrow;
    }
  }
  
  Future<void> sendEmailOtp(String email)async{
    try{
      final response = await _dio.post('$baseUrl/user/v1/sendForgetPassewordOtp', data: {
        "email": email
      });
      if(response.data['success'] != true){
        throw response.data['message'];
      }
    }on DioException catch(e){
      if(e.response?.statusCode == 400){
        throw 'Please enter a valid email ID';
      }else{
        rethrow;
      }
    } catch(_){
      rethrow;
    }
  }

  Future<bool> verifyEmailOtp(String email, otp)async{
    try{
      final response = await _dio.post('$baseUrl/user/v1/VerifyEmailOtp', data: {
        "otp":otp,
        "email":email
      });
      if(response.data['success'] != true){
        throw response.data['message'];
      }
      return response.data['success'];
    }catch(_){
      rethrow;
    }
  }

  Future<void> updatePassword(String email, newPassword)async{
    try{
      final response = await _dio.post('$baseUrl/user/v1/updatePassword', data: {
        "password": newPassword,
        "email": email
      });
      if(response.data['success'] != true){
        throw response.data['message'];
      }
    }catch(_){
      rethrow;
    }
  }
  
}
