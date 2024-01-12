
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/authentication/controllers/signup_controller.dart';
import 'package:htp_customer/authentication/data/models/city_list.dart';
import 'package:htp_customer/authentication/data/models/country_list.dart';
import 'package:htp_customer/authentication/data/service/auth_service.dart';

final countryListProvider = FutureProvider.autoDispose<List<CountryData>>((ref) async{
  final service = ref.watch(authServiceProvider);
  return await service.getCountries();
});

// final cityListProvider = FutureProvider.autoDispose<List<CityData>>((ref) async{
//   final service = ref.watch(authServiceProvider);
//   final countryProvider = ref.watch(countryIdProvider);
//   if(countryProvider == null){
//     return [];
//   }
//   return await service.getCities(countryProvider);
// });
//
// final cityListProvider = StateNotifierProvider.autoDispose<CityListController, List<CityData>>((ref) {
//   final service = ref.watch(authServiceProvider);
//   final countryId = ref.watch(countryIdProvider);
//   return CityListController(service, countryId);
// });
//
// class CityListController extends StateNotifier<List<CityData>>{
//   final AuthService _service;
//   final String? countryId;
//   CityListController(this._service, this.countryId):super([]){
//     getCities(null);
//   }
//
//   getCities(String? searchName) async{
//     try{
//       if(countryId == null){
//         state = [];
//       }else{
//         final cities = await _service.getCities(countryId!, name: searchName);
//         state = cities;
//       }
//     }catch(e){
//       print(e);
//
//     }
//   }
//
// }