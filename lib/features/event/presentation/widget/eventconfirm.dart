// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:htp_customer/features/dashboard/presentation/widgets/custom_app_bar.dart';
// import 'package:htp_customer/features/profile/presentation/widgets/dropdown.dart';
// import 'package:htp_customer/features/dashboard/presentation/widgets/paynow.dart';

// import '../../../../htp_theme.dart';

// class EventConfirm extends StatelessWidget {
//   EventConfirm({super.key});

//   TextStyle lightText1 = const TextStyle(
//       height: 1.4,
//       fontFamily: "OpenSans",
//       color: Color.fromRGBO(255, 255, 255, 0.48),
//       fontSize: 12);

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: const CustomAppBar(
//           height: 20,
//         ),
//         body:
//             // Stack(
//             //   children: [
//             // const DefaultBackground(),
//             SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 4.0),
//             child: Column(
//               children: [
//                 // const SizedBox(
//                 //   height: 130,
//                 // ),

//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   child: Column(
//                     children: [
//                       Align(
//                           alignment: Alignment.centerLeft,
//                           child: Text("Get ready to rumble!",
//                               style: HtpTheme.newTitleTextStyle
//                               //  TextStyle(
//                               //     fontFamily: "Allrox",
//                               //     color: Colors.white,
//                               //     fontSize: 18,
//                               //     fontWeight: FontWeight.w500),
//                               )),
//                       const SizedBox(
//                         height: 8,
//                       ),
//                       Row(
//                         children: [
//                           SizedBox(
//                             height: 35,
//                             width: 310,
//                             child: Text(
//                               "Your booking has been confirmed. We have reserved your table on your preferred date.",
//                               // style: TextStyle(
//                               //     height: 1.5,
//                               //     fontFamily: "Open Sans",
//                               //     color: Color.fromRGBO(255, 255, 255, 0.48),
//                               //     fontSize: 13),
//                               style: lightText1,
//                             ),
//                           ),
//                           const SizedBox(
//                             width: 16,
//                           )
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),

//                 const SizedBox(
//                   height: 12,
//                 ),
//                 Stack(
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.all(16),
//                       margin: const EdgeInsets.all(12),
//                       // width: double.infinity,
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(8)),

//                       child: Column(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(top: 22.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 ClipRRect(
//                                   borderRadius: BorderRadius.circular(6),
//                                   child: const Image(
//                                     fit: BoxFit.cover,
//                                     height: 120,
//                                     width: 120,
//                                     image: AssetImage(
//                                       "assets/images/others/qr-code.png",
//                                     ),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding:
//                                       const EdgeInsets.fromLTRB(20, 0, 0, 0),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     // mainAxisAlignment: MainAxisAlignment.start,
//                                     children: [
//                                       Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Row(
//                                             children: [
//                                               const SizedBox(
//                                                 width: 22,
//                                               ),
//                                               Column(
//                                                 children: const [
//                                                   Padding(
//                                                     padding: EdgeInsets.only(
//                                                         right: 40.0),
//                                                     child: Text(
//                                                       "Booking ID",
//                                                       style: TextStyle(
//                                                           fontFamily:
//                                                               "OpenSans",
//                                                           color: Colors.grey,
//                                                           fontSize: 13),
//                                                       textAlign: TextAlign.left,
//                                                     ),
//                                                   ),
//                                                   Padding(
//                                                     padding: EdgeInsets.only(
//                                                         right: 60.0, bottom: 8),
//                                                     child: Text(
//                                                       "SL1092",
//                                                       style: TextStyle(
//                                                           color: Colors.black,
//                                                           fontSize: 13),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                           Row(
//                                             children: [
//                                               Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     bottom: 12.0),
//                                                 child: ClipRRect(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             10),
//                                                     child:
//                                                         //  const Image(
//                                                         //   fit: BoxFit.cover,
//                                                         //   height: 18,
//                                                         //   width: 18,
//                                                         //   image: AssetImage(
//                                                         //     "assets/images/icons/rounded-tick.png",
//                                                         //   ),
//                                                         // ),
//                                                         SvgPicture.asset(
//                                                             "assets/svg/icons/ticket-tickicon.svg")),
//                                               ),
//                                               const SizedBox(
//                                                 width: 6,
//                                               ),
//                                               const SizedBox(
//                                                 width: 155,
//                                                 child: Text(
//                                                   "Display the QR at the time of club entry ",
//                                                   style: TextStyle(
//                                                       fontWeight:
//                                                           FontWeight.w600,
//                                                       color: Colors.black,
//                                                       fontSize: 12),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                           const SizedBox(
//                                             height: 8,
//                                           ),
//                                           // GestureDetector(
//                                           //   child:
//                                           Padding(
//                                             padding: const EdgeInsets.only(
//                                                 left: 22.0),
//                                             child: Container(
//                                                 // width: 150,
//                                                 // height: 40,
//                                                 padding:
//                                                     const EdgeInsets.symmetric(
//                                                         horizontal: 20,
//                                                         vertical: 8),
//                                                 // padding: const EdgeInsets.only(
//                                                 //     top: 4, right: 54),
//                                                 // child: Ink(
//                                                 //     width: 90,
//                                                 //     height: 30,
//                                                 decoration: BoxDecoration(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             25),
//                                                     border: Border.all(
//                                                         color: HtpTheme
//                                                             .goldenColor,
//                                                         width: 1.5)),
//                                                 child: Container(
//                                                   alignment: Alignment.center,
//                                                   child: const Text(
//                                                     "SAVE QR",
//                                                     style: TextStyle(
//                                                         fontFamily: "Open Sans",
//                                                         fontWeight:
//                                                             FontWeight.w600,
//                                                         fontSize: 10,
//                                                         color: Colors.black),
//                                                   ),
//                                                 )),
//                                           ),
//                                           // ),
//                                           // ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),

