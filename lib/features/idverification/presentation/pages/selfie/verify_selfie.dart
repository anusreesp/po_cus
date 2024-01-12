// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:htp_customer/features/idverification/presentation/pages/selfie/selfie_capture.dart';
// import 'package:htp_customer/features/idverification/presentation/widgets/add_doc.dart';
// import 'package:htp_customer/features/idverification/presentation/widgets/verify_appbar.dart';
// import 'package:htp_customer/htp_theme.dart';
// import 'package:htp_customer/common/widgets_common/rounded_golden_button.dart';

// class VerifySelfie extends StatelessWidget {
//   const VerifySelfie({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: VerifyAppBar(
//           hideBackButton: false,
//           leftSpace: 4,
//           child: Text(
//             "Verify Selfie",
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
//             Column(
//               children: [
//                 const SizedBox(
//                   height: 44,
//                 ),
//                 SvgPicture.asset(
//                   "assets/svg/images/verification/userid/userid_added_blue.svg",
//                   width: 120,
//                   height: 90,
//                 ),
//                 Text(
//                   "ID sent for verification!",
//                   style: HtpTheme.detailTitleText
//                       .apply(color: HtpTheme.goldenColor),
//                 )
//               ],
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
//                         height: 40,
//                       ),
//                       SvgPicture.asset(
//                         "assets/svg/images/verification/user/user_load_in.svg",
//                         width: 200,
//                         height: 115,
//                       ),
//                       const SizedBox(
//                         height: 30,
//                       ),
//                       const Text(
//                         "Say Cheeese!!",
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
//                         padding: const EdgeInsets.symmetric(horizontal: 54.0),
//                         child: Text(
//                           "Finally we just need a selfie of you straight on",
//                           style: HtpTheme.newTitleTextStyle
//                               .apply(fontSizeFactor: 0.70),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 30,
//                       ),
//                       Container(
//                         width: 150,
//                         child: AddDocument.addButton(() {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => SelfieCapture(onCapture: (XFile file){},)));
//                         }, "Take a selfie"),
//                       ),
//                       const SizedBox(
//                         height: 32,
//                       ),
//                     ]),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
