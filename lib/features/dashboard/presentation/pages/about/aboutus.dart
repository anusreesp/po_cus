// import 'package:flutter/material.dart';
// import 'package:htp_customer/htp_theme.dart';
// import '../../widgets/custom_app_bar.dart';

// class AboutUs extends StatelessWidget {
//   static const route = '/aboutus';
//   const AboutUs({super.key});

//   newBackground() {
//     return Container(
//         width: 200,
//         height: 180.0,
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: const AssetImage("assets/images/others/background.jpg"),
//             // fit: BoxFit.cover,
//             colorFilter: ColorFilter.mode(
//                 const Color.fromARGB(255, 73, 26, 60).withOpacity(0.8),
//                 BlendMode.darken
//                 // Colors.black.withOpacity(0.8), BlendMode.darken
//                 ),
//           ),
//         ));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: const CustomAppBar(
//           height: 20,
//         ),
//         body: Stack(
//           children: [
//             // AboutBg.backgroundImage(context),
//             Row(
//               children: [
//                 // Align(
//                 //   alignment: Alignment.center,
//                 //   child: Container(
//                 //       width: MediaQuery.of(context).size.width,
//                 //       height: 280.0,
//                 //       decoration: BoxDecoration(
//                 //         image: DecorationImage(
//                 //           opacity: 0.10,
//                 //           image: AssetImage("assets/images/others/background.jpg"),
//                 //           fit: BoxFit.cover,
//                 //           // colorFilter: ColorFilter.mode(
//                 //           //     Color.fromARGB(125, 73, 26, 60).withOpacity(0.94),
//                 //           //     BlendMode.overlay
//                 //           //     // Colors.black.withOpacity(0.8), BlendMode.darken
//                 //           //     ),
//                 //         ),
//                 //       )),
//                 // ),
//                 // CurrentBackground(),
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.only(/* top: 140.0, */ left: 12),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding:
//                         const EdgeInsets.only(bottom: 8.0, left: 12, top: 12),
//                     child: Text(
//                       "About us",
//                       style: HtpTheme.newTitleTextStyle,
//                       /* TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                           color: Colors.white), */
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 18,
//                   ),
//                   const Padding(
//                     padding:
//                         EdgeInsets.symmetric(vertical: 2.0, horizontal: 16),
//                     child: Text(
//                       "The Ultimate",
//                       style: TextStyle(color: Colors.white, fontSize: 18),
//                     ),
//                   ),
//                   const Padding(
//                     padding: EdgeInsets.only(left: 16.0),
//                     child: Text(
//                       "Nightlife App",
//                       style:
//                           // HtpTheme.lightTextTheme.headline6,
//                           TextStyle(
//                         fontSize: 23,
//                         fontFamily: "Montserrat",
//                         fontWeight: FontWeight.w600,
//                         color: Color(0xffe8d48a),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(right: 8.0),
//                     child: Container(
//                       padding: const EdgeInsets.all(18),
//                       height: 200,
//                       width: 400,
//                       child: const Text(
//                         "Using a cutting edge Technology-Driven App, we have lined up very unique features and privileges for our members, thereby assuring them of a WOW experience for the night!",
//                         style: TextStyle(
//                             wordSpacing: 1.2,
//                             height: 1.5,
//                             color: Color.fromARGB(255, 202, 202, 202),
//                             fontSize: 14),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 120,
//                   ),
//                   Container(
//                     padding: const EdgeInsets.only(left: 26),
//                     height: 180,
//                     width: 320,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: const [
//                         FootRow(
//                           icon: 'location-on.png',
//                           title:
//                               'HTP WORLDWIDE ENTERTAINMENT SOLUTIONS PTE LTD',
//                           subtitle: Text(
//                             "320, SERANGOON ROAD, ",
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 13,
//                                 fontWeight: FontWeight.w400),
//                           ),
//                           extra: Text(
//                             "#1210 CENTRIUM SQUARE,",
//                             style: TextStyle(
//                                 fontSize: 13,
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w400),
//                           ),
//                           more: Text(
//                             "SINGAPORE, 218108",
//                             style: TextStyle(
//                                 fontSize: 13,
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w400),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 3,
//                         ),
//                         FootRow(
//                           icon: 'email.png',
//                           title: 'mailus@htp.world',
//                         ),
//                         SizedBox(
//                           height: 3,
//                         ),
//                         FootRow(
//                           icon: 'phone-alt.png',
//                           title: '+971-5287-23645',
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class FootRow extends StatelessWidget {
//   final String icon;
//   final String title;
//   final Widget? subtitle;
//   final Widget? extra;
//   final Widget? more;
//   const FootRow(
//       {Key? key,
//       required this.icon,
//       required this.title,
//       this.subtitle,
//       this.more,
//       this.extra})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return
//         // Padding(
//         //   padding: const EdgeInsets.symmetric(vertical: 8.0),
//         //   child:
//         Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(top: 4.0, right: 16),
//           child: SizedBox(
//             width: 25,
//             child: Image(
//               image: AssetImage("assets/images/others/$icon"),
//               height: 18,
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: 2.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Container(
//                 padding: const EdgeInsets.only(bottom: 2),
//                 width: 250,
//                 child: Text(
//                   title,
//                   style: const TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.white),
//                 ),
//               ),
//               if (subtitle != null) subtitle!,
//               if (extra != null) extra!,
//               if (more != null) more!
//             ],
//           ),
//         )
//       ],
//       // ),
//     );
//   }
// }

// class CurrentBackground extends StatelessWidget {
//   const CurrentBackground({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.bottomLeft,
//       child: Column(
//         children: [
//           SizedBox(
//             height: 550,
//           ),
//           // Container(
//           //   height: 400,
//           //   decoration: BoxDecoration(
//           //       image: DecorationImage(
//           //           colorFilter: ColorFilter.mode(
//           //               HtpTheme.light()
//           //                   .scaffoldBackgroundColor
//           //                   .withOpacity(0.75),
//           //               BlendMode.srcOver),
//           //           alignment: Alignment.bottomLeft,
//           //           image: AssetImage(
//           //             "assets/images/others/background.jpg",
//           //           ))),
//           // ),
//           Container(
//             height: 270,
//             decoration: const BoxDecoration(
//                 image: DecorationImage(
//                     alignment: Alignment.bottomLeft,
//                     image: AssetImage(
//                       "assets/images/mask_group.png",
//                     ))),
//           ),
//         ],
//       ),
//     );
//   }
// }
