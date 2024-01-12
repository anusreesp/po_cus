// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:htp_customer/features/membership/data/services/membership_request_services.dart';
// import '../data/model/membership_request_response.dart';
//
// final membershipUpgradeProvider =
//     StateNotifierProvider.family<MembershipUpgradeController, dynamic, String?>(
//         (ref, mid) {
//   final service = ref.watch(membershipRequestServiceProvider);
//   final id = ''; //TODO: Get it from provider
//   return MembershipUpgradeController(service, mid);
// });
//
// class MembershipUpgradeController
//     extends StateNotifier<MembershipUpgradeStates> {
//   final MembershipRequestServices _services;
//   final String? id;
//   MembershipUpgradeController(this._services, this.id)
//       : super(MembershipUpgradeLoading()) {
//     getMemebershipUpgrade(id);
//   }
//
//   getMemebershipUpgrade(String? id) async {
//     try {
//       state = MembershipUpgradeLoading();
//       final data = await _services.getMembershipUpgradetData(id);
//       state = MembershipUpgradeLoaded(data);
//     } catch (e) {
//       state = MembershipUpgradeErrors(e.toString());
//     }
//   }
// }
//
// abstract class MembershipUpgradeStates {}
//
// class MembershipUpgradeLoading extends MembershipUpgradeStates {}
//
// class MembershipUpgradeLoaded extends MembershipUpgradeStates {
//   final List<MembershipRequestData> membershipRequestdata;
//   MembershipUpgradeLoaded(this.membershipRequestdata);
// }
//
// class MembershipUpgradeErrors extends MembershipUpgradeStates {
//   final String message;
//   MembershipUpgradeErrors(this.message);
// }
