// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:htp_customer/features/membership/controller/membership_application_controller.dart';
// import 'package:htp_customer/features/membership/data/model/membership_response.dart';
// import 'package:htp_customer/common/widgets_common/rounded_golden_button.dart';
// import 'package:htp_customer/features/membership/presentation/membership_docs_upload.dart';
// import 'package:htp_customer/htp_theme.dart';
//
// class MembershipConfirmation extends StatelessWidget {
//   final MembershipData data;
//   const MembershipConfirmation({super.key, required this.data});
//
//   final description =
//       "Please confirm your Membership plan, our team will get in touch with you to process your Membership";
//   final amethystDescription =
//       'Please confirm, if you are a member of an airline cabin crew. Our team will get in touch with you to process your membership.';
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//       elevation: 16,
//       child: Container(
//         padding: const EdgeInsets.fromLTRB(16, 12, 16, 18),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//           // color: HtpTheme.light().scaffoldBackgroundColor,
//           // color: Colors.black,
//           // border:
//           //     Border.all(color: Colors.yellow.withOpacity(0.4), width: 0.7)
//         ),
//         // height: 420.0,
//         width: MediaQuery.of(context).size.width,
//         // child: Padding(
//         //   padding: const EdgeInsets.all(45.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             // SizedBox(
//             //   // width: 450,
//             //   // height: 180,
//             //   child: Center(
//             //     child: ClipRRect(
//             //       borderRadius: BorderRadius.circular(6),
//             //       child: Image(image: NetworkImage(data.image)),
//             //     ),
//             //   ),
//             // ),
//             const SizedBox(
//               height: 12,
//             ),
//
//             Text(
//               "VIP Plan",
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 14,
//                 // fontFamily: "Open Sans",
//               ),
//             ),
//             const SizedBox(
//               height: 4,
//             ),
//
//             Row(
//               children: [
//                 Text(
//                   data.name,
//                   style: const TextStyle(
//                       // fontFamily: "Open Sans",
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500),
//                 ),
//                 if (data.name.toLowerCase() == 'amethyst')
//                   const Expanded(
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 4),
//                       child: FittedBox(
//                           child: Text(
//                         ' Exclusively for Cabin Crew',
//                         style: TextStyle(
//                             fontSize: 14, color: HtpTheme.goldenColor),
//                       )),
//                     ),
//                   )
//               ],
//             ),
//
//             const SizedBox(
//               height: 22,
//             ),
//             Text(
//               data.name.toLowerCase() == 'amethyst'
//                   ? amethystDescription
//                   : description,
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 14,
//                 // fontFamily: "Open Sans",
//               ),
//             ),
//             const SizedBox(
//               height: 22,
//             ),
//
//             //----------------------------------------------------
//             // Padding(
//             //   padding: const EdgeInsets.fromLTRB(12, 12, 0, 0),
//             //   child:
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 MaterialButton(
//                   minWidth: 95,
//                   height: 40,
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   shape: RoundedRectangleBorder(
//                       side: BorderSide(
//                         color: const Color.fromARGB(255, 232, 212, 138)
//                             .withOpacity(0.6),
//                       ),
//                       borderRadius: BorderRadius.circular(25)),
//                   child: const Text(
//                     "CANCEL",
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold
//                         // fontFamily: "Open Sans",
//                         ),
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 8,
//                 ),
//                 SizedBox(
//                   width: 140,
//                   height: 40,
//                   child: Consumer(
//                     builder: (context, ref, _) {
//                       final controller =
//                           ref.watch(membershipApplicationProvider);
//
//                       ref.listen(membershipApplicationProvider,
//                           (previous, next) {
//                         if (next is MAErrorState) {
//                           if (context.mounted) {
//                             Navigator.of(context).pop();
//                           }
//                         }
//                       });
//
//                       if (controller is MALoadingState) {
//                         return const Center(child: CircularProgressIndicator());
//                       } else {
//                         return RoundedGoldenButton(
//                           onTap: () {
//                             //Checks for amethyst plan and navigate to doc upload
//
//                             if (context.mounted) {
//                               Navigator.pop(context);
//                             }
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => MembershipDocsUpload(
//                                           data: data,
//                                         )));
//
//                             // if(data.id == '91e5aae1-6edd-4394-a648-5908084db3e7'){
//                             //   if(context.mounted){
//                             //     Navigator.pop(context);
//                             //   }
//                             //   Navigator.push(context, MaterialPageRoute(builder: (context) => MembershipDocsUpload(data: data,)));
//                             // }else{
//                             //   ref
//                             //       .read(membershipApplicationProvider.notifier)
//                             //       .submitMembershipRequest(data);
//                             // }
//                           },
//                           height: 40,
//                           // textStyle: const TextStyle(
//                           //     fontSize: 14,
//                           //     color: Colors.black87,
//                           //     fontWeight: FontWeight.w600),
//                           text: data.name.toLowerCase() == 'amethyst'
//                               ? 'Verify ID'
//                               : 'REQUEST',
//                         );
//                       }
//                     },
//                   ),
//                 )
//               ],
//             ),
//             // )
//           ],
//         ),
//         // ),
//       ),
//     );
//   }
// }
//
// class MembershipDialogBox {
//   static cheersDialog(BuildContext cxt, BuildContext context) {
//     return Dialog(
//       alignment: Alignment.center,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
//       elevation: 16,
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 10),
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             // color: HtpTheme.light().scaffoldBackgroundColor,
//             color: Colors.black,
//             // border: Border.all(color: Colors.yellow, width: 0.6)
//             border:
//                 Border.all(color: Colors.yellow.withOpacity(0.4), width: 0.7)),
//         height: 200,
//         child: Column(
//           children: [
//             Align(
//               alignment: Alignment.topRight,
//               child: IconButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                     // Navigator.pushNamed(context, RequestPlan.route);
//                   },
//                   icon: const Icon(
//                     Icons.close,
//                     color: Colors.grey,
//                   )),
//             ),
//             const Text(
//               "Cheers!",
//               style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 26,
//                   fontWeight: FontWeight.w800),
//             ),
//             const SizedBox(
//               height: 18,
//             ),
//             const Text(
//               "We have received the request",
//               style: TextStyle(
//                   color: Color.fromARGB(255, 192, 192, 192),
//                   fontSize: 18,
//                   fontWeight: FontWeight.w400),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // static amethystDialog(BuildContext context) {
//   //   return Dialog(
//   //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
//   //     elevation: 16,
//   //     child: Container(
//   //       padding: EdgeInsets.symmetric(horizontal: 10),
//   //       decoration: BoxDecoration(
//   //         borderRadius: BorderRadius.circular(20),
//   //         color: Colors.black,
//   //         // border: Border.all(color: Colors.yellow, width: 0.6)
//   //       ),
//   //       height: 480.0,
//   //       width: MediaQuery.of(context).size.width,
//   //
//   //       child: Column(
//   //         mainAxisAlignment: MainAxisAlignment.start,
//   //         crossAxisAlignment: CrossAxisAlignment.start,
//   //         children: <Widget>[
//   //           Align(
//   //             alignment: Alignment.topRight,
//   //             child: IconButton(
//   //                 onPressed: () {
//   //                   Navigator.of(context).pop();
//   //                 },
//   //                 icon: const Icon(
//   //                   Icons.close,
//   //                   color: Colors.grey,
//   //                 )),
//   //           ),
//   //           Padding(
//   //             padding: const EdgeInsets.only(top: 4.0),
//   //             child: Container(
//   //               width: 450,
//   //               child: ClipRRect(
//   //                 borderRadius: BorderRadius.circular(6),
//   //                 child: const Image(
//   //                     width: 450,
//   //                     image:
//   //                         AssetImage("assets/images/temp/membership/5a.png")),
//   //               ),
//   //             ),
//   //           ),
//   //           const SizedBox(
//   //             height: 8,
//   //           ),
//   //           const Text(
//   //             "Membership Type",
//   //             style: TextStyle(
//   //                 color: Colors.white,
//   //                 fontSize: 16,
//   //                 fontWeight: FontWeight.w600),
//   //           ),
//   //           const SizedBox(
//   //             height: 4,
//   //           ),
//   //
//   //           const Text(
//   //             "Amethyst Membership",
//   //             style: TextStyle(color: Colors.white, fontSize: 13),
//   //           ),
//   //           const SizedBox(
//   //             height: 20,
//   //           ),
//   //           const Text(
//   //             "Please make sure you are a cabin crew as the membership is exclusively for Cabin Crew",
//   //             style: TextStyle(
//   //                 color: Color.fromARGB(255, 192, 192, 192), fontSize: 15),
//   //           ),
//   //           const SizedBox(
//   //             height: 16,
//   //           ),
//   //
//   //           Row(
//   //             mainAxisAlignment: MainAxisAlignment.end,
//   //             children: [
//   //               MaterialButton(
//   //                 minWidth: 80,
//   //                 height: 35,
//   //                 onPressed: () {
//   //                   // Navigator.push(
//   //                   //     context,
//   //                   //     MaterialPageRoute(
//   //                   //         builder: (context) => MembershipsPage()));
//   //
//   //                   Navigator.pop(context);
//   //                 },
//   //                 shape: RoundedRectangleBorder(
//   //                     side: const BorderSide(color: Colors.yellow),
//   //                     borderRadius: BorderRadius.circular(25)),
//   //                 child: const Text(
//   //                   "CANCEL",
//   //                   style: TextStyle(color: Colors.white, fontSize: 12),
//   //                 ),
//   //               ),
//   //               MaterialButton(
//   //                 onPressed: () {
//   //                   // Navigator.pushNamed(context, RequestPlan.route);
//   //                   Navigator.of(context).pop();
//   //                   showDialog(
//   //                       context: context,
//   //                       builder: (context) {
//   //                         // return cheersDialog(context, context);
//   //                         return AmethystDetails();
//   //                       });
//   //                 },
//   //                 child: Ink(
//   //                   // width: double.maxFinite,
//   //                   width: 140,
//   //                   height: 35,
//   //                   decoration: BoxDecoration(
//   //                       borderRadius: BorderRadius.circular(25),
//   //                       gradient: const LinearGradient(
//   //                         colors: <Color>[
//   //                           Color.fromARGB(255, 250, 241, 160),
//   //                           Colors.yellow
//   //                         ],
//   //                       )),
//   //                   child: Container(
//   //                     alignment: Alignment.center,
//   //                     child: Text(
//   //                       "PROCEED",
//   //                       textAlign: TextAlign.center,
//   //                       style: TextStyle(
//   //                           color: HtpTheme.light().scaffoldBackgroundColor,
//   //                           fontSize: 12),
//   //                     ),
//   //                   ),
//   //                 ),
//   //               ),
//   //             ],
//   //           ),
//   //           // )
//   //         ],
//   //       ),
//   //       // ),
//   //     ),
//   //   );
//   // }
// }
