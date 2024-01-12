// import 'package:flutter/material.dart';
// import 'package:htp_customer/features/membership/data/model/membership_response.dart';
// import 'package:htp_customer/features/membership/presentation/widgets/alertdialog.dart';
// import 'package:htp_customer/common/widgets_common/rounded_golden_button.dart';
//
// import '../../../../htp_theme.dart';
//
// class BottomButton extends StatefulWidget {
//   const BottomButton({super.key});
//
//   @override
//   State<BottomButton> createState() => _BottomButtonState();
// }
//
// class _BottomButtonState extends State<BottomButton> {
//   bool expired = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: expired == true ? 155 : 105,
//       width: MediaQuery.of(context).size.width,
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       decoration: const BoxDecoration(
//           // color: Color.fromARGB(255, 29, 29, 29),\
//           // color: HtpTheme.cardBlackColor,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black,
//               offset: Offset(
//                 5.0,
//                 5.0,
//               ),
//               blurRadius: 17.0,
//               spreadRadius: 8.0,
//             ),
//           ]),
//       child: Column(
//         children: [
//           expired == true
//               ? Padding(
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: const [
//                       Text(
//                         "Your Plan Expired ",
//                         style: TextStyle(
//                             fontSize: 18,
//                             color: Colors.white,
//                             fontWeight: FontWeight.w600),
//                       ),
//                       Text(
//                         "Renew you plan to keep Enjoying VIP Benefits",
//                         style: TextStyle(
//                             height: 1.4,
//                             fontSize: 18,
//                             fontFamily: "Open Sans",
//                             color: Color.fromRGBO(255, 255, 255, .65)),
//                       ),
//                     ],
//                   ),
//                 )
//               : Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 12.0),
//                   child: Row(
//                     // mainAxisAlignment: MainAxisAlignment.center,
//                     children: const [
//                       SizedBox(
//                         width: 12,
//                       ),
//                       Text(
//                         "Membership Expires in ",
//                         style: TextStyle(
//                             fontSize: 17,
//                             fontFamily: "Open Sans",
//                             color: Colors.white),
//                       ),
//                       Text(
//                         "192 Days ",
//                         style: TextStyle(
//                             fontSize: 17,
//                             fontFamily: "Open Sans",
//                             color: Colors.white,
//                             fontWeight: FontWeight.w700),
//                       ),
//                     ],
//                   ),
//                 ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
//             child: RoundedGoldenButton(
//               onTap: () async {
//                 if (expired == true) {
//                   await showDialog(
//                       context: context,
//                       builder: (context) {
//                         return MembershipConfirmation(
//                             data: MembershipData(
//                                 id: 'id',
//                                 level: 2,
//                                 name: 'name',
//                                 image: 'image',
//                                 flatImage: '',
//                                 planList: [],
//                                 membershipCalculations: MembershipCalculations(
//                                     tableBookingUpToHours: 0),
//                                 tagline1: '',
//                                 tagline2: '',
//                                 // pricePerYear: 22,
//                                 benefits: []));
//                       });
//                 } else {
//                   await showDialog(
//                       context: context,
//                       builder: (context) {
//                         return MembershipDialogBox.cheersDialog(
//                             context, context);
//                       });
//                 }
//                 setState(() {
//                   expired = !expired;
//                 });
//
//                 // Navigator.pushNamed(context, RequestPlan.route);
//               },
//               text: expired == false ? "REQUEST UPGRADE" : "REQUEST RENEW",
//               textStyle: TextStyle(
//                   // color: HtpTheme.light().scaffoldBackgroundColor,
//                   fontSize: 15,
//                   fontFamily: "OpenSans",
//                   fontWeight: FontWeight.bold),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
