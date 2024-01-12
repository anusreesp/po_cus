

import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../authentication/controllers/auth_controller.dart';
import '../../../authentication/data/service/auth_service.dart';
import '../data/services/profile_services.dart';

final deleteAccountProvider = StateNotifierProvider.autoDispose<DeleteAccountController, DeleteAccountStates>((ref) {
  final auth = ref.watch(authServiceProvider);
  final profile = ref.watch(profileServiceProvider);
  return DeleteAccountController(auth, profile,FirebaseAuth.instance);
});

class DeleteAccountController extends StateNotifier<DeleteAccountStates>{
  final AuthService _authService;
  final ProfileServices _profileService;
  final FirebaseAuth _auth;
  // final ProfileLoaded? _profile;
  DeleteAccountController(this._authService, this._profileService,this._auth):super(DeleteAccountInitialState());

  sendOtp(String mobile) async{
    try{
      state = DeleteAccountLoading();
      _authService.sendOtp(mobile);
      state = DeleteAccountInitialState();
    }catch(e){
      state = DeleteAccountErrorState(e.toString());
    }
  }

  // deleteAccount(String mobile, String otp) async{
  //   try{
  //     state = DeleteAccountLoading();
  //     final result = await _authService.verifyOtp(mobile, otp);
  //     if(result == true){
  //       await _profileService.deleteAccount();
  //       state = DeleteSuccessState();
  //     }else{
  //       state = DeleteAccountErrorState('OTP verification failed!');
  //     }
  //   }catch(e){
  //     state = DeleteAccountErrorState(e.toString());
  //   }
  // }

  deleteAccount(String password,) async {
      try{
        state = DeleteAccountLoading();
        if(password != "") {
          final cred = EmailAuthProvider.credential(
              email: _auth.currentUser!.email!, password: password);
          await _auth.currentUser!.reauthenticateWithCredential(cred);
          await _profileService.deleteAccount();
          state = DeleteSuccessState(
              "Your account deletion request is accepted..but still you have 7 days to think and to login again");
        }else{
          await _profileService.deleteAccount();
        }
      }catch(err){
        state = DeleteAccountErrorState("Incorrect Password");
      }
  }

  }

abstract class DeleteAccountStates{}

class DeleteAccountInitialState extends DeleteAccountStates{}

class DeleteAccountLoading extends DeleteAccountStates{}

class DeleteSuccessState extends DeleteAccountStates{
  final String successMsg;
  DeleteSuccessState(this.successMsg);
}

class DeleteAccountErrorState extends DeleteAccountStates{
  final String msg;
  DeleteAccountErrorState(this.msg);
}