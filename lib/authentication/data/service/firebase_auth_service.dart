import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

final firebaseAuthServiceProvider =
    Provider((ref) => FirebaseAuthenticate(FirebaseAuth.instance));

class FirebaseAuthenticate {
  FirebaseAuthenticate(this._auth);

  final FirebaseAuth _auth;

  Stream<User?> authStateChanges() => _auth.authStateChanges();

  User? geCurrentUser() => _auth.currentUser;

  String get uid => _auth.currentUser?.uid ?? '';

  reloadUser() async {
    await geCurrentUser()?.reload();
  }

  //------------------------------New Registration  ----------------------------------------
  Future<UserCredential> registerUsingEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw ('The password provided is weak.');
      } else if (e.code == 'email-already-in-use') {
        throw ('The account already exists for this email.');
      } else {
        throw e.code;
      }
    } catch (_) {
      rethrow;
    }
  }

  //-------------------------------------- Email Verified --------------------------------------

  bool get isEmailVerified => _auth.currentUser?.emailVerified ?? false;

  // Future sentEmailVerificationLink() async {
  //   try {
  //     final verification = await _auth.currentUser?.sendEmailVerification();
  //
  //     return verification;
  //   } catch (e) {
  //     print("An error occured while trying to send email verification");
  //     print(e.toString());
  //   }
  // }

  //-------------------------------------- Login for existing Users ---------------------------------------
  Future<UserCredential> loginUsingEmailAndPassword(
      {required String email, required String password}) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      debugPrint("${_auth.currentUser?.uid}");

      return credential;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      switch (e.code) {
        case "INVALID_LOGIN_CREDENTIALS":
          throw 'Incorrect email or password, please check and try again.';

        default:
          throw e.message.toString();
      }
    } catch (e) {
      throw e.toString();
      rethrow;
    }
  }

  Future<UserCredential?> linkEmailUser(String email, String password) async {
    try {
      final credential =
          EmailAuthProvider.credential(email: email, password: password);
      return await _auth.currentUser?.linkWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "provider-already-linked":
          throw ("The provider has already been linked to the user.");
        case "invalid-credential":
          throw ("The provider's credential is not valid.");
        case "credential-already-in-use":
          throw ("The account corresponding to the credential already exists, "
              "or is already linked to a Firebase User.");
        // See the API reference for the full list of error codes.
        default:
          throw (e.message ?? "Unknown error.");
      }
    }
  }

  Future<void> unlinkProvider(String providerId) async {
    try {
      await _auth.currentUser?.unlink(providerId);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "no-such-provider":
          throw ("The user isn't linked to the provider or the provider "
              "doesn't exist.");
        default:
          throw (e.message ?? "Unknown error.");
      }
    }
  }

  // Future<UserCredential> signIn(String otp, String verificationId) async {
  //   return await _auth.signInWithCredential(
  //       PhoneAuthProvider.credential(
  //           verificationId: verificationId, smsCode: otp));
  // }

//-------------------------------------- Log out from the app -------------------------------------
  Future<void> signOut() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final isGoogleLoggedIn = await googleSignIn.isSignedIn();
      if (isGoogleLoggedIn) {
        await googleSignIn.signOut();
      }
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

