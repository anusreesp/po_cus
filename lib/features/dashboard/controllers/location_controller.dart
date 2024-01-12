
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/authentication/data/service/auth_service.dart';
import 'package:htp_customer/authentication/data/service/firebase_auth_service.dart';
import 'package:htp_customer/networking/http_client.dart';
import 'package:htp_customer/shared_prefs_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../authentication/controllers/auth_controller.dart';
import '../../../common/services/location_service.dart';
import '../data/services/dashboard_service.dart';

final userLocationProvider = StateNotifierProvider<LocationController, LocationStates>((ref) {
  ref.watch(authProvider);
  final service = ref.watch(locationProvider);
  final client = ref.watch(clientProvider);
  final prefs = ref.watch(sharedPrefsProvider);
  final dashboard = ref.watch(dashboardServiceProvider);
  final uid = ref.watch(firebaseAuthServiceProvider).uid;
  return LocationController(service, client, prefs, dashboard, uid);
});

class LocationController extends StateNotifier<LocationStates>{
  final LocationService _service;
  final NetworkClient _client;
  final SharedPreferences _preference;
  final DashboardService _dashboardService;
  final String uid;
  LocationController(this._service, this._client, this._preference, this._dashboardService, this.uid):super(LocationLoading()){
    getUserLocation();
  }

  bool canDisplayLocationPopup = true;

  Timer? _timer;

  getUserLocation() async{
    try{
      state = LocationLoading();
      ///Checks if location is stored then show data according to that location
      String? savedCity = _preference.getString(SharedPrefsKey.cityName);
      if(savedCity != null){
        final savedLat = _preference.getDouble(SharedPrefsKey.lat);
        final savedLng = _preference.getDouble(SharedPrefsKey.lng);
        state = LocationLoaded(cityName: savedCity, lat: savedLat, lng: savedLng);
        return;
      }
      /// Start timer for 10 seconds, if location not fetched in 10 seconds show error
      _timer = Timer(const Duration(seconds: 10), () {
        if(state is! LocationLoaded){
          state = LocationError('Location fetching timed out');
        }
      });
      ///Else follow the process of getting location from user and save it
      final location = await _service.getPosition();
      final cityData = await getCityName(location.latitude, location.longitude);
      if(cityData?.cityName != null){
        _persistLocation(cityData!.cityName!, location.latitude, location.longitude);
      }
      // print(cityName);
      state = LocationLoaded(
          cityName: cityData?.cityName ?? 'Select location',
          lat: location.latitude,
          lng: location.longitude,
          countryName: cityData?.countryName);

      _timer?.cancel();
    }catch(e){
      state = LocationError(e.toString());
    }
  }

  selectManualLocation(String cityName, String cityId, String? country){
    canDisplayLocationPopup = false;
    _persistLocation(cityName, null, null);
    _preference.remove(SharedPrefsKey.lat);
    _preference.remove(SharedPrefsKey.lng);
    state = LocationLoaded(cityName: cityName, cityId: cityId, countryName: country);
  }

  updateLocation(String cityName, double lat, double lng){
    _preference.setString(SharedPrefsKey.cityName, cityName);
    _preference.setDouble(SharedPrefsKey.lat, lat);
    _preference.setDouble(SharedPrefsKey.lng, lng);
    state = LocationLoaded(cityName: cityName, lng: lng, lat: lat);
  }

  ///Convert lat lng to city name using google api
  Future<CityLocationData?> getCityName(double lat, double lng) async{
    try{
      final url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&result_type=locality&key=AIzaSyDVGZduFw4ELHysbjSvnAKAwyf_cxHJTAA';
      final response = await _client.getRequestNoToken(url);
      print("lat-long--------------->${response.data}");
      final allComponent = response.data['results'] as List;
      final addressComponent = allComponent.last['address_components'];

      // return addressComponent.first['long_name'];
      recordCityOnServer(addressComponent.first['long_name'], addressComponent.last['long_name']);
      return CityLocationData(
        cityName: addressComponent.first['long_name'],
        countryName: addressComponent.last['long_name']
      );
    }catch(e){
      print("Google geocoding error: $e");
      return null;
    }
  }

  Future<void> recordCityOnServer(String city, String country)async{
    try{
      String? savedCity = _preference.getString(SharedPrefsKey.cityName)?.toLowerCase();
      final currentCity = city.toLowerCase();
      ///Save city is null means user does not have have previous location, we save
      ///the current location as active location
      if(savedCity == null){
        _dashboardService.saveCurrentLocation(currentCity, country.toLowerCase(), uid);
      }else{
        ///User have last location, so save the current city and saved city in location history
        _dashboardService.saveCurrentLocation(currentCity, country.toLowerCase(), uid);
        _dashboardService.saveLocationHistory(currentCity, country.toLowerCase(), uid);
      }
    }catch(e){
      print('CITY RECORD FAILED');
    }
  }

  void _persistLocation(String city, double? lat, double? lng){
    _preference.setString(SharedPrefsKey.cityName, city);
    if(lat != null && lng != null){
      _preference.setDouble(SharedPrefsKey.lat, lat);
      _preference.setDouble(SharedPrefsKey.lng, lng);
    }
  }

}

abstract class LocationStates{}

class LocationLoading extends LocationStates{}

class LocationLoaded extends LocationStates{
  ///Lat lng is null means user has not given permission for location
  final double? lat;
  final double? lng;
  final String cityName;
  final String? cityId;
  final String? countryName;

  LocationLoaded({
    required this.cityName,
    this.cityId,
    this.lat,
    this.lng,
    this.countryName
  });
}

class LocationDenied extends LocationStates{}

class LocationError extends LocationStates{
  final String msg;
  LocationError(this.msg);
}

class CityLocationData{
  String? cityName;
  String? countryName;
  CityLocationData({
    this.cityName,
    this.countryName
});
}