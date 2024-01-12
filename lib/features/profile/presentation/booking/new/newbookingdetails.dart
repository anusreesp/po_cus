// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:htp_customer/features/dashboard/presentation/widgets/custom_app_bar.dart';
// import 'package:htp_customer/features/profile/presentation/booking/new/cancelbookingdialog.dart';
// import 'package:htp_customer/features/profile/presentation/widgets/dropdown.dart';
// import 'package:htp_customer/htp_theme.dart';

// class NewBookDetails extends StatelessWidget {
//   static const route = '/newdetails';
//   NewBookDetails({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: const CustomAppBar(
//           height: 70,
//         ),
//         body: SingleChildScrollView(
//           child: Container(
//             // decoration: const BoxDecoration(
//             //     image: DecorationImage(
//             //         alignment: Alignment.center,
//             //         fit: BoxFit.fitWidth,
//             //         image: AssetImage(
//             //           "assets/images/icons/mask_group.png",
//             //         ))),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 // Padding(
//                 //   padding: const EdgeInsets.symmetric(horizontal: 24.0),
//                 // child:
//                 Column(
//                   children: [
//                     // const SizedBox(
//                     //   height: 130,
//                     // ),
//                     Align(
//                         alignment: Alignment.centerLeft,
//                         child: Padding(
//                           padding: const EdgeInsets.only(left: 20.0),
//                           child: Text("Get Ready to Rumble!",
//                               style: HtpTheme.newTitleTextStyle),
//                         )),
//                     const SizedBox(
//                       height: 8,
//                     ),
//                     const Padding(
//                       padding: EdgeInsets.only(left: 20.0, right: 16),
//                       child: Text(
//                         "Your booking has been confirmed. We have reserved your table on your preffered date",
//                         style: TextStyle(color: Colors.grey, fontSize: 12),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 32,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 20.0, right: 16),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           ClipRRect(
//                             borderRadius: BorderRadius.circular(6),
//                             child: const Image(
//                               fit: BoxFit.cover,
//                               height: 120,
//                               width: 120,
//                               image: AssetImage(
//                                 "assets/images/others/qr-code.png",
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               // mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Column(
//                                   children: [
//                                     const Padding(
//                                       padding:
//                                           const EdgeInsets.only(right: 92.0),
//                                       child: Text(
//                                         "Booking ID",
//                                         style: TextStyle(
//                                             color: Colors.grey, fontSize: 13),
//                                         textAlign: TextAlign.left,
//                                       ),
//                                     ),
//                                     const Padding(
//                                       padding: EdgeInsets.only(
//                                           right: 110.0, bottom: 8),
//                                       child: Text(
//                                         "SL1092",
//                                         style: TextStyle(
//                                             color: Colors.white, fontSize: 13),
//                                       ),
//                                     ),
//                                     Row(
//                                       children: [
//                                         Padding(
//                                           padding: const EdgeInsets.only(
//                                               bottom: 10.0, left: 22),
//                                           child: ClipRRect(
//                                               borderRadius:
//                                                   BorderRadius.circular(10),
//                                               child:
//                                                   // const Image(
//                                                   //   fit: BoxFit.cover,
//                                                   //   height: 16,
//                                                   //   width: 16,
//                                                   //   image: AssetImage(
//                                                   //     "assets/images/icons/rounded-tick.png",
//                                                   //   ),
//                                                   // ),
//                                                   SvgPicture.asset(
//                                                       "assets/svg/icons/ticket-tickicon.svg")),
//                                         ),
//                                         const SizedBox(
//                                           width: 8,
//                                         ),
//                                         Container(
//                                           width: 155,
//                                           child: const Text(
//                                             "Display the QR at the time of club entry ",
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.w600,
//                                                 color: Colors.white,
//                                                 fontSize: 12),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     Container(
//                                       padding: const EdgeInsets.only(
//                                           top: 12, right: 65),
//                                       child: Ink(
//                                           width: 85,
//                                           height: 30,
//                                           decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(25),
//                                               border: Border.all(
//                                                   color: Colors.white)),
//                                           child: Container(
//                                             alignment: Alignment.center,
//                                             child: const Text(
//                                               "SAVE QR",
//                                               style: TextStyle(
//                                                   fontSize: 12,
//                                                   color: Colors.white),
//                                             ),
//                                           )),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 32,
//                     ),
//                     Container(
//                       height: 8,
//                       width: double.infinity,
//                       color: const Color.fromRGBO(255, 255, 255, 0.11),
//                     ),
//                     const SizedBox(
//                       height: 22,
//                     ),
//                     Container(alignment: Alignment.center, child: faq()),

