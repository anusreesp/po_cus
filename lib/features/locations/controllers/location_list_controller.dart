import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/features/locations/data/models/location_list_response.dart';
import 'package:htp_customer/features/locations/data/services/location_service.dart';

final locationListProvider = StateNotifierProvider((ref) {
  final service = ref.watch(locationServiceProvider);
  return LocationListController(service);
});

class LocationListController extends StateNotifier<LocationListStates> {
  final LocationServices _services;

  LocationListController(this._services) : super(LocationListLoading()) {
    getLocation();
  }

  getLocation() async {
    try {
      state = LocationListLoading();
      final data = await _services.getLocationList();
      state = LocationListLoaded(data);
    } catch (e) {
      state = LocationListError(e.toString());
    }
  }
}

abstract class LocationListStates {}

class LocationListLoading extends LocationListStates {}

class LocationListLoaded extends LocationListStates {
  final List<LocationData> location;
  LocationListLoaded(this.location);
}

class LocationListError extends LocationListStates {
  final String message;
  LocationListError(this.message);
}
