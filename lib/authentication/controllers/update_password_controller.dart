
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/service/auth_service.dart';

final updatePasswordProvider = StateNotifierProvider<UpdatedPasswordController, UPState>((ref) {
  final service = ref.watch(authServiceProvider);
  return UpdatedPasswordController(service);
});

class UpdatedPasswordController extends StateNotifier<UPState>{
  final AuthService _service;
  UpdatedPasswordController(this._service):super(UPInitial());

  updatePassword(String email, newPassword)async{
    try{
      state = UPLoading();
      await _service.updatePassword(email, newPassword);
      state = UPSuccess();
    }catch(e){
      state = UPError(e.toString());
    }
  }

}

abstract class UPState{}

class UPInitial extends UPState{}

class UPLoading extends UPState{}

class UPError extends UPState{
  final String msg;
  UPError(this.msg);
}

class UPSuccess extends UPState{}