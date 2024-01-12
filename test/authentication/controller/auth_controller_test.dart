//
//
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:htp_customer/authentication/controllers/auth_controller.dart';
// import 'package:htp_customer/authentication/data/service/auth_service.dart';
// import 'package:htp_customer/authentication/data/service/fcm_services.dart';
// import 'package:htp_customer/authentication/data/service/firebase_auth_service.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class MockFirebaseAuthenticate extends Mock implements FirebaseAuthenticate{}
// class MockAuthService extends Mock implements AuthService{}
// class MockFCMServices extends Mock implements FCMServices{}
// class MockSharedPreferences extends Mock implements SharedPreferences{}
//
// void main(){
//   final fireService = MockFirebaseAuthenticate();
//   final authService = MockAuthService();
//   final fcmService = MockFCMServices();
//   final sharePrefs = MockSharedPreferences();
//
//   ProviderContainer makeAuthProviderContainer(){
//     final authController = AuthController(fireService, authService, fcmService, sharePrefs);
//     final container = ProviderContainer(
//       overrides: [
//         authProvider.overrideWith((ref) => authController)]
//     );
//     addTearDown(() => container.dispose);
//     return container;
//   }
//
//   test('Check init call for no user', () {
//     final container = makeAuthProviderContainer();
//     final controller = container.read(authProvider);
//     when(() => sharePrefs.getBool('onboard')).thenReturn(true);
//     when(() => fireService.geCurrentUser()).thenReturn(null);
//     print(controller);
//     expect(controller, AuthLoggedInState);
//   });
//
//
// }