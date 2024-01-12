import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../authentication/data/service/firebase_auth_service.dart';

final emailVerificationProvider = StateNotifierProvider.autoDispose<
    EmailVerificationController, EmailVerificationStates>((ref) {
  final fireAuth = ref.watch(firebaseAuthServiceProvider);
  return EmailVerificationController(fireAuth);
});

class EmailVerificationController
    extends StateNotifier<EmailVerificationStates> {
  final FirebaseAuthenticate _fireAuth;
  EmailVerificationController(this._fireAuth)
      : super(EmailVerificationLoading()) {
    isEmailVerify();
  }

  isEmailVerify() async {
    try {
      state = EmailVerificationLoading();
      await _fireAuth.reloadUser();
      final isVerified = _fireAuth.isEmailVerified;

      final email = _fireAuth.geCurrentUser()?.email ?? '';
      state = EmailVerificationLoaded(isVerified, email);
    } catch (e) {
      state = EmailVerificationError(e.toString());
    }
  }

  userReload() async {
    state = EmailVerificationLoading();
    await _fireAuth.reloadUser();
    isEmailVerify();
  }
}

abstract class EmailVerificationStates {}

class EmailVerificationLoading extends EmailVerificationStates {}

class EmailVerificationLoaded extends EmailVerificationStates {
  final bool isVerifed;
  final String email;
  EmailVerificationLoaded(this.isVerifed, this.email);
}

class EmailVerificationError extends EmailVerificationStates {
  final String msg;
  EmailVerificationError(this.msg);
}
