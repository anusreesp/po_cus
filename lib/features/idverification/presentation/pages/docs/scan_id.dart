// import 'package:flutter/material.dart';
// import 'package:htp_customer/features/idverification/presentation/pages/docs/img_capture.dart';
// import 'package:htp_customer/features/idverification/presentation/pages/selfie/verify_selfie.dart';
// import 'package:htp_customer/features/idverification/presentation/widgets/add_doc.dart';
// import 'package:htp_customer/features/idverification/presentation/widgets/verify_appbar.dart';
// import 'package:htp_customer/htp_theme.dart';
// import 'package:htp_customer/common/widgets_common/rounded_golden_button.dart';

// class ScanIDFont extends StatelessWidget {
//   const ScanIDFont({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//       appBar: VerifyAppBar(
//         hideBackButton: true,
//         child: Text(
//           "Verify ID",
//           style: HtpTheme.newTitleTextStyle,
//         ),
//       ),
//       body: buildBody(context),
//     ));
//   }

//   Widget buildBody(BuildContext context) {
//     return SingleChildScrollView(
//       child: Center(
//           child: Column(
//         children: [
//           Padding(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 16.0, vertical: 52),
//               child: Container(
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8),
//                     color: HtpTheme.cardBlackColor),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const SizedBox(
//                       height: 40,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         AddDocument(
//                             title: "Front",
//                             isStar: true,
//                             path:
//                                 "assets/svg/images/verification/userid/userid_profile.svg",
//                             onTapFunc: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => ImageCapture())).then((value) => print("RETURNED FILE: $value"));
//                             }),
//                         // const Spacer(),
//                         const SizedBox(
//                           width: 24,
//                         ),
//                         AddDocument(
//                             title: "Back",
//                             isStar: false,
//                             path:
//                                 "assets/svg/images/verification/userid/userid.svg",
//                             onTapFunc: () {}),
//                         const SizedBox(
//                           width: 4,
//                         ),
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 54,
//                     ),
//                     const Text(
//                       "Scan your ID document",
//                       style: TextStyle(
//                           fontFamily: "Montserrat",
//                           fontSize: 20,
//                           color: HtpTheme.goldenColor,
//                           fontWeight: FontWeight.w600),
//                     ),
//                     const SizedBox(
//                       height: 12,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 46.0),
//                       child: Text(
//                         "Ready, set, attach - front end first ! Also, don't forget to attach the back end if it's a driver's license.",
//                         style: HtpTheme.newTitleTextStyle
//                             .apply(fontSizeFactor: 0.70),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 54,
//                     ),
//                   ],
//                 ),
//               )),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               SizedBox(
//                 width: 155,
//                 child: RoundedGoldenButton(
//                   onTap: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const VerifySelfie()));
//                   },
//                   text: "CONTINUE",
//                   height: 45,
//                 ),
//               ),
//               const SizedBox(
//                 width: 20,
//               ),
//             ],
//           )
//         ],
//       )),
//     );
//   }
// }

// class ScanIDBack extends StatelessWidget {
//   const ScanIDBack({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//       appBar: VerifyAppBar(
//         hideBackButton: true,
//         child: Text(
//           "Verify ID",
//           style: HtpTheme.newTitleTextStyle,
//         ),
//       ),
//       body: buildBody(),
//     ));
//   }

//   Widget buildBody() {
//     return Container();
//   }
// }
