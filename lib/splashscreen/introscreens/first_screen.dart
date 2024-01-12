// import 'package:flutter/material.dart';
// import 'package:htp_customer/splashscreen/intro_theme.dart';
// import 'package:introduction_screen/introduction_screen.dart';
//
// class FirstScreen extends StatefulWidget {
//   static const route = '/firstscreen';
//   const FirstScreen({super.key});
//
//   @override
//   State<FirstScreen> createState() => _FirstScreenState();
// }
//
// class _FirstScreenState extends State<FirstScreen> {
//   var colorTheme = IntroTheme.colorTheme();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: IntroductionScreen(
//           autoScrollDuration: 1000,
//           pages: [
//             PageViewModel(
//               image: Image.asset(
//                   "assets/images/splashscreen/confident_guy_no1.png"),
//               title: "Certified freak ! Seven Nights a week !",
//               // bodyWidget: bodyWidget(),
//               footer: Image.asset(
//                 "assets/images/logos/htp_logo_gold_full.png",
//               ),
//               // titleWidget: titleWidget(),
//             ),
//             PageViewModel(
//               image: Image.asset(
//                   "assets/images/splashscreen/nightlife_people_no2.png"),
//               title: "Stylin', Wildin' and Livin' it up in the club !",
//               bodyWidget: Image.asset(
//                 "assets/images/logos/htp_logo_gold_full.png",
//               ),
//               // titleWidget: titleWidget(),
//             ),
//             PageViewModel(
//               image: Image.asset(
//                   "assets/images/splashscreen/band_performs_no3.png"),
//               title:
//                   "We go hard or we go home ! We gonna do this all night long !!",
//               bodyWidget: Image.asset(
//                 "assets/images/logos/htp_logo_gold_full.png",
//               ),
//               // titleWidget: titleWidget(),
//             ),
//             PageViewModel(
//               image: Image.asset(
//                   "assets/images/splashscreen/air_hostesses_no4.png"),
//               title:
//                   "As we shoot across the sky; baby we are fireworks at night !",
//               bodyWidget: Image.asset(
//                 "assets/images/logos/htp_logo_gold_full.png",
//               ),
//               // titleWidget: titleWidget(),
//             ),
//             PageViewModel(
//               image: Image.asset("assets/images/splashscreen/party_no5.png"),
//               title:
//                   "Come on make the party hot, we could make your body rock !",
//               bodyWidget: bodyWidget(),
//               footer: Image.asset(
//                 "assets/images/logos/htp_logo_gold_full.png",
//               ),
//               // titleWidget: titleWidget(),
//             ),
//             PageViewModel(
//               image: Image.asset(
//                   "assets/images/splashscreen/people_entry_no6.png"),
//               title: "Every night is a VIP Night !",
//               bodyWidget: bodyWidget(),
//               footer: Image.asset(
//                 "assets/images/logos/htp_logo_gold_full.png",
//               ),
//               // titleWidget: titleWidget(),
//             ),
//           ],
//           onDone: () {
//             debugPrint("done");
//           },
//           showDoneButton: false,
//           showNextButton: false,
//           dotsDecorator: DotsDecorator(
//               size: const Size(18.0, 6.0),
//               activeSize: const Size(20.0, 9.0),
//               activeShape: BeveledRectangleBorder(
//                   borderRadius: BorderRadius.circular(2)),
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(5))),
//         ),
//       ),
//     );
//   }
//
//   Widget bodyWidget() {
//     return const SizedBox(
//       height: 200,
//     );
//   }
//
//   Widget titlWidget() {
//     return Container(
//       height: 50,
//     );
//   }
// }
