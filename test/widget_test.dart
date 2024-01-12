//
// import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
// import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:htp_customer/authentication/controllers/auth_controller.dart';
// import 'package:htp_customer/authentication/controllers/fcm_controller.dart';
// import 'package:htp_customer/authentication/data/service/auth_service.dart';
// import 'package:htp_customer/authentication/data/service/fcm_services.dart';
// import 'package:htp_customer/authentication/data/service/firebase_auth_service.dart';
// import 'package:htp_customer/firebase_options.dart';
//
// import 'package:htp_customer/main.dart';
// import 'package:htp_customer/networking/http_client.dart';
// import 'package:mocktail/mocktail.dart';
//
// // class MockAuthController extends Mock implements AuthController{}
// class MockFCM extends Mock implements FCMServices{}
//
// void main() {
//   // setupFirebaseAuthMocks();
//   //
//   // setUpAll(() async{
//   //   await Firebase.initializeApp(
//   //     name: 'new',
//   //     options: DefaultFirebaseOptions.currentPlatform,
//   //   );
//   // });
//
//   final user = MockUser(
//     isAnonymous: false,
//     uid: 'someuid',
//     email: 'mock@user.com',
//     displayName: 'Mock User'
//   );
//
//   final mockAuth = MockFirebaseAuth(mockUser: user);
//   final fakeFire = FakeFirebaseFirestore();
//
//   final service = AuthService(NetworkClient(), fakeFire);
//   final fireAuth = FirebaseAuthenticate(mockAuth);
//   final fcm = MockFCM();
//
//   testWidgets('Find circular progress on app opening', (WidgetTester tester) async {
//
//     // Build our app and trigger a frame.
//     await tester.pumpWidget(ProviderScope(
//         overrides: [
//           // authServiceProvider.overrideWithValue(service),
//           // firebaseAuthServiceProvider.overrideWithValue(fireAuth),
//           // fcmProvider.overrideWith((ref) => FCMController(fcm, _ref)),
//           // authProvider.overrideWith((ref) => AuthController(fireAuth, service, fcm))
//         ],
//         child: const MyApp()));
//   });
//
//   // expect(find.byType(CircularProgressIndicator), findsOneWidget);
//
//
// }
