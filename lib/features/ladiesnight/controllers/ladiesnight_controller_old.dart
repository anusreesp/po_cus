// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:htp_customer/features/ladiesnight/data/models/ladiesclub_response.dart';
// import 'package:htp_customer/features/ladiesnight/data/services/ladiesnight_services.dart';

// final ladiesNightProvider = StateNotifierProvider((ref) {
//   final service = ref.watch(ladiesNightServiceProvider);

//   return LadiesNightController(service);
// });

// class LadiesNightController extends StateNotifier<LadiesNightStates> {
//   final LadiesNightClubServices _services;
//   LadiesNightController(this._services) : super(LadiesNightLoading()) {
//     getLadiesNight();
//   }

//   getLadiesNight() async {
//     try {
//       state = LadiesNightLoading();
//       final data = await _services.getLadiesNightClubs();
//       state = LadiesNightLoaded(data);
//     } catch (e) {
//       state = LadiesNightError(e.toString());
//     }
//   }
// }

// class LadiesNightStates {}

// class LadiesNightLoaded extends LadiesNightStates {
//   final List<LadiesNightData> ladiesNight;

//   LadiesNightLoaded(this.ladiesNight);
// }

// class LadiesNightLoading extends LadiesNightStates {}

// class LadiesNightError extends LadiesNightStates {
//   final String message;

//   LadiesNightError(this.message);
// }
