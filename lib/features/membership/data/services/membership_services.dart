import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/features/membership/data/model/kyc_requested_data.dart';
import 'package:htp_customer/features/membership/data/model/membership_requested_data_model.dart';
import 'package:htp_customer/features/membership/data/model/membership_response.dart';
import 'package:htp_customer/networking/http_client.dart';

final membershipServiceProvider = Provider((ref) {
  final client = ref.watch(clientProvider);
  return MembershipServices(client);
});

class MembershipServices {
  final NetworkClient _client;
  MembershipServices(this._client);

  final _fire = FirebaseFirestore.instance;

  Future<List<MembershipData>> getMembershipData() async {
    List<MembershipData> dataList = [];
    try {
      final membership = await _fire
          // .collection('memberships')
          // .where('is_active', isEqualTo: true)
          .collection("memberships")
          .where("is_active", isEqualTo: true)
          .orderBy('app_order')
          .get();

      for (final member in membership.docs) {
        final data = member.data();
        // final benefits = await getMembershipBenefits(data['id']);
        // dataList.add(MembershipData(
        //     id: data['id'],
        //     level: data['level'],
        //     name: data['name'],
        //     image: data['display_image'],
        //     pricePerYear: data['price_per_year'],
        //     benefits: data['benefits'] == null
        //         ? []
        //         : (data['benefits'] as List).map((e) => e as String).toList(),
        // ));
        dataList.add(MembershipData.fromJson(data));
      }

      return dataList;
    } catch (e) {
      rethrow;
    }
  }

  Future<MembershipData?> getMembershipDataById(String id) async {
    try {
      final response = await _fire.collection('memberships').doc(id).get();
      // print("MEM: $id --- ${response.data()}");
      return MembershipData.fromJson(response.data()!);
    } catch (e) {
      print(e);
      rethrow;
    }
  }
  // Future<List<String>> getMembershipBenefits(String id) async{
  //   try{
  //     final benefitsRequest = await _fire.collection('membership_benifits').doc(id).get();
  //     // final benefitList = benefitsRequest.data()?[id] as List;
  //     // return benefitList.map((e) => e['benifit'] as String).toList();
  //     final benefitsMap = benefitsRequest.data();
  //     final benefitsList = benefitsMap == null ? [] : benefitsMap[id] as List;
  //     return benefitsList.map((e) => e as String).toList();
  //   }catch(_){
  //     rethrow;
  //   }
  // }

  // Future getMembershipPlan(String id) async{
  //   try{
  //     final planRequest = await _fire.collection('membership_plans').doc(id).get();
  //
  //   }catch(_){
  //     rethrow;
  //   }
  // }

  Future<void> membershipRequestNew(Map<String, dynamic> data) async {
    try {
      final response = await _client.postRequest('/kyc/v2/kyc', data);
      final keyID = response.data['kyc_id'];
    } catch (_) {
      rethrow;
    }
  }

  Future<List<MembershipRequestedDataModel>> getMembershipRequestData(
      String uid) async {
    try {
      final response = await _fire
          .collection('membership_requests')
          .where('user_id', isEqualTo: uid)
          // .where('status', isEqualTo: 'Pending')
          // .where('status', isEqualTo: 'waiting for payment confirmation')
          .orderBy('createdAt')
          .get();
      return List<MembershipRequestedDataModel>.from(response.docs
          .map((e) => MembershipRequestedDataModel.fromJson(e.data())));
    } catch (e) {
      rethrow;
    }
  }

  Future<MembershipRequestedDataModel?> getMembershipRequestById(
      String? id) async {
    if (id == null) {
      return null;
    }

    try {
      final response =
          await _fire.collection('membership_requests').doc(id).get();
      final data = response.data();
      if (data != null) {
        return MembershipRequestedDataModel.fromJson(data);
      } else {
        return null;
      }
    } catch (_) {
      rethrow;
    }
  }

  Future<void> membershipRequest(
      {required MembershipData data,
      required String uid,
      required String? oldMemId,
      required String? oldMemName,
      String? referralId,
      required bool cabinCrew,
      String? cabinCrewFrontId,
      String? cabinCrewBackId,
      Plan? selectedPlan}) async {
    try {
      // String? frontIdUrl;
      // String? backIdUrl;
      // if(cabinCrewFrontId != null){
      //   frontIdUrl = await _client.uploadFile(cabinCrewFrontId);
      // }
      //
      // if(cabinCrewBackId != null){
      //   backIdUrl = await _client.uploadFile(cabinCrewBackId);
      // }
      final plan = selectedPlan ?? data.planList.first;
      final requestData = {
        // "membership_id":"18e6a4b1-c609-460f-a796-c9e1661c5eff",
        // "membership_name":"Gold",
        // "membership_plan_id":"gold-one-year",
        // "old_membership_id":"5557d9dd-53ff-499d-a037-c8881d9da732",
        // "old_membership_name":"Silver",
        // "user_id":"yHNZvpyMcFhZ2Ni9LV7nOs9drNv1"

        "membership_id": data.id,
        "membership_name": data.name,
        "membership_plan_id": plan.planUniqueId,
        "old_membership_id": oldMemId,
        "old_membership_name": oldMemName,
        "user_id": uid,
        "referral_code": referralId,
        "amount": plan.price,
        "cabin_crew": cabinCrew,
        "cabin_crew_front_image_id": cabinCrewFrontId,
        "cabin_crew_back_image_id": cabinCrewBackId
      };
      print(requestData);

      final response = await _client.postRequest(
          '/membership/v3/membershipRequest', requestData);

      print(response);

      // await _fire.collection('membership_requests').doc(userId).set({
      //   'membership_id': membershipId,
      //   'request_date': FieldValue.serverTimestamp(),
      //   'status': 'Pending'
      // });
    } catch (_) {
      rethrow;
    }
  }

  Future<KycRequestedData?> kycRequestedData(String uid) async {
    try {
      final response = await _fire
          .collection('user_kyc')
          .where('user_id', isEqualTo: uid)
          .orderBy('createdAt')
          .get();
      final kycDataList = List<KycRequestedData>.from(
          response.docs.map((e) => KycRequestedData.fromJson(e.data())));
      if (kycDataList.isNotEmpty) {
        return kycDataList.last;
      } else {
        return null;
      }
    } on FirebaseException catch (e) {
      throw e.message ?? e.code;
    } catch (_) {
      rethrow;
    }
  }

  // Future kycData(String uid)async{
  //   try{
  //     final response = await _fire.collection('user_kyc').where('user_id', isEqualTo: uid).where('status', isNotEqualTo: 'Rejected').get();
  //     if(response.docs.isNotEmpty){
  //
  //     }
  //   }on FirebaseException catch(e){
  //     throw e.message ?? e.code;
  //   }catch(_){
  //     rethrow;
  //   }
  // }

  Future<void> sendPromotionNotification(String uid, reason) async {
    try {
      await _client.postRequest(
          '/notification/v1/sendNotificationOrSmsOrEmailCaseWise', {
        "user_id": uid,
        "case": reason // buy-plan,move-to-platinum,move-to-solitaire
      });
    } catch (e) {
      print(e);
    }
  }
}
