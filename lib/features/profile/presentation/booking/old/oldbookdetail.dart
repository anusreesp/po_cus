// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import '../../../../../../../authentication/theme.dart';
// import '../../../../../../../authentication/presentation/widgets/background.dart';
// import '../../../../../../../htp_theme.dart';
// import '../../../../dashboard/presentation/widgets/custom_app_bar.dart';
// import '../../widgets/ratingdialog.dart';
// import '../new/newpartlink.dart';

// class OldBookingDetails extends StatelessWidget {
//   static const route = '/oldbookingdetails';
//   OldBookingDetails({super.key});

//   var colorTheme = AuthTheme.colorTheme();

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: const CustomAppBar(
//           height: 30,
//         ),
//         body: Stack(
//           children: [
//             const DefaultBackground(),
//             SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                 child: Column(
//                   children: [
//                     Row(
//                       children: [
//                         Text(
//                           "Ice bar",
//                           // style: Theme.of(context).textTheme.headline2,
//                           style: HtpTheme.newTitleTextStyle,
//                         ),
//                         const Spacer(),
//                         MaterialButton(
//                           child: Ink(
//                             width: 115,
//                             height: 30,
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(25),
//                                 border:
//                                     Border.all(color: HtpTheme.goldenColor)),
//                             child: Container(
//                               alignment: Alignment.center,
//                               child: Text(
//                                 "HOW'S THE PARTY?",
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                     color: Colors.white, fontSize: 11),
//                               ),
//                             ),
//                           ),
//                           onPressed: () {
//                             showDialog(
//                                 context: context,
//                                 builder: (context) {
//                                   return RatingDialog();
//                                 });
//                             // Navigator.pushNamed(context, OldBooking.route);
//                           },
//                         ),
//                       ],
//                     ),
//                     // SizedBox(
//                     //   height: 8,
//                     // ),
//                     // Text(
//                     //   "Your booking has been confirmed.We have reserved your table on your preffered date",
//                     //   style: TextStyle(color: Colors.grey, fontSize: 12),
//                     // ),
//                     SizedBox(
//                       height: 8,
//                     ),
//                     event("club0.jpg", "Ice Bar", "01 Mar 2022", "Singapore"),
//                     const Divider(
//                       color: Color.fromARGB(255, 107, 107, 107),
//                     ),

//                     NewBookingLink(),
//                     const Divider(
//                       color: Color.fromARGB(255, 107, 107, 107),
//                     ),

//                     SizedBox(
//                       height: 24,
//                     ),
//                     Row(
//                       children: [
//                         // Image(
//                         //     width: 18,
//                         //     height: 18,
//                         //     image:
//                         //         AssetImage("assets/images/icons/Group-6204.png")),
//                         SvgPicture.asset("assets/svg/icons/bottle_icon.svg"),
//                         const Padding(
//                           padding: const EdgeInsets.fromLTRB(12, 4, 0, 2),
//                           child: SizedBox(
//                             width: 280,
//                             child: Text(
//                               "Party Preferences",
//                               style: const TextStyle(
//                                   fontFamily: "OpenSans",
//                                   fontSize: 14,
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.w600),
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 12,
//                     ),
//                     Column(
//                       children: [
//                         dataList("Drinks - Brand and type name here"),
//                         dataList("Smoke - Yes")
//                       ],
//                     ),
//                     const Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Text(
//                           style: TextStyle(
//                               fontSize: 13,
//                               color: Color.fromARGB(255, 180, 180, 180),
//                               fontWeight: FontWeight.w400),
//                           'Other info/notices or details for the part goes here "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostr"'),
//                     ),

//                     const SizedBox(
//                       height: 12,
//                     ),

//                     //-----------------------------Map -----------------
//                     const Padding(
//                       padding: EdgeInsets.only(bottom: 16),
//                       child: Image(
//                           image: AssetImage('assets/images/temp/map.png')),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget Details(
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
//             Container(
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
//               child: Image(
//                 fit: BoxFit.contain,
//                 image: AssetImage(
//                   "assets/images/icons/$imageName",
//                 ),
//               ),
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
//               height: 100,
//               width: 120,
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
//                       Padding(
//                         padding: const EdgeInsets.only(left: 4.0),
//                         child: Text(
//                           eventTitle,
//                           style: const TextStyle(
//                               color: Color(0xffe8d48a), fontSize: 15),
//                         ),
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
//                   Padding(
//                     padding: const EdgeInsets.only(left: 6.0),
//                     child: Text(
//                       date,
//                       style: const TextStyle(
//                           color: Color.fromARGB(255, 196, 196, 196),
//                           fontSize: 12),
//                     ),
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
