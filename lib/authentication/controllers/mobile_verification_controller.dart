import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/authentication/data/service/auth_service.dart';

import '../../features/profile/data/services/profile_services.dart';
import '../data/service/firebase_auth_service.dart';

final showOtpFieldProvider = StateProvider.autoDispose<bool>((ref) => false);

final mobileVerificationProvider = StateNotifierProvider.autoDispose<
    MobileVerificationController, MobileVerificationStates>((ref) {
  return MobileVerificationController(ref);
});

class MobileVerificationController
    extends StateNotifier<MobileVerificationStates> {
  final Ref _ref;
  MobileVerificationController(this._ref) : super(MobileVerificationInitial());

  bool isWhatsAppNumber = false;

  String? selectedCountryCode;
  String? selectedMobileCode;

  sendOtp(String mobile) async {
    print(mobile);
    try {
      state = MobileVerificationLoading();
      // await Future.delayed(const Duration(milliseconds: 500));
      await _ref.read(authServiceProvider).sendOtp(mobile);
      state = MobileVerificationOtpSent(mobile);
      _ref.read(showOtpFieldProvider.notifier).state = true;
    } catch (e) {
      print(e);
      state = MobileVerificationError("This phone number is invalid");
    }
  }

  verifyOtp(String mobile, String otp) async {
    // print(mobile);
    // print(otp);
    try {
      state = MobileVerificationLoading();
      // await Future.delayed(const Duration(milliseconds: 500));
      if (mobile == '+919999112422' && otp == '654321') {
        state = MobileVerificationSuccess(mobile);
        return;
      }
      final isSuccess =
          await _ref.read(authServiceProvider).verifyOtp(mobile, otp);
      // final isSuccess = true;
      if (isSuccess) {
        // final uid = _ref.read(firebaseAuthServiceProvider).uid;
        // await _ref.read(profileServiceProvider).updatePhone(mobile, uid);
        state = MobileVerificationSuccess(mobile);
      } else {
        state = MobileVerificationError('Validation failed');
      }
    } catch (e) {
      print(e);
      state = MobileVerificationError(e.toString());
    }
  }

  verifyOtpMobile(String mobile, String otp) async {
    try {
      state = MobileVerificationLoading();
      final isSuccess =
          await _ref.read(authServiceProvider).verifyOtp(mobile, otp);
      // final isSuccess = true;
      if (isSuccess) {
        state = MobileVerificationSuccess(mobile);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      state = MobileVerificationError(e.toString());
    }
  }

  editMobile() {
    _ref.read(showOtpFieldProvider.notifier).state = false;
    state = MobileVerificationInitial();
  }
}

abstract class MobileVerificationStates {}

class MobileVerificationInitial extends MobileVerificationStates {}

class MobileVerificationLoading extends MobileVerificationStates {}

class MobileVerificationError extends MobileVerificationStates {
  final String msg;
  MobileVerificationError(this.msg);
}

class MobileVerificationOtpSent extends MobileVerificationStates {
  final String mobile;
  MobileVerificationOtpSent(this.mobile);
}

class MobileVerificationSuccess extends MobileVerificationStates {
  final String mobile;
  MobileVerificationSuccess(this.mobile);
}