//                           //---------------------------------------------

//                           const SizedBox(
//                             height: 24,
//                           ),
//                           // Padding(
//                           //   padding: const EdgeInsets.only(left: 18.0),
//                           // child:
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               const Text(
//                                 " Booking Details",
//                                 style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w600),
//                               ),
//                               Row(
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.only(left: 5.0),
//                                     child: Details(
//                                         "assets/svg/bottom_nav/club_f.svg",
//                                         "Club Name",
//                                         "Ice Bar",
//                                         0),
//                                   ),
//                                   const SizedBox(
//                                     width: 89,
//                                   ),
//                                   Details(
//                                       "assets/svg/bottom_nav/location_f.svg",
//                                       "Location",
//                                       "Bali",
//                                       0),
//                                 ],
//                               ),
//                               // Row(
//                               //   children: [
//                               etc("assets/svg/icons/event_calendar_icon.svg",
//                                   "Date", "12 April 2022", "Sunday 11:30 PM"),
//                               //   ],
//                               // ),
//                             ],
//                           ),

//                           // ),
//                           //-------------------------------------Preference--------------------
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                         height: 480,
//                         child: Align(
//                             alignment: Alignment.bottomCenter,
//                             child: PayNow())),
//                   ],
//                 ),
//                 //-----------------------------------------------Pricing----------------
//                 const SizedBox(
//                   height: 16,
//                 ),
//                 const DropDown(),
//                 const SizedBox(
//                   height: 4,
//                 ),
//                 GestureDetector(
//                   onTap: (() {}),
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 12, horizontal: 16),
//                     child: Ink(
//                         width: MediaQuery.of(context).size.width,
//                         height: 45,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(25),
//                             border: Border.all(color: HtpTheme.goldenColor)),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             // Image(
//                             //     width: 18,
//                             //     height: 18,
//                             // image: AssetImage(
//                             //     "assets/images/icons/calendar-check.png")),
//                             SvgPicture.asset(
//                                 'assets/svg/icons/event_calendar_icon.svg'),
//                             const SizedBox(
//                               width: 25,
//                             ),
//                             Container(
//                               alignment: Alignment.center,
//                               child: const Text(
//                                 "Add Event to Calendar",
//                                 style: TextStyle(
//                                     fontFamily: "Open Sans",
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.w600,
//                                     color: Colors.white),
//                               ),
//                             ),
//                             const SizedBox(
//                               width: 32,
//                             ),
//                           ],
//                         )),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 44,
//                 )
//                 //-----------------------------Map -----------------
//                 // const Padding(
//                 //   padding: EdgeInsets.only(bottom: 16),
//                 //   child:
//                 //       Image(image: AssetImage('assets/images/temp/map.png')),
//                 // ),
//               ],
//             ),
//           ),
//         ),
//         bottomNavigationBar: Container(
//           margin: const EdgeInsets.only(bottom: 4, right: 20),
//           width: 100,
//           child:
//               //  Row(children: [Spacer(), faq()])
//               Row(mainAxisAlignment: MainAxisAlignment.end, children: [faq()]),
//         ),
//         //   ],
//         // ),
//         // bottomSheet: Container(
//         //   height: 40,
//         //   width: 40,
//         //   margin: const EdgeInsets.only(bottom: 20),
//         //   color: Colors.red,
//         // ),
//         // floatingActionButton: FloatingActionButton(
//         //   onPressed: () {},
//         //   child: Padding(
//         //     padding: const EdgeInsets.only(bottom: 40),
//         //     child: Icon(Icons.abc),
//         //   ),
//         // ),
//       ),
//     );
//   }

