import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/features/profile/data/services/profile_services.dart';

final otpTextFieldProvider = StateProvider.autoDispose<String>((ref) {
  return '';
});

final otpVerifyEmailProvider = StateNotifierProvider.autoDispose<
    OTPVerifyCommonNotifier, OTPCVerifyStates>((ref) {
  final services = ref.watch(profileServiceProvider);
  return OTPVerifyCommonNotifier(services);
});

class OTPVerifyCommonNotifier extends StateNotifier<OTPCVerifyStates> {
  final ProfileServices _profileServices;

  OTPVerifyCommonNotifier(this._profileServices) : super(OTPCVerifyInitial());

  verifyEnterOtp(String otp, String email) async {
    try {
      state = OTPCVerifyLoading();

      final otpResponse = await _profileServices.verifyEmailOtp(otp, email);
      if (otpResponse == true) {
        final verifyResponse =
            await _profileServices.afterVerifyEmailUsingOtp(email);

        if (verifyResponse == true) {
          if (mounted) {
            state = OTPCVerifySuccess();
          }
          return true;
        } else {
          state = OTPCVerifyError("Invalid OTP entered");
          return false;
        }
      } else {
        state = OTPCVerifyError("Invalid OTP entered");
        return false;
      }
    } catch (e) {
      if (mounted) {
        state = OTPCVerifyError(e.toString());
      }
      rethrow;
    }
  }
}

abstract class OTPCVerifyStates {}

class OTPCVerifyInitial extends OTPCVerifyStates {}

class OTPCVerifyLoading extends OTPCVerifyStates {}

class OTPCVerifySuccess extends OTPCVerifyStates {}

class OTPCVerifyError extends OTPCVerifyStates {
  final String msg;
  OTPCVerifyError(this.msg);
}
