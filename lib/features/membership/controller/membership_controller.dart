import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/features/membership/data/model/membership_response.dart';
import 'package:htp_customer/features/membership/data/services/membership_services.dart';

import '../../../authentication/data/service/firebase_auth_service.dart';
import '../data/model/membership_requested_data_model.dart';

final membershipProvider = StateNotifierProvider.autoDispose((ref) {
  final service = ref.watch(membershipServiceProvider);
  final auth = ref.watch(firebaseAuthServiceProvider);
  return MembershipController(service, auth);
});

class MembershipController extends StateNotifier<MembershipStates> {
  final MembershipServices _services;
  final FirebaseAuthenticate _auth;
  MembershipController(this._services, this._auth) : super(MembershipLoading()) {
    getMembership();
  }

  getMembership() async {
    try {
      FirebaseAnalytics.instance.logEvent(name: 'membership_page');
      state = MembershipLoading();
      final data = await _services.getMembershipData();
      final requestMembership = await _services.getMembershipRequestData(_auth.uid);
      if(requestMembership.isNotEmpty){
        print("REQUEST STATUS : ${requestMembership.last.status}");
        state = MembershipLoaded(data, requestMembership.last);
      }else{
        state = MembershipLoaded(data, null);
      }

    } catch (e) {
      state = MembershipErrors(e.toString());
    }
  }

  showCardImage(String membershipName){
    switch(membershipName){
      case "Gold":
        return 'assets/images/no_name_card/gold_card_no_name.png';
      case "Solitaire":
        return 'assets/images/no_name_card/solitaire_card_no_name.png';
      case "Platinum":
        return 'assets/images/no_name_card/platinum_card_no_name.png';
      case "Amethyst":
        return 'assets/images/no_name_card/amethyst_card_no_name.png';
      case "Silver":
        return 'assets/images/no_name_card/silver_card_no_name.png';
    }
  }

  @override
  void dispose() {
    super.dispose();
    print('MEMBERSHIP DISPOSED');
  }

}

abstract class MembershipStates {}

class MembershipLoading extends MembershipStates {}

class MembershipLoaded extends MembershipStates {
  final List<MembershipData> membershipData;
  final MembershipRequestedDataModel? oldRequest;

  MembershipData? get oldRequestData => getMembershipDataWithRequestData(oldRequest);

  MembershipData? getMembershipDataWithRequestData(MembershipRequestedDataModel? request){
    if(request == null) return null;

    try{
      return membershipData.firstWhere((element) => element.id == request.membershipId);
    }catch(_) {
      return null;
    }
  }

  MembershipLoaded(this.membershipData, this.oldRequest);
}

class MembershipErrors extends MembershipStates {
  final String message;
  MembershipErrors(this.message);
}
