// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:htp_customer/features/profile/presentation/booking/new/newpartlink.dart';
// import 'package:htp_customer/features/profile/presentation/widgets/dropdown.dart';
// import 'package:htp_customer/features/profile/presentation/widgets/ratingdialog.dart';
// import 'package:htp_customer/htp_theme.dart';

// import '../../../../../../../authentication/theme.dart';
// import '../../../../../../../authentication/presentation/widgets/background.dart';
// import '../../../../dashboard/presentation/widgets/custom_app_bar.dart';

// class NewPartDetails extends StatelessWidget {
//   static const route = '/newpartdetails';
//   NewPartDetails({super.key});

//   var colorTheme = AuthTheme.colorTheme();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const CustomAppBar(
//         height: 70,
//       ),
//       body: Stack(
//         children: [
//           // const DefaultBackground(),
//           SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Column(
//                 children: [
//                   // const SizedBox(
//                   //   height: 30,
//                   // ),
//                   // const Align(
//                   //     alignment: Alignment.centerLeft,
//                   //     child: Text(
//                   //       "Get Ready to rumble",
//                   //       style: TextStyle(
//                   //           color: Colors.white,
//                   //           fontSize: 19,
//                   //           fontWeight: FontWeight.w600),
//                   //     )),
//                   Row(
//                     children: [
//                       Text(
//                         "Ice bar",
//                         // style: Theme.of(context).textTheme.headline2,
//                         style: HtpTheme.newTitleTextStyle,
//                       ),
//                       const Spacer(),
//                       MaterialButton(
//                         child: Ink(
//                           width: 115,
//                           height: 30,
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(25),
//                               border: Border.all(color: HtpTheme.goldenColor)),
//                           child: Container(
//                             alignment: Alignment.center,
//                             child: Text(
//                               "HOW'S THE PARTY?",
//                               textAlign: TextAlign.center,
//                               style:
//                                   TextStyle(color: Colors.white, fontSize: 11),
//                             ),
//                           ),
//                         ),
//                         onPressed: () {
//                           showDialog(
//                               context: context,
//                               builder: (context) {
//                                 return RatingDialog();
//                               });
//                           // Navigator.pushNamed(context, OldBooking.route);
//                         },
//                       ),
//                     ],
//                   ),
//                   // SizedBox(
//                   //   height: 8,
//                   // ),
//                   // Text(
//                   //   "Your booking has been confirmed.We have reserved your table on your preffered date",
//                   //   style: TextStyle(color: Colors.grey, fontSize: 12),
//                   // ),
//                   SizedBox(
//                     height: 18,
//                   ),
//                   event("club0.jpg", "Ice Bar", "01 Mar 2023", "Singapore"),
//                   const Divider(
//                     color: Color.fromARGB(255, 107, 107, 107),
//                   ),

//                   NewBookingLink(),
//                   const Divider(
//                     color: Color.fromARGB(255, 107, 107, 107),
//                   ),
//                   /*
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(6),
//                         child: Image(
//                           fit: BoxFit.cover,
//                           height: 120,
//                           width: 120,
//                           image: AssetImage(
//                             "assets/images/others/qr-code.png",
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           // mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Column(
//                               children: [
//                                 const Padding(
//                                   padding: const EdgeInsets.only(right: 92.0),
//                                   child: Text(
//                                     "Booking ID",
//                                     style: TextStyle(
//                                         color: Colors.grey, fontSize: 13),
//                                     textAlign: TextAlign.left,
//                                   ),
//                                 ),
//                                 const Padding(
//                                   padding: const EdgeInsets.only(
//                                       right: 110.0, bottom: 8),
//                                   child: Text(
//                                     "SL1092",
//                                     style: TextStyle(
//                                         color: Colors.white, fontSize: 13),
//                                   ),
//                                 ),
//                                 Row(
//                                   children: [
//                                     ClipRRect(
//                                       borderRadius: BorderRadius.circular(10),
//                                       child: const Image(
//                                         fit: BoxFit.cover,
//                                         height: 14,
//                                         width: 14,
//                                         image: AssetImage(
//                                           "assets/images/icons/rounded-tick.png",
//                                         ),
//                                       ),
//                                     ),
//                                     const SizedBox(
//                                       width: 8,
//                                     ),
//                                     Container(
//                                       width: 180,
//                                       child: const Text(
//                                         "Display the QR at the time of club entry ",
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.w400,
//                                             color: Colors.white,
//                                             fontSize: 14),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Container(
//                                   padding: EdgeInsets.only(top: 12, right: 54),
//                                   child: Ink(
//                                       width: 90,
//                                       height: 30,
//                                       decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(25),
//                                           border:
//                                               Border.all(color: Colors.white)),
//                                       child: Container(
//                                         alignment: Alignment.center,
//                                         child: const Text(
//                                           "SAVE QR",
//                                           style: TextStyle(
//                                               fontSize: 12,
//                                               color: Colors.white),
//                                         ),
//                                       )),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   */