//                     const SizedBox(
//                       height: 24,
//                     ),
//                     // Padding(
//                     //   padding: const EdgeInsets.only(left: 18.0),
//                     // child:
//                     Padding(
//                       padding: const EdgeInsets.only(left: 20.0, right: 16),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           const Text(
//                             "Booking Details",
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w600),
//                           ),
//                           Row(
//                             children: [
//                               details("assets/svg/bottom_nav/club_f.svg",
//                                   "Club Name", "Ice Bar"),
//                               const SizedBox(
//                                 width: 120,
//                               ),
//                               details("assets/svg/bottom_nav/location_f.svg",
//                                   "Location", "Bali")
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               etc(
//                                   "assets/svg/icons/event_calendar_icon.svg",
//                                   "Date",
//                                   "12 April 2022",
//                                   "Sunday 11:30 PM",
//                                   context),
//                               Column(
//                                 children: [
//                                   details("assets/svg/icons/group-people.svg",
//                                       "Total Guest", "3"),
//                                   const SizedBox(
//                                     height: 54,
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     const Divider(
//                       color: Color.fromARGB(255, 107, 107, 107),
//                     ),

//                     // ),
//                     //-------------------------------------Preference--------------------
//                     preferencesandCalendar(context),

//                     //-----------------------------Map -----------------
//                   ],
//                 ),
//                 // ),
//                 const Padding(
//                   padding: EdgeInsets.only(bottom: 16),
//                   child: Image(image: AssetImage('assets/images/temp/map.png')),
//                 ),
//               ],
//             ),
//           ),
//         ));
//   }

//   preferencesandCalendar(BuildContext context) {
//     return Stack(
//       children: [
//         // Image(
//         //   image: AssetImage(
//         //     "assets/images/icons/mask_group.png",
//         //   ),
//         // ),
//         // DefaultBackground(),
//         Container(
//           // decoration: const BoxDecoration(
//           //     image: DecorationImage(
//           //         alignment: Alignment.center,
//           //         fit: BoxFit.fitWidth,
//           //         image: AssetImage(
//           //           "assets/images/icons/mask_group.png",
//           //         ))),
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(left: 20.0, right: 16),
//                 child: Row(
//                   children: [
//                     // Image(
//                     //     width: 18,
//                     //     height: 18,
//                     //     image:
//                     //         AssetImage("assets/images/icons/Group-6204.png")),
//                     SvgPicture.asset("assets/svg/icons/bottle_icon.svg"),
//                     const Padding(
//                       padding: EdgeInsets.fromLTRB(12, 4, 0, 2),
//                       child: SizedBox(
//                         width: 280,
//                         child: Text(
//                           "Party Preferences",
//                           style: TextStyle(
//                               fontSize: 15,
//                               color: Colors.white,
//                               fontWeight: FontWeight.w600),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 height: 12,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 20.0, right: 16),
//                 child: Column(
//                   children: [
//                     dataList("Drinks - Brand and type name here"),
//                     dataList("Smoke - Yes")
//                   ],
//                 ),
//               ),
//               const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 17, vertical: 8),
//                 child: Text(
//                     style: TextStyle(
//                         fontSize: 13,
//                         color: Color.fromARGB(255, 180, 180, 180),
//                         fontWeight: FontWeight.w400),
//                     'Other info/notices or details for the part goes here "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostr "'),
//               ),
//               const Divider(
//                 color: Color.fromARGB(255, 107, 107, 107),
//               ),
//               const SizedBox(
//                 height: 12,
//               ),
//               const DropDown(),
//               const SizedBox(
//                 height: 4,
//               ),
//               Padding(
//                 padding:
//                     const EdgeInsets.only(left: 20.0, right: 16, bottom: 8),
//                 child: GestureDetector(
//                   onTap: (() {}),
//                   child: Container(
//                     padding:
//                         const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
//                     child: Ink(
//                         width: MediaQuery.of(context).size.width,
//                         height: 45,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(25),
//                             border: Border.all(
//                               color: HtpTheme.goldenColor,
//                             )),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             SvgPicture.asset(
//                                 'assets/svg/icons/event_calendar_icon.svg'),
//                             // const Image(
//                             //     width: 18,
//                             //     height: 18,
//                             //     image: AssetImage(
//                             //         "assets/images/icons/calendar-check.png")),
//                             const SizedBox(width: 12),
//                             Container(
//                               alignment: Alignment.center,
//                               child: const Text(
//                                 "Add Event to Calendar",
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 15,
//                                     color: Colors.white),
//                               ),
//                             ),
//                           ],
//                         )),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget faq() {
//     return Container(
//       decoration: BoxDecoration(
//           color: Colors.black,
//           borderRadius: BorderRadius.circular(25),
//           border: Border.all(color: Colors.black)),
//       width: 85,
//       height: 32,
//       child: Row(
//         children: const [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 7.0),
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

//   Widget details(
//     String imageName,
//     String hint,
//     String name,
//   ) {
//     return Container(
//       width: 110,
//       height: 80,
//       child: Center(
//         child: Row(
//           children: [
//             Column(
//               children: [
//                 const SizedBox(
//                   height: 26,
//                 ),
//                 Container(
//                     height: 20, width: 20, child: SvgPicture.asset(imageName)),
//               ],
//             ),
//             Container(
//               padding: const EdgeInsets.only(top: 12, left: 8),
//               width: 75,
//               height: 50,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     hint,
//                     style: const TextStyle(
//                         color: Colors.grey,
//                         fontWeight: FontWeight.w400,
//                         fontSize: 11),
//                   ),
//                   Text(
//                     name,
//                     style: const TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w400,
//                         fontSize: 16),
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   TextStyle detailData = const TextStyle(
//       fontFamily: "Open Sans",
//       color: Color.fromRGBO(255, 255, 255, 0.957),
//       fontSize: 14);

//   Widget etc(String imageName, String hint, String name, String day,
//       BuildContext context) {
//     return Container(
//       // padding: EdgeInsets.only(left: 4),
//       width: 230,
//       height: 120,
//       child: Center(
//         child: Row(
//           children: [
//             Column(
//               children: [
//                 const SizedBox(
//                   height: 13,
//                 ),
//                 Container(
//                     height: 20, width: 20, child: SvgPicture.asset(imageName)
//                     //  Image(
//                     //   fit: BoxFit.contain,
//                     //   image: AssetImage(
//                     //     "assets/images/icons/$imageName",
//                     //   ),
//                     // ),
//                     ),
//               ],
//             ),
//             Container(
//               padding: EdgeInsets.only(top: 12, left: 12),
//               width: 190,
//               height: 130,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 4.0),
//                     child: Text(
//                       hint,
//                       style: const TextStyle(
//                           fontFamily: "OpenSans",
//                           color: Colors.grey,
//                           fontWeight: FontWeight.w400,
//                           fontSize: 12),
//                     ),
//                   ),
//                   Text(
//                     name,
//                     style: detailData,
//                     //  const TextStyle(
//                     //     color: Colors.white,
//                     //     fontWeight: FontWeight.w400,
//                     //     fontSize: 14),
//                   ),
//                   const SizedBox(
//                     height: 4,
//                   ),
//                   Text(
//                     day,
//                     style: detailData,
//                     //  const TextStyle(
//                     //     color: Colors.white,
//                     //     fontWeight: FontWeight.w400,
//                     //     fontSize: 13),
//                   ),
//                   GestureDetector(
//                     onTap: (() {
//                       showDialog(
//                           context: context,
//                           builder: (context) {
//                             return CancelDialog.cancelBookingDialog(context);
//                           });
//                     }),
//                     child: Container(
//                       padding: const EdgeInsets.only(top: 12),
//                       child: Ink(
//                           width: 115,
//                           height: 30,
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(25),
//                               border: Border.all(color: Colors.white)),
//                           child: Container(
//                             alignment: Alignment.center,
//                             child: const Text(
//                               "CANCEL BOOKING",
//                               style: TextStyle(
//                                 fontSize: 10,
//                                 fontFamily: "OpenSans",
//                                 color: Color.fromARGB(255, 207, 207, 207),
//                               ),
//                             ),
//                           )),
//                     ),
//                   ),
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
//           size: 9,
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
