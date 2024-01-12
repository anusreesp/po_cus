// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:htp_customer/common/widgets_common/rounded_golden_button.dart';
// import 'package:htp_customer/features/booking/presentation/pages/confirmation/bill_verification/bill_verification_failed.dart';
// import 'package:htp_customer/features/idverification/presentation/widgets/greycard.dart';
// import 'package:htp_customer/features/idverification/presentation/widgets/verify_appbar.dart';
// import 'package:htp_customer/htp_theme.dart';

// import '../../../../../idverification/presentation/widgets/titleanddesc.dart';

// class BillVerified extends StatelessWidget {
//   const BillVerified({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: VerifyAppBar(
//             hideBackButton: true,
//             // leftSpace: 12,
//             child: Text(
//               "Bill verification",
//               style: HtpTheme.newTitleTextStyle,
//             )),
//         body: buildBody(context),
//       ),
//     );
//   }

//   Widget buildBody(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const SizedBox(
//             height: 40,
//           ),
//           GreyCard(
//             child: Column(
//               children: [
//                 const SizedBox(
//                   height: 60,
//                 ),
//                 SvgPicture.asset(
//                   "assets/svg/images/verification/others/list_added.svg",
//                   width: 200,
//                   height: 115,
//                 ),
//                 const SizedBox(
//                   height: 60,
//                 ),
//                 const TitleAndDesc(
//                   title: "Verified!",
//                   desc:
//                       "Your bill has been successfully verified. You will now get PO coins based on the bill!",
//                   horiPadding: 45,
//                 ),
//                 const SizedBox(height: 24),
//               ],
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               SizedBox(
//                 width: 180,
//                 child: RoundedGoldenButton(
//                   onTap: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => BillVerificationFailed()));
//                   },
//                   text: "VIEW CASHBACKS",
//                   height: 45,
//                 ),
//               ),
//               const SizedBox(
//                 width: 20,
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
