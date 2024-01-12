// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:htp_customer/features/idverification/presentation/pages/verification_failed.dart';
// import 'package:htp_customer/features/idverification/presentation/pages/view_id.dart';
// import 'package:htp_customer/features/idverification/presentation/widgets/verify_appbar.dart';
// import 'package:htp_customer/htp_theme.dart';
// import 'package:htp_customer/common/widgets_common/rounded_golden_button.dart';

// class VerifiedAll extends StatelessWidget {
//   const VerifiedAll({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: VerifyAppBar(
//           hideBackButton: false,
//           leftSpace: 4,
//           child: Text(
//             "ID Verification",
//             style: HtpTheme.newTitleTextStyle,
//           ),
//         ),
//         body: buildBody(context),
//       ),
//     );
//   }

//   Widget buildBody(BuildContext context) {
//     return SingleChildScrollView(
//       child: Center(
//         child: Column(
//           children: [
//             // Column(
//             //   children: [
//             const SizedBox(
//               height: 44,
//             ),

//             Padding(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 16.0, vertical: 34),
//               child: Container(
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8),
//                     color: HtpTheme.cardBlackColor),
//                 child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const SizedBox(
//                         height: 64,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           SvgPicture.asset(
//                             "assets/svg/images/verification/userid/userid_added_yellow.svg",
//                             width: 140,
//                             height: 95,
//                           ),
//                           const SizedBox(
//                             width: 32,
//                           ),
//                           SvgPicture.asset(
//                             "assets/svg/images/verification/user/user_yellowtick.svg",
//                             width: 100,
//                             height: 70,
//                           ),
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 40,
//                       ),
//                       const Text(
//                         "Verified!",
//                         style: TextStyle(
//                             fontFamily: "Montserrat",
//                             fontSize: 20,
//                             color: HtpTheme.goldenColor,
//                             fontWeight: FontWeight.w600),
//                       ),
//                       const SizedBox(
//                         height: 12,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 48.0),
//                         child: Text(
//                           "Your ID has been verified and approved by Party.one",
//                           style: HtpTheme.newTitleTextStyle
//                               .apply(fontSizeFactor: 0.70),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 24,
//                       ),

//                       GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => const ViewID()));
//                         },
//                         child: const Text(
//                           "View ID",
//                           style: TextStyle(
//                               decoration: TextDecoration.underline,
//                               fontSize: 12,
//                               fontWeight: FontWeight.w600,
//                               fontFamily: "Montserrat",
//                               color: HtpTheme.goldenColor),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 32,
//                       ),
//                       // Container(
//                       //   width: 150,
//                       //   child: AddDocument.addButton(() {
//                       //     Navigator.push(
//                       //         context,
//                       //         MaterialPageRoute(
//                       //             builder: (context) => const SelfieCapture()));
//                       //   }, "Retake"),
//                       // ),
//                       // const SizedBox(
//                       //   height: 32,
//                       // ),
//                     ]),
//               ),
//             ),

//             //-----------------------------
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 SizedBox(
//                   width: 180,
//                   child: RoundedGoldenButton(
//                     onTap: () {
//                       //---------------------------------------- Back Home -------------------------------------------------------
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => VerificationFailed()));
//                     },
//                     text: "BACK TO HOME",
//                     textStyle: const TextStyle(
//                         fontFamily: "Montserrat",
//                         fontWeight: FontWeight.w600,
//                         fontSize: 15,
//                         color: HtpTheme.blackColor),
//                     height: 45,
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 20,
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
