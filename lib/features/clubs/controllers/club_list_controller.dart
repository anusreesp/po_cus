import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/features/clubs/data/models/club_list_api_response.dart';
import 'package:htp_customer/features/clubs/data/services/club_services.dart';
import 'package:htp_customer/features/dashboard/controllers/location_controller.dart';
import 'package:intl/intl.dart';

final clubListProvider =
    StateNotifierProvider<ClubListController, ClubListStates>((ref) {
  final service = ref.watch(clubServiceProvider);
  final userLocation = ref.watch(userLocationProvider);
  return ClubListController(service, userLocation);
});

class ClubListController extends StateNotifier<ClubListStates> {
  final ClubServices _services;
  final LocationStates _userLocation;
  ClubListController(this._services, this._userLocation)
      : super(ClubsLoading()) {
    //Used when call api on page load
    getClubs();
  }

  getClubs() async {
    if (!mounted) {
      return;
    }
    try {
      state = ClubsLoading();
      if (_userLocation is LocationLoaded) {
        final location = _userLocation as LocationLoaded;
        final today = DateTime.now();
        final todayDay = DateFormat('EEEE').format(today);
        final timeInMinutes = today.hour * 60 + today.minute;

        final newList = await _services.getClubsFromApi(
            location.cityName, todayDay, timeInMinutes,
            lat: location.lat, lng: location.lng);
        // final data = await _services.getClubList(filterType);
        state = ClubLoaded(newList);
      } else {
        state = ClubError('Location data unavailable!');
      }
    } catch (e) {
      if (mounted) {
        state = ClubError(e.toString());
      }
    }
  }
}

abstract class ClubListStates {}

//Classes for various stages and all will extend abstract class
class ClubsLoading extends ClubListStates {}

class ClubLoaded extends ClubListStates {
  final List<ClubDataNew> clubs;
  ClubLoaded(this.clubs);
}

class ClubError extends ClubListStates {
  final String msg;
  ClubError(this.msg);
}
