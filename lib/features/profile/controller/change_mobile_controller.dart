import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/features/profile/data/services/profile_services.dart';

import '../../../authentication/data/service/auth_service.dart';

final selectedCountryCodeProvider = StateProvider.autoDispose<String?>((ref) {
  return null;
});

final selectedMobileProvider = StateProvider<String>((ref) {
  return "";
});

final changeMobileProvider = StateNotifierProvider.autoDispose<
    ChangeMobileController, ChangeMobileControllerStates>((ref) {
  final mobileNumber = ref.watch(selectedMobileProvider);
  final serviceController = ref.watch(authServiceProvider);
  final profileService = ref.watch(profileServiceProvider);

  return ChangeMobileController(
      mobileNumber, serviceController, profileService);
});

class ChangeMobileController
    extends StateNotifier<ChangeMobileControllerStates> {
  ChangeMobileController(
      this.selectedMobileCode, this._service, this._profileServices)
      : super(ChangeMobileControllerInitial());

  final String selectedMobileCode;
  final AuthService _service;
  final ProfileServices _profileServices;

  sendMobileOtp(String selectedMobile) async {
    try {
      state = ChangeMobileControllerLoading();

      await _service.sendOtp(selectedMobile);

      state = ChangeMobileControllerLoaded();
    } catch (e) {
      if (e.toString() == "Invalid parameter `To`: $selectedMobile") {
        state = ChangeMobileControllerError('Invalid Format');
      } else {
        state = ChangeMobileControllerError(e.toString());
      }
    }
  }

  Future<bool> verifyOtp(String mobile,) async {
    try {
      state = ChangeMobileControllerLoading();

      // final isSuccess = await _service.verifyOtp(mobile, otp);
      // if (isSuccess) {
        await _profileServices.updatePhone(mobile);
        state = ChangeMobileControllerLoaded();
        return true;
      // } else {
      //   state = ChangeMobileControllerError('Validation failed');
      //   return false;
      // }
    } catch (e) {
      print(e);
      state = ChangeMobileControllerError(e.toString());
      return false;
    }
  }
}

abstract class ChangeMobileControllerStates {}

class ChangeMobileControllerInitial extends ChangeMobileControllerStates {}

class ChangeMobileControllerLoaded extends ChangeMobileControllerStates {}

class ChangeMobileControllerLoading extends ChangeMobileControllerStates {}

class ChangeMobileControllerError extends ChangeMobileControllerStates {
  final String msg;
  ChangeMobileControllerError(this.msg);
}
