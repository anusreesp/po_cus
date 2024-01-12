


import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/features/membership/data/model/membership_response.dart';
import 'package:htp_customer/features/profile/controller/profile_controller.dart';

import '../../../authentication/data/service/firebase_auth_service.dart';
import '../data/services/membership_services.dart';

final membershipApplicationProvider = StateNotifierProvider.autoDispose<MembershipApplicationController, MembershipApplicationStates>((ref){
  final service = ref.watch(membershipServiceProvider);
  final auth = ref.watch(firebaseAuthServiceProvider);
  final profile = ref.watch(profileControllerProvider);
  final ProfileLoaded? profileLoaded = profile is ProfileLoaded ? profile : null;
  return MembershipApplicationController(service, auth, profileLoaded);
});

class MembershipApplicationController extends StateNotifier<MembershipApplicationStates>{
  final MembershipServices _service;
  final FirebaseAuthenticate _auth;
  final ProfileLoaded? _profileController;
  MembershipApplicationController(this._service, this._auth, this._profileController):super(MAInitialState());

  // MembershipData? selectedMembership;


  ///Show popups for confirmation --- old
  applyMembership(MembershipData membershipData){
    state = MARequestState(membershipData);
    // if(selectedMembership != null){
    //   state = MARequestState(selectedMembership!);
    // }else{
    //   state = MAErrorState('Select a membership!');
    // }
  }

  // submitTest(MembershipData membershipData) async{
  //   state = MALoadingState();
  //   await Future.delayed(const Duration(seconds: 1));
  //   state = MASubmitState(membershipData);
  // }

  ///Submits membership request
  Future<void> submitMembershipRequest(MembershipData membershipData, {String? frontIdPath, String? backIdPath, Plan? selectedPlan}) async{
    try{

      FirebaseAnalytics.instance.logEvent(name: 'membership_request_submit');
      state = MALoadingState();
      if(_profileController is ProfileLoaded){
        await _service.membershipRequest(
            data: membershipData,
            uid: _auth.uid,
            oldMemId: _profileController!.activeMembershipData?.id,
            oldMemName: _profileController!.activeMembershipData?.name,
            cabinCrew: membershipData.level == -1,
            cabinCrewFrontId: frontIdPath,
            cabinCrewBackId: backIdPath,
          selectedPlan: selectedPlan
        );
      }else{
        state = MAErrorState('Profile loading failed');
      }

      state = MASubmitState(membershipData);
    }catch(e){
      print(e);
      state = MAErrorState(e.toString());
    }
    // if(selectedMembership != null){
    //   state = MALoadingState();
    //   await _service.membershipRequest(
    //       membershipId: selectedMembership?.id ?? '',
    //       userId: _auth.uid);
    //   state = MASubmitState(selectedMembership!);
    // }else{
    //   state = MAErrorState('Select a membership!');
    // }
  }


}

abstract class MembershipApplicationStates{}

class MAInitialState extends MembershipApplicationStates{}

class MALoadingState extends MembershipApplicationStates{}

class MARequestState extends MembershipApplicationStates{
  final MembershipData data;
  MARequestState(this.data);
}

class MASubmitState extends MembershipApplicationStates{
  final MembershipData data;
  MASubmitState(this.data);
}

class MAErrorState extends MembershipApplicationStates{
  final String msg;
  MAErrorState(this.msg);
}