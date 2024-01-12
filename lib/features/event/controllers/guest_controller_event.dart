// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../../booking/data/models/guest_model.dart';
//
//
// final showAddGuestBox = StateProvider.autoDispose<bool>((ref) => true);
//
//
//
// final guestAddProviderEvent = StateNotifierProvider.autoDispose<GuestAddEventController, List<GuestModel>>((ref) => GuestAddEventController());
//
// class GuestAddEventController extends StateNotifier<List<GuestModel>>{
//   GuestAddEventController(): super([]);
//
//   addGuest(String name, String age){
//     final newGuest = GuestModel(name, age, DateTime.now().toIso8601String());
//     state = [
//       ...state,
//       newGuest
//     ];
//   }
//
//   removeGuest(String id){
//     try{
//       state = state.where((element) => element.id != id).toList();
//     }catch(_){
//       state = [];
//     }
//   }
//
//
// }
//
//
// // To parse this JSON data, do
// //
// //     final guestModel = guestModelFromJson(jsonString);
//
//
// // List<GuestModel> guestModelFromJson(String str) => List<GuestModel>.from(json.decode(str).map((x) => GuestModel.fromJson(x)));
//
//
//