//                   SizedBox(
//                     height: 24,
//                   ),
//                   Row(
//                     children: [
//                       SvgPicture.asset("assets/svg/icons/bottle_icon.svg"),
//                       // Image(
//                       //     width: 18,
//                       //     height: 18,
//                       //     image:
//                       //         AssetImage("assets/images/icons/Group-6204.png")),
//                       const Padding(
//                         padding: const EdgeInsets.fromLTRB(12, 4, 0, 2),
//                         child: SizedBox(
//                           width: 280,
//                           child: Text(
//                             "Party Preferences",
//                             style: const TextStyle(
//                                 fontSize: 15,
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w600),
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 12,
//                   ),
//                   Column(
//                     children: [
//                       dataList("Drinks - Brand and type name here"),
//                       dataList("Smoke - Yes")
//                     ],
//                   ),
//                   const Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text(
//                         style: TextStyle(
//                             fontSize: 13,
//                             color: Color.fromARGB(255, 180, 180, 180),
//                             fontWeight: FontWeight.w400),
//                         'Others info/notices or details for the part goes here "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eliusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim venim, quis nostr "'),
//                   ),
//                   const Divider(
//                     color: Color.fromARGB(255, 107, 107, 107),
//                   ),
//                   const SizedBox(
//                     height: 12,
//                   ),
//                   // Padding(
//                   //   padding: const EdgeInsets.only(left: 18.0),
//                   // child:
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       const Text(
//                         "Booking Details",
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 14,
//                             fontWeight: FontWeight.w600),
//                       ),
//                       Row(
//                         children: [
//                           Details("assets/svg/bottom_nav/club_f.svg",
//                               "Club Name", "Ice Bar", 0),
//                           const SizedBox(
//                             width: 105,
//                           ),
//                           Details("assets/svg/bottom_nav/location_f.svg",
//                               "Location", "Bali", 0)
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           etc("assets/svg/icons/event_calendar_icon.svg",
//                               "Date", "12 April 2022", "Sunday 11:30 PM"),
//                           Details("user_icon.png", "Total Guest", "3", 1),
//                         ],
//                       ),
//                     ],
//                   ),
//                   const Divider(
//                     color: Color.fromARGB(255, 107, 107, 107),
//                   ),

//                   const DropDown(),
//                   const SizedBox(
//                     height: 4,
//                   ),

//                   //-----------------------------Map -----------------
//                   const Padding(
//                     padding: EdgeInsets.only(bottom: 16),
//                     child:
//                         Image(image: AssetImage('assets/images/temp/map.png')),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget Details(
//     String imageName,
//     String hint,
//     String name,
//     final int? notSvg,
//   ) {
//     return Container(
//       width: 110,
//       height: 80,
//       child: Center(
//         child: Row(
//           children: [
//             Container(
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
//               padding: EdgeInsets.only(top: 12, left: 8),
//               width: 75,
//               height: 50,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     hint,
//                     style: const TextStyle(
//                         color: Colors.grey,
//                         fontWeight: FontWeight.w300,
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

//   Widget etc(
//     String imageName,
//     String hint,
//     String name,
//     String day,
//   ) {
//     return Container(
//       padding: EdgeInsets.only(left: 8),
//       width: 230,
//       height: 120,
//       child: Center(
//         child: Row(
//           children: [
//             Container(
//               height: 20,
//               width: 20,
//               child: SvgPicture.asset(imageName),
//               // child: Image(
//               //   fit: BoxFit.contain,
//               // image: AssetImage(
//               //   "assets/images/icons/$imageName",
//               // ),
//               // ),
//             ),
//             Container(
//               padding: EdgeInsets.only(top: 12, left: 12),
//               width: 190,
//               height: 130,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     height: 24,
//                   ),
//                   Text(
//                     hint,
//                     style: const TextStyle(
//                         color: Color.fromARGB(255, 211, 211, 211),
//                         fontWeight: FontWeight.w400,
//                         fontSize: 12),
//                   ),
//                   Text(
//                     name,
//                     style: const TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w400,
//                         fontSize: 14),
//                   ),
//                   Text(
//                     day,
//                     style: const TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w400,
//                         fontSize: 13),
//                   ),
//                   // GestureDetector(
//                   //   onTap: (() {}),
//                   //   child: Container(
//                   //     padding: const EdgeInsets.only(top: 12),
//                   //     child: Ink(
//                   //         width: 105,
//                   //         height: 25,
//                   //         decoration: BoxDecoration(
//                   //             borderRadius: BorderRadius.circular(25),
//                   //             border: Border.all(color: Colors.white)),
//                   //         child: Container(
//                   //           alignment: Alignment.center,
//                   //           child: const Text(
//                   //             "CANCEL BOOKING",
//                   //             style:
//                   //                 TextStyle(fontSize: 10, color: Colors.white),
//                   //           ),
//                   //         )),
//                   //   ),
//                   // ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget event(String imageName, String eventTitle, String date, String place) {
//     return Container(
//       padding: const EdgeInsets.only(left: 4),
//       height: 130,
//       child: Row(
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(8),
//             child: Image(
//               fit: BoxFit.cover,
//               height: 110,
//               width: 140,
//               image: AssetImage(
//                 "assets/images/temp/$imageName",
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 22,
//           ),
//           Padding(
//             padding: const EdgeInsets.fromLTRB(20, 28, 0, 0),
//             child: Center(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Text(
//                         eventTitle,
//                         style: const TextStyle(
//                             color: Color(0xffe8d48a), fontSize: 15),
//                       ),
//                       // Spacer(),
//                       // EventDate(eventDate),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 12,
//                   ),
//                   Row(
//                     children: [
//                       // const Icon(
//                       //   Icons.location_on_sharp,
//                       //   size: 17,
//                       //   color: HtpTheme.goldenColor,
//                       // ),
//                       SvgPicture.asset('assets/svg/bottom_nav/location_f.svg'),
//                       const SizedBox(
//                         width: 4,
//                       ),
//                       Text(
//                         " $place | 4.2Km ",
//                         style:
//                             const TextStyle(color: Colors.white, fontSize: 13),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 4,
//                   ),
//                   Text(
//                     date,
//                     style: const TextStyle(
//                         color: Color.fromARGB(255, 196, 196, 196),
//                         fontSize: 12),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
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
