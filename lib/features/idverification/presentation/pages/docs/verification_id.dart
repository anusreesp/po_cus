// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:htp_customer/features/dashboard/presentation/widgets/custom_app_bar.dart';
// import 'package:htp_customer/features/idverification/presentation/pages/docs/scan_id.dart';
// import 'package:htp_customer/features/idverification/presentation/widgets/redirection_buttons.dart';
// import 'package:htp_customer/features/idverification/presentation/widgets/verify_appbar.dart';
// import 'package:htp_customer/htp_theme.dart';

// class IDVerificationPage extends ConsumerWidget {
//   static String route = "/verifyid";
//   const IDVerificationPage({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return SafeArea(
//       child: Scaffold(
//         // appBar: const CustomAppBar(
//         //   height: 30,
//         // ),
//         appBar: VerifyAppBar(
//           // leftSpace: 30,
//           hideBackButton: true,
//           child: Text(
//             "Verify ID",
//             style: HtpTheme.newTitleTextStyle,
//           ),
//         ),
//         body: buildBody(context),
//       ),
//     );
//   }

//   Widget buildBody(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           Center(
//             child: Padding(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 12.0, vertical: 52),
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
//                     SvgPicture.asset(
//                       "assets/svg/images/verification/userid/userid_load_in.svg",
//                       width: 200,
//                       height: 125,
//                     ),
//                     const SizedBox(
//                       height: 54,
//                     ),
//                     const Text(
//                       "Verify it's you!",
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
//                       padding: const EdgeInsets.symmetric(horizontal: 32.0),
//                       child: Text(
//                         "Please keep your passport or driver's license handy and get ready to scan yourself back to reality.",
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
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 12,
//           ),
//           ButtonRow(
//             backButtonVal: '< VERIFY LATER',
//             submitButtonVal: "LET'S BEGIN",
//             onSubmit: () {
//               Navigator.pushReplacement(context,
//                   MaterialPageRoute(builder: (context) => const ScanIDFont()));
//             },
//           )
//         ],
//       ),
//     );
//   }
// }
