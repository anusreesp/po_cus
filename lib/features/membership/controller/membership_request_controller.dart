// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:htp_customer/features/membership/data/services/membership_request_services.dart';
// import '../data/model/membership_request_response.dart';
//
// final membershipRequestProvider =
//     StateNotifierProvider.family<MembershipRequestController, dynamic, String?>(
//         (ref, mid) {
//   final service = ref.watch(membershipRequestServiceProvider);
//   final id = '';
//   return MembershipRequestController(service, mid);
// });
//
// class MembershipRequestController
//     extends StateNotifier<MembershipRequestStates> {
//   final MembershipRequestServices _services;
//   final String? id;
//   MembershipRequestController(this._services, this.id)
//       : super(MembershipRequestLoading()) {
//     getMemebership(id);
//   }
//
//   getMemebership(String? id) async {
//     try {
//       state = MembershipRequestLoading();
//       final data = await _services.getMembershipRequestData(id);
//       state = MembershipRequestLoaded(data);
//     } catch (e) {
//       state = MembershipRequestErrors(e.toString());
//     }
//   }
// }
//
// abstract class MembershipRequestStates {}
//
// class MembershipRequestLoading extends MembershipRequestStates {}
//
// class MembershipRequestLoaded extends MembershipRequestStates {
//   final List<MembershipRequestData> membershipRequestdata;
//   MembershipRequestLoaded(this.membershipRequestdata);
// }
//
// class MembershipRequestErrors extends MembershipRequestStates {
//   final String message;
//   MembershipRequestErrors(this.message);
// }
