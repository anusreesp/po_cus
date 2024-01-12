// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:htp_customer/htp_theme.dart';
// import 'package:htp_customer/splashscreen/intro_theme.dart';
// import 'package:htp_customer/splashscreen/introscreens/intro_screen.dart';
//
// class SplashScreenPage extends StatefulWidget {
//   static const route = '/splashscreen';
//
//   const SplashScreenPage({super.key});
//
//   @override
//   State<SplashScreenPage> createState() => _SplashScreenPageState();
// }
//
// class _SplashScreenPageState extends State<SplashScreenPage> {
//   Timer startTime() {
//     var duration = const Duration(seconds: 5);
//     return Timer(duration, navigateToPage);
//   }
//
//   navigateToPage() {
//     Navigator.pushReplacement(
//         context, MaterialPageRoute(builder: (context) => const IntroScreen()));
//   }
//
//   Timer? _timer;
//
//   @override
//   void initState() {
//     super.initState();
//     _timer = startTime();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _timer?.cancel();
//   }
//
//   // var colorTheme = IntroTheme.colorTheme();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Container(
//       // color: colorTheme.backgroundColor,
//       color: HtpTheme.blackColor,
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const SizedBox(
//               height: 200,
//             ),
//             Image.asset(
//               "assets/images/logos/party_onebottom.png",
//               height: 155,
//               width: 200,
//             ),
//             const Spacer(),
//             // SizedBox(
//             //   height: 200,
//             // ),
//             // const Padding(padding: EdgeInsets.only(top: 80.0)),
//             Column(children: [
//               const Text(
//                 'The Ultimate',
//                 style: man16White,
//               ),
//               Text(
//                 'Nightlife App',
//                 style: man37Gold,
//               ),
//             ]),
//
//             const SizedBox(
//               height: 50,
//             ),
//           ],
//         ),
//       ),
//     ));
//   }
// }
