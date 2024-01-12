

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../authentication/data/service/firebase_auth_service.dart';

final emailUpdateProvider = StateNotifierProvider<EmailUpdateController, EmailUpdateState>((ref) {
  final service = ref.watch(firebaseAuthServiceProvider);
  return EmailUpdateController(service);
});

class EmailUpdateController extends StateNotifier<EmailUpdateState>{
  final FirebaseAuthenticate _service;
  EmailUpdateController(this._service):super(EmailUpdateInitial());

  updateEmail(String email)async{
    try{
      state = EmailUpdateLoading();
     await _service.updateEmail(email);
     state = EmailUpdateSuccess();
    }catch(e){
      state = EmailUpdateError(e.toString());
    }
  }

}

abstract class EmailUpdateState{}

class EmailUpdateInitial extends EmailUpdateState{}

class EmailUpdateLoading extends EmailUpdateState{}

class EmailUpdateSuccess extends EmailUpdateState{}

class EmailUpdateError extends EmailUpdateState{
  final String msg;
  EmailUpdateError(this.msg);
}