//   Widget saveqr() {
//     return Container(
//       padding: const EdgeInsets.only(top: 12, right: 54),
//       child: Ink(
//           width: 90,
//           height: 30,
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(25),
//               border:
//                   Border.all(color: const Color.fromARGB(255, 175, 164, 68))),
//           child: Container(
//             alignment: Alignment.center,
//             child: const Text(
//               "SAVE QR",
//               style: TextStyle(fontSize: 12, color: Colors.black),
//             ),
//           )),
//     );
//   }

//   Widget faq() {
//     return Container(
//       decoration: BoxDecoration(
//           color: Colors.black,
//           borderRadius: BorderRadius.circular(25),
//           border: Border.all(color: Colors.black)),
//       width: 90,
//       height: 32,
//       child: Row(
//         children: const [
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 8.0),
//             child: Image(
//               fit: BoxFit.cover,
//               width: 23,
//               height: 23,
//               image: AssetImage("assets/images/icons/help-circle.png"),
//             ),
//           ),
//           Text(
//             "FAQ'S",
//             style: TextStyle(color: Colors.white, fontSize: 15),
//           )
//         ],
//       ),
//     );
//   }

//   Widget Details(
//     String imageName,
//     String hint,
//     String name,
//     int? notSvg,
//   ) {
//     return SizedBox(
//       width: 110,
//       height: 80,
//       child: Center(
//         child: Row(
//           children: [
//             SizedBox(
//               height: 20,
//               width: 20,
//               child: notSvg == 0
//                   ? SvgPicture.asset(imageName)
//                   : Image(
//                       fit: BoxFit.contain,
//                       image: AssetImage(
//                         "assets/images/icons/$imageName",
//                       ),
//                     ),
//             ),
//             Container(
//               padding: const EdgeInsets.only(top: 12, left: 10),
//               width: 75,
//               height: 50,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     hint,
//                     style:
//                         // clubdetailhint,
//                         const TextStyle(
//                             fontFamily: "OpenSans",
//                             color: Colors.grey,
//                             // color: Color.fromRGBO(255, 255, 255, 0.51),
//                             fontSize: 10),
//                   ),
//                   Text(
//                     name,
//                     style: clubDetailData,
//                     // const TextStyle(
//                     //     fontFamily: "Open Sans",
//                     //     color: Colors.black,
//                     //     // fontWeight: FontWeight.w400,
//                     //     fontSize: 14),
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   TextStyle clubdetailhint = const TextStyle(
//       fontFamily: "OpenSans",
//       color: Color.fromRGBO(255, 255, 255, 0.92),
//       fontSize: 10);

//   TextStyle clubDetailData = const TextStyle(
//       fontFamily: "Open Sans",
//       color: Color.fromRGBO(0, 0, 0, .96),
//       fontSize: 14);

//   Widget etc(
//     String imageName,
//     String hint,
//     String name,
//     String day,
//   ) {
//     return Container(
//       padding: const EdgeInsets.only(left: 8),
//       width: 230,
//       height: 110,
//       child: Center(
//         child: Row(
//           children: [
//             Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(
//                   height: 20,
//                   width: 20,
//                   child:
//                       //  Image(
//                       //   fit: BoxFit.contain,
//                       //   image: AssetImage(
//                       //     "assets/images/icons/$imageName",
//                       //   ),
//                       // ),
//                       SvgPicture.asset(imageName),
//                 ),
//                 const SizedBox(
//                   height: 60,
//                 ),
//               ],
//             ),
//             Container(
//               padding: const EdgeInsets.only(top: 12, left: 12),
//               width: 190,
//               height: 130,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     hint,
//                     style:
//                         // clubdetailhint
//                         const TextStyle(
//                             fontFamily: "OpenSans",
//                             color: Colors.grey,
//                             fontWeight: FontWeight.w400,
//                             fontSize: 12),
//                   ),
//                   Text(name, style: clubDetailData
//                       // const TextStyle(
//                       //     color: Colors.black,
//                       //     fontWeight: FontWeight.w400,
//                       //     fontSize: 14),
//                       ),
//                   Text(day, style: clubDetailData
//                       // const TextStyle(
//                       //     color: Colors.black,
//                       //     fontWeight: FontWeight.w400,
//                       //     fontSize: 13),
//                       ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget dataList(String data) {
//     return Row(
//       children: [
//         // imageName == null ?
//         const Icon(
//           size: 12,
//           Icons.circle,
//           color: Color.fromARGB(255, 187, 176, 78),
//         ),
//         // : Image(width: 18, height: 18, image: AssetImage(imageName)),
//         Padding(
//           padding: const EdgeInsets.fromLTRB(16, 0, 0, 2),
//           child: SizedBox(
//             width: 280,
//             child: Text(
//               data,
//               style: const TextStyle(
//                   fontSize: 13,
//                   color: Colors.white,
//                   fontWeight: FontWeight.w400),
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }
