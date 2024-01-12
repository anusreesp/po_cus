import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../authentication/data/service/firebase_auth_service.dart';
import '../data/services/profile_services.dart';

final emailLinkProvider =
    StateNotifierProvider<EmailLinkController, EmailLinkState>((ref) {
  final fireAuth = ref.watch(firebaseAuthServiceProvider);
  final profileServices = ref.watch(profileServiceProvider);
  return EmailLinkController(fireAuth, profileServices);
});

class EmailLinkController extends StateNotifier<EmailLinkState> {
  final FirebaseAuthenticate _fireAuth;
  final ProfileServices _profileServices;
  EmailLinkController(this._fireAuth, this._profileServices)
      : super(EmailLinkInitial());
  //SPwFajJuSBZgONCVr4Ql0BsyZr72

  Future<void> linkEmail(String email, password, providerId) async {
    try {
      state = EmailLinkLoading();
      // await Future.delayed(const Duration(seconds: 2));
      final userCred = await _fireAuth.linkEmailUser(email, password);
      if (userCred?.user != null) {
        await _fireAuth.unlinkProvider(providerId);
        await _profileServices.updateEmail(email, userCred!.user!.uid);
      }
      state = EmailLinkSuccess();
    } catch (e) {
      state = EmailLinkError(e.toString());
    }
  }
}

abstract class EmailLinkState {}

class EmailLinkInitial extends EmailLinkState {}

class EmailLinkLoading extends EmailLinkState {}

class EmailLinkSuccess extends EmailLinkState {}

class EmailLinkError extends EmailLinkState {
  final String msg;
  EmailLinkError(this.msg);
}