//-------------------------------------  SignIn With Google   ---------------------------------------------------
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      final googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount == null) {
        throw 'Google authentication failed!';
      }
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final cred = await _auth.signInWithCredential(credential);
      await cred.user?.updateDisplayName(googleSignInAccount.displayName);
      await cred.user?.updateEmail(googleSignInAccount.email);

      return cred;
    } on FirebaseAuthException catch (e) {
      throw e.message.toString();
    } catch (_) {
      rethrow;
    }
  }

  //------------------------------------ Signin facebook --------------------------------------------
  Future<UserCredential> signInFacebook() async {
    FirebaseAuth auth = _auth;
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      switch (result.status) {
        case LoginStatus.success:
          final AuthCredential facebookCredential =
              FacebookAuthProvider.credential(result.accessToken!.token);

          final cred = await auth.signInWithCredential(facebookCredential);
          final fbData = await FacebookAuth.instance.getUserData();
          await cred.user?.updateEmail(fbData['email']);
          await cred.user?.updateDisplayName(fbData['name']);
          return cred;
        case LoginStatus.cancelled:
          throw 'Login cancelled by user';
        case LoginStatus.failed:
          throw 'Login failed';
        default:
          return throw 'Login failed';
      }
    } on FirebaseAuthException catch (e) {
      throw e.message.toString();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> resetPasswordEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw e.message.toString();
    } catch (_) {
      rethrow;
    }
  }

  Future<void> updateEmail(String newEmail) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await user.updateEmail(newEmail);
      }
    } on FirebaseAuthException catch (e) {
      throw e.message ?? e.code;
    } catch (_) {
      rethrow;
    }
  }

  Future<void> updatePassword(
      String currentPassword, String newPassword) async {
    try {
      final cred = EmailAuthProvider.credential(
          email: _auth.currentUser!.email!, password: currentPassword);

      await _auth.currentUser!.reauthenticateWithCredential(cred);

      await _auth.currentUser!.updatePassword(newPassword);
      // await _auth.currentUser?.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      throw e.message ?? e.code;
    } catch (_) {
      rethrow;
    }
  }

  //-------------------------------------- Phone Verification -----------------------------------------
  // static Future<User?> verifyPhoneNumber(
  //     {required String mobile,
  //     // required verificationCompleted,
  //     // required verificationFailed,
  //     required codeSent,
  //     required codeAutoRetrievalTimeout}) async {
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   String otp, authStatus = "";
  //
  //   try {
  //     auth.verifyPhoneNumber(
  //         phoneNumber: mobile,
  //         timeout: Duration(seconds: 60),
  //         verificationCompleted: (AuthCredential authCredential) async {
  //           authStatus = "Your account is successfully verified";
  //           // var result = await auth.signInWithCredential(authCredential);
  //           // User? user = result.user;
  //         },
  //         verificationFailed: (FirebaseAuthException authException) {
  //           authStatus = "sorry.....Your account is unsuccessfully verified";
  //         },
  //         codeSent: codeSent,
  //         codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  //   } catch (e) {}
  //   return null;
  //   // on FirebaseAuthException catch(e) {}
  // }

  //------------------------   Apple Login ----------------------------------
  Future<UserCredential> appleLogin() async {
    try {
      final rawNonce = generateNonce();
      final nonce = _sha256ofString(rawNonce);

      final credential = await SignInWithApple.getAppleIDCredential(scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ], nonce: nonce);

      final oAuthCredential = OAuthProvider('apple.com')
          .credential(idToken: credential.identityToken, rawNonce: rawNonce);
      print("Name: ${credential.toString()}");
      print("Name2: ${credential.givenName}");
      print("Name3: ${credential.familyName}");

      final cred =  await _auth.signInWithCredential(oAuthCredential);
      if(credential.givenName != null){
        await cred.user?.updateDisplayName(credential.givenName);
      }
      return cred;
    } catch (_) {
      rethrow;
    }
  }

//-----------------------------------------  phoneSignIn -------------------------------------
//   Future<void> phoneSignIn({
//     required String phoneNumber,
//     required onVerificationCompleted,
//     required onVerificationFailed,
//     required onCodeSent,
//   }) async {
//     FirebaseAuth auth = FirebaseAuth.instance;
//     await auth.verifyPhoneNumber(
//         phoneNumber: phoneNumber,
//         verificationCompleted: onVerificationCompleted,
//         verificationFailed: onVerificationFailed,
//         codeSent: onCodeSent,
//         codeAutoRetrievalTimeout: (String timeout) {
//           return null;
//         });
//   }

  //------------------------   forgetPassword  --------------------------------

  static Future<User?> forgetPassword(
      {required String code, required String newPassword}) async {
    User? user;
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.confirmPasswordReset(code: code, newPassword: newPassword);
    } catch (e) {}
    return user;
  }

  /// Generates a cryptographically secure random nonce, to be included in a
  /// credential request.
  String _generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}

//----------------------------------------------------------------------------------

class Resource {
  final Status status;
  Resource({required this.status});
}

enum Status { success, error, cancelled }
