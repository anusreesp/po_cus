// import 'package:flutter/material.dart';
// import 'package:htp_customer/features/membership/presentation/widgets/alertdialog.dart';
// import 'package:htp_customer/common/widgets_common/rounded_golden_button.dart';
//
// import '../../../../htp_theme.dart';
//
// class AmethystDetails extends StatefulWidget {
//   const AmethystDetails({super.key});
//
//   @override
//   State<AmethystDetails> createState() => _AmethystDetailsState();
// }
//
// class _AmethystDetailsState extends State<AmethystDetails> {
//   bool isattached = false;
//   bool radiobutton1 = false;
//   bool radiobutton2 = false;
//
//   radioButtonText() {
//     return Container();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
//       elevation: 16,
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 10),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//           color: Colors.black,
//           // border: Border.all(color: Colors.yellow, width: 0.6)
//         ),
//         height: 420.0,
//         width: MediaQuery.of(context).size.width,
//
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Align(
//               alignment: Alignment.topRight,
//               child: IconButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   icon: const Icon(
//                     Icons.close,
//                     color: Colors.grey,
//                   )),
//             ),
//             const Padding(
//               padding: EdgeInsets.only(top: 4.0),
//               child: Text(
//                 "Fill the details",
//                 style: TextStyle(color: Colors.white, fontSize: 16),
//               ),
//             ),
//             const SizedBox(
//               height: 8,
//             ),
//             const Text(
//               "Are you a cabin crew ?",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 13,
//                 // fontWeight: FontWeight.w600
//               ),
//             ),
//             SizedBox(
//               height: 40,
//               child: Row(
//                 children: [
//                   radiobutton1 == false
//                       ? IconButton(
//                           onPressed: () {
//                             setState(() {
//                               radiobutton1 = true;
//                             });
//                           },
//                           icon: const Image(
//                             fit: BoxFit.cover,
//                             height: 22,
//                             width: 22,
//                             image: AssetImage(
//                               "assets/images/icons/radio-off.png",
//                             ),
//                           ))
//                       : IconButton(
//                           onPressed: () {
//                             setState(() {
//                               radiobutton1 = false;
//                             });
//                           },
//                           icon: const Image(
//                             fit: BoxFit.cover,
//                             height: 22,
//                             width: 22,
//                             image: AssetImage(
//                               "assets/images/icons/radio-on.png",
//                             ),
//                           )),
//                   const Text("Yes",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 13,
//                       )),
//                   const SizedBox(
//                     width: 16,
//                   ),
//                   radiobutton1 == true
//                       ? IconButton(
//                           onPressed: () {
//                             setState(() {
//                               radiobutton1 = false;
//                             });
//                           },
//                           icon: const Image(
//                             fit: BoxFit.cover,
//                             height: 22,
//                             width: 22,
//                             image: AssetImage(
//                               "assets/images/icons/radio-off.png",
//                             ),
//                           ))
//                       : IconButton(
//                           onPressed: () {
//                             setState(() {
//                               radiobutton1 = true;
//                             });
//                           },
//                           icon: const Image(
//                             fit: BoxFit.cover,
//                             height: 22,
//                             width: 22,
//                             image: AssetImage(
//                               "assets/images/icons/radio-on.png",
//                             ),
//                           )),
//                   const Text("No",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 13,
//                       )),
//                   const SizedBox(
//                     width: 16,
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 8,
//             ),
//
//             const Text(
//               "Please attach cabin crew ID",
//               style: TextStyle(color: Colors.white, fontSize: 13),
//             ),
//             const SizedBox(
//               height: 8,
//             ),
//             SizedBox(
//               height: 50,
//               child: Row(
//                 children: [
//                   isattached == false
//                       ? GestureDetector(
//                           child: Row(
//                             children: const [
//                               Icon(
//                                 Icons.attach_file,
//                                 color: Color.fromARGB(255, 224, 172, 32),
//                               ),
//                               Text(
//                                 "Attach here",
//                                 style: TextStyle(
//                                   color: Color.fromARGB(255, 224, 172, 32),
//                                 ),
//                               )
//                             ],
//                           ),
//                           onTap: () {
//                             setState(() {
//                               isattached = true;
//                             });
//                           },
//                         )
//                       : Row(
//                           children: const [
//                             Icon(
//                               Icons.attach_file,
//                               color: Colors.white,
//                             ),
//                             Text(
//                               "CabinCrewID.pdf",
//                               style: TextStyle(
//                                 color: Colors.white,
//                               ),
//                             )
//                           ],
//                         ),
//                   const Spacer(),
//                   isattached == true
//                       ? MaterialButton(
//                           onPressed: (() {}),
//                           child: const Text(
//                             "Remove",
//                             style: TextStyle(
//                                 color: Color.fromARGB(255, 224, 172, 32)),
//                           ),
//                         )
//                       : Container()
//                 ],
//               ),
//             ),
//
//             const SizedBox(
//               height: 20,
//             ),
//             const Text(
//               "Please confirm your Membership plan, our team will get in touch with you to process your Membership",
//               style: TextStyle(
//                   color: Color.fromARGB(255, 192, 192, 192), fontSize: 15),
//             ),
//             const SizedBox(
//               height: 16,
//             ),
//
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 MaterialButton(
//                   minWidth: 80,
//                   height: 35,
//                   onPressed: () {
//                     // Navigator.push(
//                     //     context,
//                     //     MaterialPageRoute(
//                     //         builder: (context) => MembershipsPage()));
//
//                     Navigator.pop(context);
//                   },
//                   shape: RoundedRectangleBorder(
//                       side: const BorderSide(
//                           color: Color.fromRGBO(231, 213, 53, 0.44),
//                           width: 0.2),
//                       borderRadius: BorderRadius.circular(25)),
//                   child: const Text(
//                     "CANCEL",
//                     style: TextStyle(color: Colors.white, fontSize: 12),
//                   ),
//                 ),
//                 isattached == false
//                     ? SizedBox(
//                         height: 40,
//                         child: RoundedGoldenButton(
//                           onTap: () {
//                             Navigator.of(context).pop();
//                             showDialog(
//                                 context: context,
//                                 builder: (context) {
//                                   return MembershipDialogBox.cheersDialog(
//                                       context, context);
//                                 });
//                           },
//                           text: "SUBMIT REQUEST",
//                           textStyle: const TextStyle(
//                             fontWeight: FontWeight.w600,
//                             fontSize: 14,
//                           ),
//                         ),
//                       )
//                     : MaterialButton(
//                         onPressed: () {
//                           // Navigator.pushNamed(context, RequestPlan.route);
//                           Navigator.of(context).pop();
//                           showDialog(
//                               context: context,
//                               builder: (context) {
//                                 return MembershipDialogBox.cheersDialog(
//                                     context, context);
//                               });
//                         },
//                         child: Ink(
//                           // width: double.maxFinite,
//                           width: 140,
//                           height: 35,
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(25),
//                               gradient: const LinearGradient(
//                                 colors: <Color>[
//                                   Color.fromARGB(255, 250, 241, 160),
//                                   Colors.yellow
//                                 ],
//                               )),
//                           child: Container(
//                             alignment: Alignment.center,
//                             child: Text(
//                               "PROCEED",
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                   // color:
//                                   //     HtpTheme.light().scaffoldBackgroundColor,
//                                   fontSize: 12),
//                             ),
//                           ),
//                         ),
//                       ),
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
