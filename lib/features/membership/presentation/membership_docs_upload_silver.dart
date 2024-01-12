// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:htp_customer/features/dashboard/presentation/widgets/custom_app_bar.dart';
// import 'package:htp_customer/features/idverification/presentation/pages/docs/img_capture.dart';
// import 'package:htp_customer/features/idverification/presentation/widgets/add_doc.dart';
// import 'package:htp_customer/htp_theme.dart';
// import 'package:htp_customer/common/widgets_common/rounded_golden_button.dart';
//
// import '../controller/membership_application_controller.dart';
// import '../data/model/membership_response.dart';
//
// class MembershipDocsUploadSilver extends StatefulWidget {
//   const MembershipDocsUploadSilver({super.key});
//
//   @override
//   State<MembershipDocsUploadSilver> createState() =>
//       _MembershipDocsUploadSilverState();
// }
//
// class _MembershipDocsUploadSilverState
//     extends State<MembershipDocsUploadSilver> {
//   File? frontId;
//   File? backId;
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//       appBar: const CustomAppBar(
//         showProfile: false,
//       ),
//       body: SingleChildScrollView(
//         child: Center(
//             child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.fromLTRB(22, 0, 0, 12),
//               child: Text(
//                 "Verify Your ID",
//                 style: HtpTheme.newTitleTextStyle,
//                 // style: Theme.of(context)
//                 //     .textTheme
//                 //     .headline3
//                 //     ?.apply(color: Colors.white),
//               ),
//             ),
//             Container(
//               // padding:
//               // const EdgeInsets.symmetric(horizontal: 16.0),
//               margin: const EdgeInsets.symmetric(horizontal: 18),
//               // width: double.infinity,
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(8),
//                   color: HtpTheme.cardBlackColor),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const SizedBox(
//                     height: 40,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       AddDocument(
//                           title: "Front",
//                           isStar: true,
//                           imageFile: frontId,
//                           buttonText: frontId == null ? "Add" : "Retake",
//                           path:
//                               "assets/svg/images/verification/userid/userid_profile.svg",
//                           onTapFunc: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) =>
//                                         const ImageCapture())).then((value) {
//                               frontId = value;
//                               setState(() {});
//                             });
//                           }),
//                       // const Spacer(),
//                       // const SizedBox(
//                       //   width: 24,
//                       // ),
//                       AddDocument(
//                           title: "Back",
//                           isStar: false,
//                           imageFile: backId,
//                           buttonText: backId == null ? "Add" : "Retake",
//                           path:
//                               "assets/svg/images/verification/userid/userid.svg",
//                           onTapFunc: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => const ImageCapture(
//                                           scanTitle: 'Scan back of ID',
//                                         ))).then((value) {
//                               backId = value;
//                               setState(() {});
//                             });
//                           }),
//                       // const SizedBox(
//                       //   width: 4,
//                       // ),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 34,
//                   ),
//                   const Text(
//                     "Scan your ID document",
//                     style: TextStyle(
//                         fontFamily: "Montserrat",
//                         fontSize: 20,
//                         color: HtpTheme.goldenColor,
//                         fontWeight: FontWeight.w600),
//                   ),
//                   const SizedBox(
//                     height: 12,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 28.0),
//                     child: Text(
//                       "Ready, set, attach - front side first! Also, don't forget to attach the back side if there's any information present.",
//                       style: HtpTheme.newTitleTextStyle
//                           .apply(fontSizeFactor: 0.70),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 54,
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 24,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Consumer(
//                   builder: (context, ref, _) {
//                     return SizedBox(
//                       width: 155,
//                       child: RoundedGoldenButton(
//                         onTap: () {
//                           if (frontId == null) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(
//                                     content: Text('Upload your id !')));
//                           } else {}
//                         },
//                         text: "CONTINUE",
//                         height: 40,
//                       ),
//                     );
//                   },
//                 ),
//                 const SizedBox(
//                   width: 20,
//                 ),
//               ],
//             ),
//           ],
//         )),
//       ),
//     ));
//   }
// }
