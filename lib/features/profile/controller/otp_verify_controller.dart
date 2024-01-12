import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/features/profile/data/services/profile_services.dart';

import '../../../authentication/data/service/firebase_auth_service.dart';

final otpVerificationProvider = StateNotifierProvider.autoDispose<
    OtpVerificationController, OtpVerificationStates>((ref) {
  return OtpVerificationController(ref);
});
final otpTimer = StateProvider.autoDispose<bool>((ref) => false);

class OtpVerificationController extends StateNotifier<OtpVerificationStates> {
  final AutoDisposeStateNotifierProviderRef ref;
  OtpVerificationController(this.ref) : super(OtpVerificationInitial()) {
    // startTimer();
  }
  // Timer ? _timer;
  // void startTimer()async{
  //   int start = 60;
  //   const oneSec = const Duration(seconds: 1);
  //   _timer = Timer.periodic(
  //     oneSec,
  //         (Timer timer) {
  //       if (start == 0) {
  //           timer.cancel();
  //       } else {
  //           start = start - 1;
  //           ref.read(otpTimer.notifier).state = start;
  //       }
  //     },
  //   );
  // }

  verifyOtp(String otp, String email) async {
    final uid = ref.read(firebaseAuthServiceProvider).uid;
    Future res;
    try {
      state = OtpVerifyLoading();
      final otpRes = await ref.read(profileServiceProvider).verifyEmailOtp(otp, email);
      if(otpRes == true){
        await ref.read(profileServiceProvider).updateEmail(email, uid);
        state = OtpVerifySuccess();
        return true;
      }else {
        state = OtpVerifyFailed("Invalid OTP entered");
        return false;
      }
    } catch (err) {
      print(err.toString());
      state = OtpVerifyFailed(err.toString());
    }
  }
}

abstract class OtpVerificationStates {}

class OtpVerificationInitial extends OtpVerificationStates {}

class OtpVerifySuccess extends OtpVerificationStates {}

class OtpVerifyFailed extends OtpVerificationStates {
  final String msg;

  OtpVerifyFailed(this.msg);
}

class OtpVerifyLoading extends OtpVerificationStates {}
