// import 'package:flutter/material.dart';
// import 'package:htp_customer/features/dashboard/presentation/widgets/custom_app_bar.dart';
// import '../../../../htp_theme.dart';
// import '../../../../common/widgets_common/rounded_golden_button.dart';
// import '../../../booking/presentation/pages/entry_booking.dart';
// import '../../../booking/presentation/pages/table_booking.dart';

// class PlayingNow extends StatelessWidget {
//   static const route = '/playingnow';
//   const PlayingNow({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: const CustomAppBar(
//           height: 10,
//         ),
//         body: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: SingleChildScrollView(
//               child: Column(children: [
//                 const SizedBox(
//                   // height: 150,
//                   width: double.infinity,
//                   // child: Align(
//                   //   alignment: Alignment.bottomCenter,
//                   // ),
//                 ),
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text("Ice bar | Now Playing",
//                       style: HtpTheme
//                           .newTitleTextStyle /* TextStyle(
//                         fontSize: 19,
//                         fontFamily: "Allrox",
//                         color: Colors.white), */
//                       ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 32.0),
//                   child: ClipRRect(
//                       borderRadius: BorderRadius.circular(12),
//                       child: const Image(
//                         image: AssetImage("assets/images/temp/winebottles.jpg"),
//                         height: 150,
//                         width: 350,
//                         fit: BoxFit.fill,
//                       )),
//                 ),
//                 const SizedBox(
//                   height: 24,
//                 ),
//                 const Padding(
//                   padding: EdgeInsets.only(bottom: 160.0),
//                   child: Image(
//                       image: AssetImage("assets/images/others/playing.png")),
//                 ),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: RoundedGoldenButton(
//                         onTap: () {
//                           Navigator.pushNamed(context, TableBookingPage.route);
//                         },
//                         text: "BOOK A TABLE",
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 10,
//                     ),
//                     // Expanded(
//                     //   child:
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.pushNamed(context, EntryBooking.route,
//                             arguments: {});
//                       },
//                       child: Container(
//                         width: 150,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(26),
//                             border: Border.all(color: HtpTheme.goldenColor)),
//                         child: const Padding(
//                           padding: EdgeInsets.all(12.0),
//                           child: Center(
//                               child: Text(
//                             "BOOK ENTRY",
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.bold),
//                           )),
//                         ),
//                       ),
//                     ),
//                     // ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 80,
//                 )
//               ]),
//             )));
//   }
// }
