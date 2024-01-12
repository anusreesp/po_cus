// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class NewBookingLink extends StatelessWidget {
//   const NewBookingLink({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 350,
//       // height: 150,
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Where's The Party?",
//               style: TextStyle(
//                   fontFamily: "OpenSans", color: Colors.white, fontSize: 14),
//             ),
//             SizedBox(
//               height: 8,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(right: 18.0, bottom: 22),
//               child: const Text(
//                   "Le Meridien Mina Seyahi Beach Resorts & Marina, Singapore",
//                   style: TextStyle(
//                       fontFamily: "OpenSans",
//                       color: Colors.white,
//                       fontSize: 12)),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(top: 4.0, right: 6),
//                   child: SvgPicture.asset("assets/svg/icons/clock.svg"),
//                   // Image(
//                   //   image: AssetImage("assets/images/icons/awesome-clock.png"),
//                   //   height: 16,
//                   // ),
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     const Text(
//                       " Party started at",
//                       style: TextStyle(
//                           fontSize: 14,
//                           fontFamily: "OpenSans",
//                           fontWeight: FontWeight.w600,
//                           color: Colors.white),
//                     ),
//                     SizedBox(
//                       height: 4,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 4.0),
//                       child: Text("Saturday 11 am to 11:30 am",
//                           style: TextStyle(
//                             color: Colors.white,
//                           )),
//                     ),
//                     TextButton(
//                         onPressed: () {},
//                         child: const Text(
//                           "www.dubai.armanihotel.com",
//                           style: TextStyle(
//                               fontFamily: "OpenSans",
//                               decoration: TextDecoration.underline,
//                               color: Colors.grey,
//                               fontSize: 10,
//                               fontWeight: FontWeight.w400),
//                         )),
//                   ],
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
