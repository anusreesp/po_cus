// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:htp_customer/common/widgets_common/rounded_golden_button.dart';
// import 'package:htp_customer/features/idverification/presentation/widgets/greycard.dart';
// import 'package:htp_customer/features/idverification/presentation/widgets/titleanddesc.dart';
// import 'package:htp_customer/features/idverification/presentation/widgets/verify_appbar.dart';
// import 'package:htp_customer/htp_theme.dart';

// class BillVerificationFailed extends StatelessWidget {
//   BillVerificationFailed({super.key});

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
//             GreyCard(
//                 child: Column(
//               children: [
//                 const SizedBox(
//                   height: 50,
//                 ),
//                 SvgPicture.asset(
//                   "assets/svg/images/verification/others/list_remove.svg",
//                   width: 210,
//                   height: 120,
//                 ),
//                 const SizedBox(
//                   height: 54,
//                 ),
//                 const TitleAndDesc(
//                     title: "Verification failed",
//                     desc:
//                         "Your bill verification failed due to one more below reasons"),
//                 const SizedBox(
//                   height: 12,
//                 ),
//               ],
//             )),
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
//     "Photo of the bill is not clear or blurry.",
//     "The bill doesn't match with the club booking.",
//     "Invalid bill due to late submission or duplicate bill."
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
