// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:htp_customer/common/widgets_common/rounded_golden_button.dart';
// import 'package:htp_customer/features/idverification/presentation/widgets/greycard.dart';
// import 'package:htp_customer/features/idverification/presentation/widgets/verify_appbar.dart';
// import 'package:htp_customer/htp_theme.dart';

// class ViewID extends StatelessWidget {
//   const ViewID({super.key});

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
//             const SizedBox(
//               height: 44,
//             ),

//             //---------------------------------Grey Card------------------------
//             GreyCard(
//                 child: Column(
//               children: [
//                 const SizedBox(
//                   height: 32,
//                 ),
//                 idCards("ID Front",
//                     "assets/svg/images/verification/userid/userid.svg"),
//                 const SizedBox(
//                   height: 24,
//                 ),
//                 idCards("ID Back",
//                     "assets/svg/images/verification/userid/userid.svg"),
//                 const SizedBox(
//                   height: 24,
//                 ),
//                 //----------------------------Profile --------------------
//                 Container(
//                   width: 150,
//                   height: 150,
//                   decoration: const BoxDecoration(
//                     shape: BoxShape.circle,
//                   ),
//                   child: Center(
//                     child: SvgPicture.asset(
//                       "assets/svg/images/verification/user/user_remove_red.svg",
//                       fit: BoxFit.cover,
//                     ),
//                     // child: Image.asset(
//                     //   path,
//                     //   fit: BoxFit.cover,
//                     // ),
//                   ),
//                 ),
//               ],
//             )),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 SizedBox(
//                   width: 180,
//                   child: RoundedGoldenButton(
//                     onTap: () {
//                       //---------------------------------------- Back Home -------------------------------------------------------
//                       // Navigator.push(
//                       //     context,
//                       //     MaterialPageRoute(
//                       //         builder: (context) => VerificationFailed()));
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

//   Widget idCards(String title, String path) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: const TextStyle(
//             color: HtpTheme.greytext2color,
//             fontSize: 15,
//           ),
//         ),
//         const SizedBox(
//           height: 8,
//         ),
//         Container(
//           width: 250,
//           height: 150,
//           decoration: const BoxDecoration(
//             borderRadius: BorderRadius.all(Radius.circular(24)),
//           ),
//           child: SvgPicture.asset(
//             path,
//             fit: BoxFit.cover,
//           ),
//         )
//       ],
//     );
//   }
// }
