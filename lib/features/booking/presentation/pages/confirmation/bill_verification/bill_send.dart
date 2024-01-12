// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:htp_customer/features/booking/presentation/pages/confirmation/bill_verification/bill_scan.dart';
// import 'package:htp_customer/features/booking/presentation/pages/confirmation/bill_verification/bill_verified.dart';
// import 'package:htp_customer/features/idverification/presentation/widgets/add_doc.dart';
// import 'package:htp_customer/features/idverification/presentation/widgets/greycard.dart';
// import 'package:htp_customer/features/idverification/presentation/widgets/titleanddesc.dart';
// import 'package:htp_customer/htp_theme.dart';

// import '../../../../../../common/widgets_common/rounded_golden_button.dart';
// import '../../../../../idverification/presentation/widgets/verify_appbar.dart';

// class BillSend extends StatelessWidget {
//   const BillSend({super.key});

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
//               child: Column(
//             children: [
//               const SizedBox(
//                 height: 40,
//               ),
//               SvgPicture.asset(
//                 "assets/svg/images/verification/others/list_load_in.svg",
//                 width: 200,
//                 height: 115,
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               const TitleAndDesc(
//                 title: "Verification",
//                 desc:
//                     "We'll notify you after we verify the bill and send cashbacks based on bill and VIP pass.",
//                 horiPadding: 36,
//               ),
//               SizedBox(
//                 width: 150,
//                 child: AddDocument.addButton(() {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const ScanBill()));
//                 }, "Retake"),
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//             ],
//           )),
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
//                             builder: (context) => const BillVerified()));
//                   },
//                   text: "SEND",
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
