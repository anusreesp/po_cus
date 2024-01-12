
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/features/dashboard/controllers/location_controller.dart';

import '../../../common/services/location_service.dart';

final locationBackgroundProvider = StateNotifierProvider((ref) {
  final locationController = ref.watch(userLocationProvider.notifier);
  final locationControllerState = ref.watch(userLocationProvider);
  final locationService = ref.watch(locationProvider);
  return LocationBackgroundController(locationController, locationService, locationControllerState);
});

class LocationBackgroundController extends StateNotifier<LocationBackgroundState>{
  final LocationController _locationController;
  final LocationService _service;
  final LocationStates _locationState;
  LocationBackgroundController(this._locationController, this._service, this._locationState):super(LocationBackgroundLoading()){
    init();
  }

  // bool displayedOnce = false;

  init() async{
    state = LocationBackgroundLoading();
    try{
      if(_locationState is LocationLoaded){
        final currentLocation = await _service.getPosition();
        final cityData = await _locationController.getCityName(currentLocation.latitude, currentLocation.longitude);

        ///If user current location is selected location manually
        if(cityData != null && cityData.cityName?.toLowerCase() == (_locationState as LocationLoaded).cityName.toLowerCase()){
          final location = _locationState as LocationLoaded;
          if(location.lat == null || location.lng == null){
            state = LocationLatLngFetched(currentLocation.latitude, currentLocation.longitude, cityData.cityName ?? '');
          }
        }

        ///This section get executed only if location is changed.
        if(cityData != null && cityData.cityName?.toLowerCase() != (_locationState as LocationLoaded).cityName.toLowerCase()){

          if(_locationController.canDisplayLocationPopup){
            state = LocationChanged(currentLocation.latitude, currentLocation.longitude, cityData.cityName ?? '');
            // displayedOnce = true;
          }
        }
      }
    }catch(e){
      print('LOCATION BACKGROUND ERROR : $e');
      state = LocationBackgroundError(e.toString());
    }
  }




}

abstract class LocationBackgroundState{}

class LocationBackgroundLoading extends LocationBackgroundState{}

class LocationChanged extends LocationBackgroundState{
  final double newLat;
  final double newLng;
  final String cityName;
  LocationChanged(this.newLat, this.newLng, this.cityName);
}

class LocationLatLngFetched extends LocationBackgroundState{
  final double lat;
  final double lng;
  final String cityName;
  LocationLatLngFetched(this.lat, this.lng, this.cityName);
}

class LocationBackgroundError extends LocationBackgroundState{
  final String msg;
  LocationBackgroundError(this.msg);
}