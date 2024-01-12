import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/authentication/data/models/signup_data.dart';

import '../data/service/auth_service.dart';
import '../data/service/fcm_services.dart';
import '../data/service/firebase_auth_service.dart';

final genderProvider = StateProvider.autoDispose<String?>((ref) => null);

final maritalProvider = StateProvider.autoDispose<String?>((ref) => null);

final countryIdProvider = StateProvider.autoDispose<int?>((ref) => null);

final selectedStateIdProvider = StateProvider<int?>((ref) => null);

final whatsAppToggleValueProvider =
    StateProvider.autoDispose<bool>((ref) => false);

final termsAndConditionProvider =
    StateProvider.autoDispose<bool>((ref) => false);

final smokePreferenceProvider = StateProvider.autoDispose<bool?>((ref) => null);
final drinkPreferenceProvider = StateProvider.autoDispose<bool?>((ref) => null);

final signupProvider =
    StateNotifierProvider.autoDispose<SignupController, SignupStates>((ref) {
  final service = ref.watch(authServiceProvider);
  final fireAuth = ref.watch(firebaseAuthServiceProvider);
  final fcm = ref.watch(fcmServiceProvider);
  return SignupController(service, fireAuth, fcm);
});

class SignupController extends StateNotifier<SignupStates> {
  final AuthService _service;
  final FirebaseAuthenticate _fireAuth;
  final FCMServices _fcmServices;
  SignupController(this._service, this._fireAuth, this._fcmServices)
      : super(SignupInitialState());

  emailSignup(SignupData data) async {
    print(data.toJson());
    state = SignupLoading();
    try {
      final credential = await _fireAuth.registerUsingEmailPassword(
          email: data.email, password: data.password!);
      final fcm = await _fcmServices.getToken();
      await credential.user?.updateDisplayName(data.name);
      await _service.signup(data, credential.user!.uid, fcm);
      FirebaseAnalytics.instance.logSignUp(signUpMethod: 'Email/Password');
      state = SignupSuccess();
    } catch (e) {
      if (mounted) {
        if (e == "The account already exists for this email.") {
          state = SignupError(
              'It seems like this email is already registered with us. Kindly proceed to sign in');
        } else {
          state = SignupError(e.toString());
        }
      }
    }
  }

  updateData(SignupData data) async {
    print(data.toJson());
    state = SignupLoading();
    try {
      final uid = _fireAuth.uid;
      final fcm = await _getSafeToken();
      // _fireAuth.geCurrentUser()?.sendEmailVerification();
      await _service.signup(data, uid, fcm);
      state = SignupSuccess();
    } catch (e) {
      state = SignupError(e.toString());
    }
  }

  Future<String?> _getSafeToken() async {
    try {
      return await _fcmServices.getToken();
    } catch (_) {
      return null;
    }
  }
}

abstract class SignupStates {}

class SignupInitialState extends SignupStates {}

class SignupLoading extends SignupStates {}

class SignupError extends SignupStates {
  final String msg;
  SignupError(this.msg);
}

class SignupSuccess extends SignupStates {}
