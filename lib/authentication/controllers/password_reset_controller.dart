

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/authentication/data/service/auth_service.dart';
import 'package:htp_customer/authentication/data/service/firebase_auth_service.dart';

final passwordResetProvider = StateNotifierProvider<PasswordResetController, PasswordResetState>((ref){
  final service = ref.watch(authServiceProvider);
  return PasswordResetController(service);
});

class PasswordResetController extends StateNotifier<PasswordResetState>{
  final AuthService _service;
  PasswordResetController(this._service): super(PasswordInitialState());

  sentEmailResetLink(String email) async{
    try{
      state = ResetLoading();
      await _service.sendEmailOtp(email);
      state = ResetLinkSentState();
    }catch(e){
      state = ResetErrorState(e.toString());
    }
  }

}

abstract class PasswordResetState{}

class PasswordInitialState extends PasswordResetState{}

class ResetLoading extends PasswordResetState{}

class ResetLinkSentState extends PasswordResetState{}

class ResetErrorState extends PasswordResetState{
  final String msg;
  ResetErrorState(this.msg);
}

