// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:htp_customer/features/idverification/presentation/pages/selfie/selfie_capture.dart';
// import 'package:htp_customer/features/idverification/presentation/pages/verified.dart';
// import 'package:htp_customer/features/idverification/presentation/widgets/add_doc.dart';
// import 'package:htp_customer/features/idverification/presentation/widgets/verify_appbar.dart';
// import 'package:htp_customer/htp_theme.dart';
// import 'package:htp_customer/common/widgets_common/rounded_golden_button.dart';

// class SentForVerify extends StatelessWidget {
//   const SentForVerify({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: VerifyAppBar(
//           hideBackButton: false,
//           leftSpace: 4,
//           child: Text(
//             "Sent for verification",
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
//             //     SvgPicture.asset(
//             //       "assets/svg/images/verification/userid/userid_added_blue.svg",
//             //       width: 120,
//             //       height: 90,
//             //     ),
//             //     Text(
//             //       "ID sent for verification!",
//             //       style: HtpTheme.detailTitleText
//             //           .apply(color: HtpTheme.goldenColor),
//             //     )
//             //   ],
//             // ),
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
//                         height: 60,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           SvgPicture.asset(
//                             "assets/svg/images/verification/userid/user_id_load.svg",
//                             width: 140,
//                             fit: BoxFit.cover,
//                             height: 95,
//                           ),
//                           const SizedBox(
//                             width: 32,
//                           ),
//                           SvgPicture.asset(
//                             "assets/svg/images/verification/user/user_load.svg",
//                             width: 100,
//                             height: 70,
//                           ),
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 30,
//                       ),
//                       const Text(
//                         "Sent for verification",
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
//                         padding: const EdgeInsets.symmetric(horizontal: 36.0),
//                         child: Text(
//                           "Your ID has been sent for verification. We will notify you once it is complete.",
//                           style: HtpTheme.newTitleTextStyle
//                               .apply(fontSizeFactor: 0.70),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 42,
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
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const VerifiedAll()));
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
