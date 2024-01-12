
import 'package:change_case/change_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/features/profile/data/models/additional_profile_info.dart';
import 'package:htp_customer/features/profile/data/models/profile_response.dart';

import '../data/services/profile_services.dart';

enum GenderSelection {male, female, other; String get desc => name.toTitleCase();}

final genderProvider = StateProvider.autoDispose<GenderSelection?>((ref)=>null);
final smokeProvider = StateProvider.autoDispose<bool?>((ref) => null);
final alcoholProvider = StateProvider.autoDispose<bool?>((ref)=>null);
final clubbingProvider = StateProvider.autoDispose<String?>((ref) => null);
final driveProvider = StateProvider.autoDispose<bool?>((ref)=>null);
final homeCountryID = StateProvider.autoDispose<int?>((ref) => null);
final homeStateID = StateProvider.autoDispose<int?>((ref) => null);
final homeCityID = StateProvider.autoDispose<int?>((ref) => null);
final dobProvider = StateProvider.autoDispose<DateTime?>((ref) => null);
final isChooseCountry = StateProvider.autoDispose<bool>((ref) => false);
final isChooseState = StateProvider.autoDispose<bool>((ref) => false);
final isChooseCity = StateProvider.autoDispose<bool>((ref) => false);

final profileUpdatedProvider = StateNotifierProvider((ref) {
  final service = ref.watch(profileServiceProvider);
  return ProfileUpdateController(service);
});

class ProfileUpdateController extends StateNotifier<ProfileUpdateStates>{
  final ProfileServices _services;
  ProfileUpdateController(this._services): super(ProfileUpdatedInitial()){
    // init();
  }


  updateProfile(UserEditModel data) async{
    print(data.toJson());
    try{
      state = ProfileUpdateLoading();
      await _services.updateProfile(data);
      state = ProfileUpdatedInitial();
    }catch(e){
      state = ProfileUpdateError(e.toString());
    }
  }

  // Future<void> init() async{
  //   state = ProfileUpdateLoading();
  //   final data = await _services.getAdditionalProfileData();
  //
  //   state=ProfileUpdateLoaded(data);
  // }

}

abstract class ProfileUpdateStates{}

class ProfileUpdatedInitial extends ProfileUpdateStates{}

class ProfileUpdateLoading extends ProfileUpdateStates{}

class ProfileUpdateLoaded extends ProfileUpdateStates{
  ProfileInfo profileData;
  ProfileUpdateLoaded(this.profileData);
}

class ProfileUpdateError extends ProfileUpdateStates{
  final String msg;
  ProfileUpdateError(this.msg);
}

