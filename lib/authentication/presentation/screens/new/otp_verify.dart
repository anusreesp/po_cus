// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:htp_customer/common/widgets_common/floatingSubmitButton.dart';
// import 'package:htp_customer/htp_theme.dart';
// import 'package:otp_text_field/otp_field.dart';
// import 'package:pinput/pinput.dart';
//
// import '../../../../common/widgets_common/needles_widget.dart';
// import '../../../controllers/auth_controller.dart';
// import '../../../controllers/mobile_verification_controller.dart';
// import '../../widgets/social_button.dart';
// import '../login.dart';
//
// final optNumberProvider = StateProvider.autoDispose<String?>((ref) => null);
//
// class OtpVerification extends ConsumerWidget {
//   final String mobile;
//   OtpVerification({
//     required this.mobile,
//     super.key,
//   });
//
//   OtpFieldController otpController = OtpFieldController();
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Verify your phone number",
//           style: tenor22White,
//         ),
//       ),
//       body: buildBody(context, ref),
//     );
//   }
//
//   final defaultPinTheme = PinTheme(
//     width: 42,
//     height: 42,
//     textStyle: man14White,
//     // decoration: const BoxDecoration(),
//   );
//
//   final cursor = Column(
//     mainAxisAlignment: MainAxisAlignment.end,
//     children: [
//       Container(
//         width: 56,
//         height: 3,
//         // decoration: BoxDecoration(
//         //   color: HtpTheme.goldenColor,
//         //   borderRadius: BorderRadius.circular(8),
//         // ),
//       ),
//       NeedleDoubleSided(
//         width: 100,
//       ),
//     ],
//   );
//
//   final preFilledWidget = Column(
//     mainAxisAlignment: MainAxisAlignment.end,
//     children: [
//       Container(
//         width: 56,
//         height: 1.5,
//
//         // decoration: BoxDecoration(
//         //   color: HtpTheme.goldenColor,
//         //   borderRadius: BorderRadius.circular(8),
//         // ),
//       ),
//       NeedleDoubleSided(
//         width: 100,
//       ),
//     ],
//   );
//
//   Widget buildBody(BuildContext context, WidgetRef ref) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           SizedBox(
//             height: MediaQuery.of(context).size.height * 0.09,
//           ),
//           // Row(
//           //   children: [
//           //     IconButton(
//           //         onPressed: () {
//           //           Navigator.of(context).pop();
//           //         },
//           //         icon: const Icon(
//           //           Icons.arrow_back,
//           //           color: Colors.white,
//           //         )),
//           //     Text(
//           //       "Verify your phone number",
//           //       style: tenor23White,
//           //     ),
//           //   ],
//           // ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(
//                   height: 4,
//                 ),
//                 Text(
//                   "Enter your OTP code here",
//                   style: tenor16White,
//                 ),
//                 const SizedBox(
//                   height: 40,
//                 ),
//
//                 //----------------------Pinput--------------------------
//                 Pinput(
//                   length: 6,
//                   showCursor: true,
//                   onChanged: (pin) {
//                     ref.read(optNumberProvider.notifier).state = pin;
//                   },
//                   defaultPinTheme: defaultPinTheme,
//                   cursor: cursor,
//                   preFilledWidget: preFilledWidget,
//                 ),
//                 const SizedBox(
//                   height: 12,
//                 ),
//                 GestureDetector(
//                     onTap: () {
//                       ref
//                           .read(mobileVerificationProvider.notifier)
//                           .sendOtp(mobile);
//                     },
//                     child: const Text(
//                       "Resend OTP",
//                       style: man12Gold,
//                     )),
//                 const SizedBox(
//                   // height: MediaQuery.of(context).size.height * 0.45,
//                   height: 32,
//                 ),
//                 Center(
//                   child: FloatingSubmitButton(onTap: () {}, text: "Continue"),
//                 ),
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.38,
//                 ),
//                 Center(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       if (Platform.isIOS)
//                         SocialButton(
//                             onTap: () {
//                               ref.read(authProvider.notifier).appleLogin();
//                             },
//                             iconPath: 'assets/svg/icons/social/apple.svg'),
//                       if (Platform.isIOS)
//                         const SizedBox(
//                           width: 16,
//                         ),
//                       SocialButton(
//                           onTap: () {
//                             ref.read(authProvider.notifier).googleLogin();
//                           },
//                           iconPath: 'assets/svg/icons/social/google.svg'),
//                     ],
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text(
//                       "Already have an account?",
//                       style: man14White1,
//                     ),
//                     TextButton(
//                       child: const Text(
//                         "Sign In",
//                         style: man14Gold,
//                       ),
//                       onPressed: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => LoginPage()));
//                       },
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
