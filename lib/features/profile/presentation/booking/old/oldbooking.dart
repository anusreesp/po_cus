// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:htp_customer/features/profile/presentation/booking/new/newbooking.dart';
// import 'package:htp_customer/features/profile/presentation/booking/old/oldbookdetail.dart';
// import 'package:htp_customer/htp_theme.dart';
// import '../../../../../../../authentication/theme.dart';
// import '../../../../dashboard/presentation/widgets/custom_app_bar.dart';

// class OldBooking extends StatelessWidget {
//   static const route = '/Oldbooking';
//   OldBooking({super.key});

//   var colorTheme = AuthTheme.colorTheme();
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//           appBar: const CustomAppBar(
//             height: 20,
//           ),
//           body: Container(
//             height: MediaQuery.of(context).size.height,
//             decoration: const BoxDecoration(
//                 image: DecorationImage(
//                     alignment: Alignment.bottomLeft,
//                     image: AssetImage(
//                       "assets/images/mask_group.png",
//                     ))),
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                 child: Column(
//                   children: [
//                     const SizedBox(
//                       // height: 140,
//                       width: double.infinity,
//                       child: Align(
//                         alignment: Alignment.bottomCenter,
//                         // child: Padding(
//                         //   padding:
//                         //       EdgeInsets.symmetric(horizontal: 0.0, vertical: 18),
//                         //   child: SearchBox(),
//                         // ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 12,
//                     ),
//                     Row(
//                       children: [
//                         Text(
//                           "My old booking",
//                           style: HtpTheme.newTitleTextStyle,
//                           //    TextStyle(
//                           //       fontFamily: "Allrox",
//                           //       fontWeight: FontWeight.bold,
//                           //       fontSize: 16,
//                           //       color: Colors.white),
//                         ),
//                         const Spacer(),
//                         MaterialButton(
//                           child: Ink(
//                             width: 110,
//                             height: 30,
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(25),
//                                 gradient: const LinearGradient(
//                                   colors: <Color>[
//                                     Color.fromARGB(255, 228, 218, 135),
//                                     Color.fromARGB(255, 219, 166, 17)
//                                   ],
//                                 )),
//                             child: Container(
//                               alignment: Alignment.center,
//                               child: Text(
//                                 "NEW BOOKINGS",
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                     fontFamily: "OpenSans",
//                                     fontWeight: FontWeight.w700,
//                                     fontSize: 10,
//                                     color: colorTheme.backgroundColor),
//                               ),
//                             ),
//                           ),
//                           onPressed: () {
//                             Navigator.pushNamed(context, NewBooking.route);
//                           },
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 28,
//                     ),
//                     OldBookings(
//                         imageName: "party-crowd.jpg",
//                         eventTitle: "Ice-bar",
//                         date: "01 Mar 2023",
//                         onTap: () {
//                           Navigator.pushNamed(context, OldBookingDetails.route);
//                         },
//                         place: "Singapore"),
//                     Divider(
//                       color: Colors.grey,
//                     ),
//                     OldBookings(
//                         imageName: "party-nopath.jpg",
//                         eventTitle: "Sanctum club",
//                         date: "18 Mar 2023",
//                         onTap: () {
//                           Navigator.pushNamed(context, OldBookingDetails.route);
//                         },
//                         place: "Miami")
//                   ],
//                 ),
//               ),
//             ),
//           )),
//     );
//   }
// }

// class OldBookings extends StatelessWidget {
//   final String imageName;
//   final String eventTitle;
//   final String date;
//   final String place;
//   final Function onTap;

//   const OldBookings(
//       {super.key,
//       required this.imageName,
//       required this.eventTitle,
//       required this.date,
//       required this.place,
//       required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: (() => onTap()),
//       child: Container(
//         padding: const EdgeInsets.only(left: 12),
//         height: 130,
//         child: Row(
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(12),
//               child: Image(
//                 fit: BoxFit.cover,
//                 height: 110,
//                 width: 120,
//                 image: AssetImage(
//                   "assets/images/temp/$imageName",
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 22,
//             ),
//             Padding(
//               padding: const EdgeInsets.fromLTRB(20, 28, 0, 0),
//               child: Center(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       eventTitle,
//                       style: const TextStyle(
//                           color: Color(0xffe8d48a), fontSize: 15),
//                     ),
//                     const SizedBox(
//                       height: 12,
//                     ),
//                     Text(
//                       date,
//                       style: const TextStyle(color: Colors.white, fontSize: 13),
//                     ),
//                     SizedBox(
//                       height: 4,
//                     ),
//                     Row(
//                       children: [
//                         // const Icon(
//                         //   Icons.location_on_sharp,
//                         //   size: 17,
//                         //   color: HtpTheme.goldenColor,
//                         // ),
//                         SvgPicture.asset(
//                             'assets/svg/bottom_nav/location_f.svg'),
//                         const SizedBox(
//                           width: 4,
//                         ),
//                         Text(
//                           place,
//                           style: const TextStyle(
//                               color: Colors.white, fontSize: 14),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
