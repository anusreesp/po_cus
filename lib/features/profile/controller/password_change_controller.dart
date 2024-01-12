import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../authentication/data/service/firebase_auth_service.dart';

final passwordChangeProvider =
    StateNotifierProvider<PasswordChangeController, PasswordChangeState>((ref) {
  final auth = ref.watch(firebaseAuthServiceProvider);
  return PasswordChangeController(auth);
});

class PasswordChangeController extends StateNotifier<PasswordChangeState> {
  final FirebaseAuthenticate _auth;
  PasswordChangeController(this._auth) : super(PasswordChangeInitial());

  changePassword(String currentPass, String newPass) async {
    try {
      state = PasswordChangeLoading();
      await _auth.updatePassword(currentPass, newPass);
      state = PasswordChangeSuccess();
    } catch (e) {
      if (e ==
          'The password is invalid or the user does not have a password.') {
        state = PasswordChangeError(
            'Incorrect current password, please check your password and try again ');
      } else {
        state = PasswordChangeError(e.toString());
      }
    }
  }
}

abstract class PasswordChangeState {}

class PasswordChangeInitial extends PasswordChangeState {}

class PasswordChangeLoading extends PasswordChangeState {}

class PasswordChangeSuccess extends PasswordChangeState {}

class PasswordChangeError extends PasswordChangeState {
  final String msg;
  PasswordChangeError(this.msg);
}
