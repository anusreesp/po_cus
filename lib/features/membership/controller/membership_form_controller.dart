
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/authentication/data/models/city_list.dart';
import 'package:htp_customer/authentication/data/service/firebase_auth_service.dart';
import 'package:htp_customer/features/membership/data/model/membership_form_data.dart';

import '../data/services/membership_services.dart';

// final residencyProvider = StateProvider<String?>((ref) => 'Resident');
final clubbingFrequencyProvider = StateProvider<String?>((ref) => 'Mostly daily');
final tAndACheck = StateProvider.autoDispose<bool>((ref) => false);

final selectedStateIdProvider = StateProvider<int?>((ref) => null);
final selectedHomeCountryId = StateProvider<int?>((ref) => null);
final selectedNationality = StateProvider<String?>((ref) => null);

final showDefaultSelection = StateProvider.autoDispose<bool>((ref) => true);

final membershipFormDataProvider = StateNotifierProvider<MembershipFormController, MembershipFormState>((ref) {
  final user = ref.watch(firebaseAuthServiceProvider);
  final service = ref.watch(membershipServiceProvider);
  return MembershipFormController(user.uid, service);
});

class MembershipFormController extends StateNotifier<MembershipFormState>{
  final String uid;
  final MembershipServices _service;
  MembershipFormController(this.uid, this._service):super(MembershipInitialState());

  late MembershipFormData _membershipFormData;

  saveFormData({
    required String name,
    required String nationality,
    required String residency,
    required String pinCode,
    required String govtId,
    required String clubbingFrequency,
    required String permanentAddress,
    required CityData city
  })async{
    _membershipFormData = MembershipFormData(
        userId: uid,
        name: name,
        nationality: nationality,
        residency: residency,
        homeCountryId: city.countryId,
        homeCountryName: city.countryName,
        homeStateName: city.stateName,
        homeStateId: city.stateId,
        homeCityId: city.id,
        homeCityName: city.name,
        govtIdNumber: govtId,
        clubFrequency: clubbingFrequency,
        permanentAddress: permanentAddress,
        zipcode: pinCode,
        govtIdFront: '',
        govtIdBack: null,
        userImage: '');

    // submitMembershipRequest();
  }

  addGovtId(String front, String? back){
    FirebaseAnalytics.instance.logEvent(name: 'membership_govt_id_add');
    _membershipFormData = _membershipFormData.copyWith(govtIdFront: front, govtIdBack: back);
  }


  submitFormData(String selfieUrl)async{
    state = MembershipLoadingState();
    try{

      FirebaseAnalytics.instance.logEvent(name: 'membership_form_submit');
      final data = _membershipFormData.copyWith(userImage: selfieUrl);
      await _service.membershipRequestNew(data.toJson());
      state = MembershipSuccessState();
    }catch(e){
      state = MembershipErrorState(e.toString());
    }
  }


}

abstract class MembershipFormState{}

class MembershipInitialState extends MembershipFormState{}

class MembershipLoadingState extends MembershipFormState{}

class MembershipSuccessState extends MembershipFormState{}

class MembershipErrorState extends MembershipFormState{
  final String msg;
  MembershipErrorState(this.msg);
}
