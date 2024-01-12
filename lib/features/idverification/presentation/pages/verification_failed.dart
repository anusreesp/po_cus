// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:htp_customer/features/idverification/presentation/widgets/greycard.dart';
// import 'package:htp_customer/features/idverification/presentation/widgets/titleanddesc.dart';
// import 'package:htp_customer/features/idverification/presentation/widgets/verify_appbar.dart';
// import 'package:htp_customer/htp_theme.dart';

// import '../../../../common/widgets_common/rounded_golden_button.dart';

// class VerificationFailed extends StatelessWidget {
//   VerificationFailed({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: VerifyAppBar(
//             hideBackButton: true,
//             // leftSpace: 12,
//             child: Text(
//               "ID Verification",
//               style: HtpTheme.newTitleTextStyle,
//             )),
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

//             // Padding(
//             //   padding:
//             //       const EdgeInsets.symmetric(horizontal: 16.0, vertical: 34),
//             //   child: Container(
//             //     width: double.infinity,
//             //     decoration: BoxDecoration(
//             //         borderRadius: BorderRadius.circular(8),
//             //         color: HtpTheme.cardBlackColor),
//             GreyCard(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const SizedBox(
//                     height: 64,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       SvgPicture.asset(
//                         "assets/svg/images/verification/userid/userid_remove.svg",
//                         width: 140,
//                         height: 95,
//                       ),
//                       const SizedBox(
//                         width: 32,
//                       ),
//                       SvgPicture.asset(
//                         "assets/svg/images/verification/user/user_remove_red.svg",
//                         width: 100,
//                         height: 70,
//                       ),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 40,
//                   ),
//                   const TitleAndDesc(
//                     title: "ID verification failed",
//                     desc:
//                         "Your id verification failed due to one more below reasons",
//                     horiPadding: 54,
//                   ),
//                   const SizedBox(
//                     height: 24,
//                   ),
//                 ],
//               ),
//             ),
//             // ),

//             const SizedBox(
//               height: 4,
//             ),
//             Column(
//               children: [
//                 ...points.map((e) => Padding(
//                       padding: const EdgeInsets.only(left: 40.0),
//                       child: missingPoints(e),
//                     ))
//               ],
//             ),
//             const SizedBox(
//               height: 24,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 SizedBox(
//                   width: 155,
//                   child: RoundedGoldenButton(
//                     onTap: () {
//                       //---------------------------------------- Back Home -------------------------------------------------------
//                       // Navigator.push(
//                       //     context,
//                       //     MaterialPageRoute(
//                       //         builder: (context) => VerificationFailed()));
//                     },
//                     text: "RE-VERIFY",
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

//   final List points = [
//     "Photo on ID does not match selfie.",
//     "ID/Selfie not clear, use proper lighting and retake.",
//     "Invalid Information on ID submitted"
//   ];

//   Widget missingPoints(String data) {
//     return Container(
//       padding: EdgeInsets.only(bottom: 10),
//       child: Row(
//         children: [
//           Icon(
//             Icons.circle,
//             size: 5,
//             color: HtpTheme.whiteColor.withOpacity(0.75),
//           ),
//           const SizedBox(
//             width: 3,
//           ),
//           Text(
//             data,
//             style: TextStyle(
//               fontFamily: "Montserrat",
//               fontSize: 11,
//               color: HtpTheme.whiteColor.withOpacity(0.55),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
