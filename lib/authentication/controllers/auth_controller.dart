import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/common/utils/member_utils.dart';
import 'package:htp_customer/networking/http_client.dart' as client;
import 'package:htp_customer/shared_prefs_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/service/auth_service.dart';
import '../data/service/fcm_services.dart';
import '../data/service/firebase_auth_service.dart';

final authProvider = StateNotifierProvider<AuthController, AuthState>((ref) {
  final authService = ref.watch(firebaseAuthServiceProvider);
  final authService2 = ref.watch(authServiceProvider);
  final fcm = ref.watch(fcmServiceProvider);
  final prefs = ref.watch(sharedPrefsProvider);
  return AuthController(authService, authService2, fcm, prefs);
});

class AuthController extends StateNotifier<AuthState> {
  final FirebaseAuthenticate _service;
  final AuthService _authService;
  final FCMServices _fcm;
  final SharedPreferences _prefs;
  AuthController(this._service, this._authService, this._fcm, this._prefs)
      : super(AuthInitialState()) {
    checkUser();
  }

  Future<void> checkUser() async {
    state = AuthLoadingState();
    try {
      // final prefs = await SharedPreferences.getInstance();
      final onboard = _prefs.getBool('onboard');
      // _prefs.clear();
      if (onboard == null || onboard == false) {
        state = AuthOnboard();
        return;
      }

      final user = _service.geCurrentUser();
      //Token stored in global variable of htt client file
      client.uid = user?.uid;
      client.idToken = await user?.getIdToken(true);
      String? activeMembershipName;

      if (user != null) {
        // print(user.providerData);
        // await _authService.createLog(user.uid);
        final userData = await _authService.readUserData(user.uid);
        // if(userData == null){
        //   state = LoggedInWithoutPhone();
        //   return;
        // }

        // LocationService().getPosition();
        if (userData?.containsKey('active_membership_name') ?? false) {
          activeMembershipName = userData!['active_membership_name'];
        }

        if (userData == null || !userData.containsKey('name')) {
          //While social signup data from social stored in firebase
          //Fetch the stored name and email
          state =
              LoggedInWithoutData(name: user.displayName, email: user.email);
          return;
        }

        state = AuthLoggedInState(
            MemberUtils.getMembershipTypeByName(activeMembershipName));
      } else {
        state = AuthInitialState();
      }
    } on FirebaseException catch(e){
      switch(e.code){
        case 'user-token-expired':
          state = AuthErrorState('User logged out from this device');
          return;

        default:
          state = AuthErrorState(e.message ?? e.code);
          return;
      }
    } catch (e) {
      print("Auth Check: ${e.toString()}");
      state = AuthErrorState(e.toString());
    }
  }

  emailLogin(String email, String password,BuildContext context) async {
    try {
      state = AuthLoadingState();
      final credential = await _service.loginUsingEmailAndPassword(
          email: email, password: password,);
      print(">>>>>>${credential.user}");
      //update fcm
      final token = await _fcm.getToken();
      if (token != null && credential.user != null) {
        await _authService.updateDeviceToken(token, credential.user!.uid);
        FirebaseAnalytics.instance.logLogin(loginMethod: 'email');
      }

      checkUser();
    } catch (e) {
      print(">>>>>>${e.toString()}");
      if (e ==
          "The password is invalid or the user does not have a password.") {
        state =
            AuthErrorState('Incorrect password, please check and try again');
      } else if (e ==
          "There is no user record corresponding to this identifier. The user may have been deleted." || e == "An internal error has occurred. [ INVALID_LOGIN_CREDENTIALS ]") {
        state = AuthErrorState(
            "This email ID is not associated with any account. Kindly enter the correct email ID.");
      }else{
        state = AuthErrorState(e.toString());
      }
    }
  }

  fbLogin() async {
    try {
      state = AuthLoadingState();
      final credential = await _service.signInFacebook();
      //update fcm
      final token = await _fcm.getToken();
      if (token != null && credential.user != null) {
        await _authService.updateDeviceToken(token, credential.user!.uid);
        FirebaseAnalytics.instance.logLogin(loginMethod: 'facebook');
      }
      checkUser();
    } catch (e) {
      state = AuthErrorState(e.toString());
    }
  }

  googleLogin() async {
    try {
      state = AuthLoadingState();
      final credential = await _service.signInWithGoogle();
      //update fcm
      final token = await _fcm.getToken();
      if (token != null && credential.user != null) {
        await _authService.updateDeviceToken(token, credential.user!.uid);
        FirebaseAnalytics.instance.logLogin(loginMethod: 'google');
      }
      checkUser();
    } catch (e) {
      state = AuthErrorState(e.toString());
    }
  }

  appleLogin() async {
    try {
      state = AuthLoadingState();
      final credential = await _service.appleLogin();
      //update fcm
      final token = await _fcm.getToken();
      if (token != null && credential.user != null) {
        await _authService.updateDeviceToken(token, credential.user!.uid);
        FirebaseAnalytics.instance.logLogin(loginMethod: 'apple');
      }
      checkUser();
    } catch (e) {
      state = AuthErrorState(e.toString());
    }
  }

  Future<void> logOut() async {
    try {
      final token = await _fcm.getToken();
      if (token != null) {
        await _authService.removeDeviceToken(token, _service.uid);
      }
      _prefs.clear();
      _prefs.setBool('onboard', true);
      FirebaseAnalytics.instance.logEvent(name: 'logout');
      await _service.signOut();
      checkUser();
    } catch (e) {
      print(e.toString());
    }
  }

  // loadVideo()async{
  //   try{
  //
  //   }catch(e){
  //     print(e.toString());
  //   }
  // }
}

abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthLoggedInState extends AuthState {
  final MembershipType activeMembership;
  AuthLoggedInState(this.activeMembership);
}

class AuthErrorState extends AuthState {
  final String msg;
  AuthErrorState(this.msg);
}

// class LoggedInWithoutPhone extends AuthState{
//   final String? name;
//   final String? email;
//   LoggedInWithoutPhone({this.name, this.email});
// }

class LoggedInWithoutData extends AuthState {
  final String? name;
  final String? email;
  LoggedInWithoutData({this.name, this.email});
}

class AuthOnboard extends AuthState {}
