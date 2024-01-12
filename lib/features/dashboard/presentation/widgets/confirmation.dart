// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:htp_customer/features/dashboard/presentation/widgets/custom_app_bar.dart';
// import 'package:htp_customer/features/profile/presentation/widgets/dropdown.dart';
// import 'package:htp_customer/htp_theme.dart';
//
// class Confirmation extends StatelessWidget {
//   static const route = '/confirmation';
//   const Confirmation({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const CustomAppBar(),
//       body:
//           // Stack(
//           //   children: [
//           // const DefaultBackground(),
//           SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 12.0),
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(left: 16.0, right: 30),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Get Ready to Rumble!",
//                       style: Theme.of(context)
//                           .textTheme
//                           .headline4
//                           ?.apply(color: Colors.white),
//                     ),
//                     const SizedBox(
//                       height: 8,
//                     ),
//                     const Text(
//                       "Your booking has been confirmed. We have reserved your table on your preferred date.",
//                       style: TextStyle(color: Colors.white54, fontSize: 12),
//                     ),
//                   ],
//                 ),
//               ),
//
//               //Information details box
//               Container(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 16, vertical: 28),
//                 margin: const EdgeInsets.symmetric(vertical: 18),
//                 // width: double.infinity,
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12)),
//
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(6),
//                           child: const Image(
//                             fit: BoxFit.cover,
//                             height: 120,
//                             width: 120,
//                             image: AssetImage(
//                               "assets/images/others/qr-code.png",
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             // mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   const Text(
//                                     "Booking ID",
//                                     style: TextStyle(
//                                         color: Colors.grey, fontSize: 13),
//                                     textAlign: TextAlign.left,
//                                   ),
//                                   const Text(
//                                     "SL1092",
//                                     style: TextStyle(
//                                         color: Colors.black, fontSize: 13),
//                                   ),
//                                   const SizedBox(
//                                     height: 12,
//                                   ),
//                                   Row(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Padding(
//                                         padding:
//                                             const EdgeInsets.only(top: 4.0),
//                                         child: ClipRRect(
//                                             borderRadius:
//                                                 BorderRadius.circular(10),
//                                             child:
//                                                 // const Image(
//                                                 //   fit: BoxFit.cover,
//                                                 //   height: 16,
//                                                 //   width: 16,
//                                                 //   image: AssetImage(
//                                                 //     "assets/images/icons/rounded-tick.png",
//                                                 //   ),
//                                                 // ),
//                                                 SvgPicture.asset(
//                                                     "assets/svg/icons/ticket-tickicon.svg")),
//                                       ),
//                                       const SizedBox(
//                                         width: 6,
//                                       ),
//                                       const SizedBox(
//                                         width: 160,
//                                         child: Text(
//                                           "Display the QR at the time of club entry ",
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.w600,
//                                               color: Colors.black,
//                                               fontSize: 12),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//
//                                   const SizedBox(
//                                     height: 6,
//                                   ),
//
//                                   Container(
//                                     decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(22),
//                                         border: Border.all(
//                                             color: HtpTheme.goldenColor,
//                                             width: 1.5)),
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 20, vertical: 8),
//                                     child: const Text(
//                                       "SAVE QR",
//                                       style: TextStyle(
//                                           fontSize: 10,
//                                           fontWeight: FontWeight.w600,
//                                           color: Colors.black),
//                                     ),
//                                   )
//
//                                   // Container(
//                                   //   padding:
//                                   //       EdgeInsets.only(top: 12, right: 54),
//                                   //   child: Ink(
//                                   //       width: 90,
//                                   //       height: 30,
//                                   //       decoration: BoxDecoration(
//                                   //           borderRadius:
//                                   //               BorderRadius.circular(25),
//                                   //           border: Border.all(
//                                   //               color: Color.fromARGB(
//                                   //                   255, 175, 164, 68))),
//                                   //       child: Container(
//                                   //         child: const Text(
//                                   //           "SAVE QR",
//                                   //           style: TextStyle(
//                                   //               fontSize: 12,
//                                   //               color: Colors.black),
//                                   //         ),
//                                   //       )),
//                                   // ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//
//                     //---------------------------------------------
//
//                     const SizedBox(
//                       height: 24,
//                     ),
//                     // Padding(
//                     //   padding: const EdgeInsets.only(left: 18.0),
//                     // child:
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         const Text(
//                           "Booking Details",
//                           style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 14,
//                               fontWeight: FontWeight.w600),
//                         ),
//                         const SizedBox(
//                           height: 12,
//                         ),
//
//                         Row(
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: const [
//                                 BookingDetailsItem(
//                                   image: "assets/svg/bottom_nav/club_f.svg",
//                                   title: 'Club Name',
//                                   subTitle: 'Ice Bar',
//                                   notSvg: 0,
//                                 ),
//                                 SizedBox(
//                                   height: 16,
//                                 ),
//                                 BookingDetailsItem(
//                                   image:
//                                       "assets/svg/icons/event_calendar_icon.svg",
//                                   title: 'Date',
//                                   subTitle: '12 April 2022\nSunday 11:30 PM',
//                                   notSvg: 0,
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(
//                               width: 20,
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: const [
//                                 BookingDetailsItem(
//                                   image: "assets/svg/bottom_nav/location_f.svg",
//                                   title: 'Location',
//                                   subTitle: 'Bali',
//                                   notSvg: 0,
//                                 ),
//                                 SizedBox(
//                                   height: 16,
//                                 ),
//                                 BookingDetailsItem(
//                                   image: 'user_icon.png',
//                                   title: 'Total Guest',
//                                   subTitle: '3',
//                                   notSvg: 1,
//                                 ),
//                               ],
//                             ),
//                           ],
//                         )
//
//                         // Container(
//                         //   child: Row(
//                         //     children: [
//                         //       Details("club_f.png", "Club Name", "Ice Bar"),
//                         //       const SizedBox(
//                         //         width: 89,
//                         //       ),
//                         //       Details("location_f.png", "Location", "Bali")
//                         //     ],
//                         //   ),
//                         // ),
//                         //
//                         // Row(
//                         //   children: [
//                         //     etc("calendar-check.png", "Date", "12 April 2022",
//                         //         "Sunday 11:30 PM"),
//                         //   ],
//                         // ),
//                       ],
//                     ),
//
//                     // ),
//                     //-------------------------------------Preference--------------------
//                   ],
//                 ),
//               ),
//               //-----------------------------------------------Pricing----------------
//               const DropDown(),
//               const SizedBox(
//                 height: 4,
//               ),
//               GestureDetector(
//                 onTap: (() {}),
//                 child: Container(
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
//                   child: Ink(
//                       width: MediaQuery.of(context).size.width,
//                       height: 45,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(25),
//                           border: Border.all(color: HtpTheme.goldenColor)),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           // Image(
//                           //     width: 18,
//                           //     height: 18,
//                           //     image: AssetImage(
//                           //         "assets/images/icons/calendar-check.png")),
//                           SvgPicture.asset(
//                               'assets/svg/icons/event_calendar_icon.svg'),
//                           const SizedBox(
//                             width: 20,
//                           ),
//                           Container(
//                             alignment: Alignment.center,
//                             child: const Text(
//                               "Add Event to Calendar",
//                               style:
//                                   TextStyle(fontSize: 15, color: Colors.white),
//                             ),
//                           ),
//                         ],
//                       )),
//                 ),
//               ),
//               const SizedBox(
//                 height: 44,
//               )
//               //-----------------------------Map -----------------
//               // const Padding(
//               //   padding: EdgeInsets.only(bottom: 16),
//               //   child:
//               //       Image(image: AssetImage('assets/images/temp/map.png')),
//               // ),
//             ],
//           ),
//         ),
//       ),
//       //   ],
//       // ),
//     );
//   }
//
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
//
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
//
//   Widget Details(String imageName, String hint, String name, int? notSvg) {
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
//                         color: Colors.black,
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
//
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
//             SizedBox(
//               height: 20,
//               width: 20,
//               child: Image(
//                 fit: BoxFit.contain,
//                 image: AssetImage(
//                   "assets/images/icons/$imageName",
//                 ),
//               ),
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
//                     style: const TextStyle(
//                         color: Colors.grey,
//                         fontWeight: FontWeight.w400,
//                         fontSize: 12),
//                   ),
//                   Text(
//                     name,
//                     style: const TextStyle(
//                         color: Colors.black,
//                         fontWeight: FontWeight.w400,
//                         fontSize: 14),
//                   ),
//                   Text(
//                     day,
//                     style: const TextStyle(
//                         color: Colors.black,
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
//                   //             border: Border.all(color: Colors.black)),
//                   //         child: Container(
//                   //           alignment: Alignment.center,
//                   //           child: const Text(
//                   //             "CANCEL BOOKING",
//                   //             style:
//                   //                 TextStyle(fontSize: 10, color: Colors.black),
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
//
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
//
// class BookingDetailsItem extends StatelessWidget {
//   final String image;
//   final String title;
//   final String subTitle;
//   final int? notSvg;
//   const BookingDetailsItem(
//       {Key? key,
//       required this.image,
//       required this.title,
//       required this.subTitle,
//       this.notSvg})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         notSvg != 0
//             ? Image(
//                 fit: BoxFit.contain,
//                 height: 20,
//                 width: 20,
//                 image: AssetImage(
//                   "assets/images/icons/$image",
//                 ),
//               )
//             : SvgPicture.asset(
//                 image,
//                 height: 16,
//               ),
//         const SizedBox(
//           width: 12,
//         ),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               title,
//               style: const TextStyle(fontSize: 10, color: Colors.black54),
//             ),
//             Text(
//               subTitle,
//               style: const TextStyle(fontSize: 14),
//             )
//           ],
//         )
//       ],
//     );
//   }
// }
