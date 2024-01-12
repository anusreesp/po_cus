// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:htp_customer/common/widgets_common/rounded_golden_button.dart';
// import 'package:htp_customer/features/membership/controller/membership_request_controller.dart';
// import 'package:htp_customer/features/membership/data/json_data/data.dart';
// import 'package:htp_customer/features/membership/data/model/membership_response.dart';
// import 'package:htp_customer/features/membership/presentation/request_upgrade.dart';
// import 'package:htp_customer/features/dashboard/presentation/widgets/background.dart';
// import 'package:htp_customer/htp_theme.dart';
// import 'package:intl/intl.dart';
// import '../../dashboard/presentation/widgets/custom_app_bar.dart';
//
// class RequestPlan extends StatelessWidget {
//   static const route = '/request';
//   const RequestPlan({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final data = ModalRoute.of(context)?.settings.arguments as MembershipData;
//     return SafeArea(
//       child: Scaffold(
//         appBar: const CustomAppBar(
//           height: 20,
//         ),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 12.0),
//             child: Column(
//               children: [
//                 // const SizedBox(
//                 //   height: 140,
//                 // ),
//                 Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text(
//                       "VIP Plans",
//                       style: HtpTheme.newTitleTextStyle,
//                       //  TextStyle(
//                       //     color: Colors.white,
//                       //     fontFamily: "Allrox",
//                       //     fontSize: 18,
//                       //     fontWeight: FontWeight.w600),
//                     )),
//                 // const SizedBox(
//                 //   height: 8,
//                 // ),
//                 // const HorizontalScroll(),
//                 // RequestedPlanDetails(),
//
//                 SizedBox(
//                   // height: 470,
//                   // width: 350,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       ClipRRect(
//                         // borderRadius: BorderRadius.circular(4),
//                         child: Image(
//                             width: MediaQuery.of(context).size.width,
//                             image: NetworkImage(data.image)),
//                       ),
//                       Text(
//                         // title[0],
//                         data.name,
//                         style:
//                             const TextStyle(color: Colors.white, fontSize: 22),
//                       ),
//                       const SizedBox(
//                         height: 16,
//                       ),
//
//                       //--------------------------------
//                       SizedBox(
//                         // height: 150,
//                         width: 340,
//                         child: Column(
//                           children: [
//                             ...data.benefits.map((e) => dataList(e)),
//                             // ...controllers.membershipRequestdata
//                             //     .map((e) => dataList(e.status))
//                             const SizedBox(
//                               height: 80,
//                             )
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: 25,
//                         // width: 100,
//                         child: Row(
//                           children: [
//                             Text(
//                               '\$ ${NumberFormat('#,##0.00', 'en_US').format(data.planList.first.price)}',
//                               // " \$ ${controllers.membershipRequestdata.single.paymentperyear}",
//                               style: const TextStyle(
//                                   fontSize: 17,
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.w600),
//                             ),
//                             Text(
//                               " ${data.planList.first.duration}",
//                               style:
//                                   TextStyle(fontSize: 17, color: Colors.white),
//                             )
//                           ],
//                         ),
//                       ),
//
//                       // dataList("second"),
//                     ],
//                   ),
//                 ),
//
//                 const SizedBox(
//                   height: 24,
//                 ),
//
//                 RoundedGoldenButton(
//                   onTap: () {},
//                   text: "REQUESTED FOR MEMBERSHIP",
//                   isActive: false,
//                 ),
//
//                 // Container(
//                 //   padding:
//                 //       const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
//                 //   child: Center(
//                 //     child: MaterialButton(
//                 //       child: Ink(
//                 //         width: double.maxFinite,
//                 //         height: 45,
//                 //         decoration: BoxDecoration(
//                 //           borderRadius: BorderRadius.circular(25),
//                 //           color: Color.fromARGB(255, 99, 99, 99),
//                 //           // gradient: const LinearGradient(
//                 //           //   colors: <Color>[
//                 //           //     Color.fromARGB(255, 250, 241, 160),
//                 //           //     Colors.yellow
//                 //           //   ],
//                 //           // )
//                 //         ),
//                 //         child: Container(
//                 //           alignment: Alignment.center,
//                 //           child: const Text(
//                 //             "REQUESTED FOR MEMBERSHIP",
//                 //             textAlign: TextAlign.center,
//                 //             style: TextStyle(
//                 //                 fontSize: 16,
//                 //                 color: Color.fromARGB(255, 219, 219, 219)),
//                 //           ),
//                 //         ),
//                 //       ),
//                 //       onPressed: () {
//                 //         // Navigator.pushNamed(context, RequestUpgrade.route);
//                 //       },
//                 //     ),
//                 //   ),
//                 // ),
//
//                 const SizedBox(
//                   height: 80,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// Widget dataList(String data) {
//   return Row(
//     children: [
//       const Icon(
//         size: 9,
//         Icons.circle,
//         color: Color.fromARGB(255, 187, 176, 78),
//       ),
//       Padding(
//         padding: const EdgeInsets.fromLTRB(12, 0, 0, 2),
//         child: SizedBox(
//           width: 300,
//           child: Text(
//             data,
//             style: mont14,
//           ),
//         ),
//       )
//     ],
//   );
// }
// //
// // class RequestedPlanDetails extends ConsumerWidget {
// //   RequestedPlanDetails({super.key});
// //
// //   final List feature = [
// //     'Enjoy 7% cashback points',
// //     'Free entry for 3 additional guests',
// //     'Exciting rewards up for offline redemption',
// //     'Exclusive invites for Celebrity events',
// //     'Upto 6 hours prior booking for clubs & events'
// //   ];
// //
// //   @override
// //   Widget build(BuildContext context, WidgetRef ref) {
// //     final id = ModalRoute.of(context)?.settings.arguments as MembershipData;
// //     final controllers = ref.watch(membershipRequestProvider(id));
// //
// //     return SizedBox(
// //       width: 350,
// //       height: 470,
// //       child: controllers is MembershipRequestLoaded
// //           ? Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Padding(
// //                   padding: const EdgeInsets.only(bottom: 18.0),
// //                   child: ClipRRect(
// //                     // borderRadius: BorderRadius.circular(4),
// //                     child: Image(
// //                         width: MediaQuery.of(context).size.width,
// //                         image: const AssetImage(
// //                             "assets/images/temp/membership/solitare1.png")),
// //                   ),
// //                 ),
// //                 Padding(
// //                   padding: const EdgeInsets.only(top: 18.0),
// //                   child: Text(
// //                     // title[0],
// //                     controllers.membershipRequestdata.single.membershipName,
// //                     style: const TextStyle(color: Colors.white, fontSize: 22),
// //                   ),
// //                 ),
// //                 const SizedBox(
// //                   height: 16,
// //                 ),
// //
// //                 //--------------------------------
// //                 SizedBox(
// //                   height: 150,
// //                   width: 300,
// //                   child: Column(
// //                     children: [
// //                       dataList(feature[0]),
// //                       dataList(feature[1]),
// //                       dataList(feature[2]),
// //                       dataList(feature[3]),
// //                       dataList(feature[4]),
// //                       // ...controllers.membershipRequestdata
// //                       //     .map((e) => dataList(e.status))
// //                     ],
// //                   ),
// //                 ),
// //                 SizedBox(
// //                   height: 25,
// //                   // width: 100,
// //                   child: Row(
// //                     children: const [
// //                       Text(
// //                         "\$ 1500",
// //                         // " \$ ${controllers.membershipRequestdata.single.paymentperyear}",
// //                         style: TextStyle(
// //                             fontSize: 17,
// //                             color: Colors.white,
// //                             fontWeight: FontWeight.w600),
// //                       ),
// //                       Text(
// //                         " for 365 days",
// //                         style: TextStyle(fontSize: 17, color: Colors.white),
// //                       )
// //                     ],
// //                   ),
// //                 ),
// //
// //                 // dataList("second"),
// //               ],
// //             )
// //           : controllers is MembershipRequestLoading
// //               ? const CircularProgressIndicator()
// //               : controllers is MembershipRequestErrors
// //                   ? Text(
// //                       controllers.message,
// //                       style: const TextStyle(color: Colors.red),
// //                     )
// //                   : Container(),
// //     );
// //     //   },
// //     //   // height: 510,
// //     //   // arrowTopPosition: 65,
// //     // );
// //   }
// //
// //
// // }
