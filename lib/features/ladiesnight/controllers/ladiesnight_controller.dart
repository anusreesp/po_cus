import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/features/ladiesnight/data/models/ladiesclub_response.dart';
import 'package:htp_customer/features/ladiesnight/data/services/ladiesnight_services.dart';
import 'package:htp_customer/features/ladiesnight/widget/weekdays.dart';

import '../../dashboard/controllers/location_controller.dart';

final ladiesNightProvider =
    StateNotifierProvider<LadiesNightController, LadiesNightStates>((ref) {
  final service = ref.watch(ladiesNightServiceProvider);
  final userLocation = ref.watch(userLocationProvider);
  final selectedDay = ref.watch(dayPickProvider);
  return LadiesNightController(service, userLocation, selectedDay);
});

class LadiesNightController extends StateNotifier<LadiesNightStates> {
  final LadiesNightClubServices _services;
  final LocationStates _userLocation;
  final String selectedDay;
  LadiesNightController(this._services, this._userLocation, this.selectedDay)
      : super(LadiesNightLoading()) {
    getLadiesNight();
  }

  getLadiesNight() async {
    try {
      state = LadiesNightLoading();

      if (_userLocation is LocationLoaded) {
        final location = _userLocation as LocationLoaded;
        final data = await _services.getLadiesNightNew(
            location.cityName, selectedDay,
            lat: location.lat, lng: location.lng);
        state = LadiesNightLoaded(data);
      } else {
        state = LadiesNightError('Location data unavailable!');
      }
    } catch (e) {
      if (mounted) {
        state = LadiesNightError(e.toString());
      }
    }
  }
}

class LadiesNightStates {}

class LadiesNightLoaded extends LadiesNightStates {
  final List<LadiesNightData> ladiesNight;

  LadiesNightLoaded(this.ladiesNight);
}

class LadiesNightLoading extends LadiesNightStates {}

class LadiesNightError extends LadiesNightStates {
  final String message;

  LadiesNightError(this.message);
}
