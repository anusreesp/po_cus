// import 'package:dots_indicator/dots_indicator.dart';
// import 'package:flutter/material.dart';
// import 'package:htp_customer/authentication/signin/login.dart';
// import 'package:intro_slider/intro_slider.dart';
//
// class SecondScreen extends StatefulWidget {
//   const SecondScreen({super.key});
//
//   @override
//   State<SecondScreen> createState() => _SecondScreenState();
// }
//
// class _SecondScreenState extends State<SecondScreen> {
//   List<ContentConfig> listContentConfig = [];
//
//   @override
//   void initState() {
//     super.initState();
//     generateListContentConfig();
//   }
//
//   navigateToPage() {
//     Navigator.pushReplacement(
//         context, MaterialPageRoute(builder: (context) => const LoginPage()));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return IntroSlider(
//       // autoScrollInterval: const Duration(seconds: 3),
//       isShowNextBtn: false,
//       isShowDoneBtn: true,
//       listContentConfig: listContentConfig,
//       backgroundColorAllTabs: Colors.white,
//       onDonePress: (() async {
//         await navigateToPage();
//       }),
//       refFuncGoToTab: (refFunc) {
//         // goToTab = refFunc;
//       },
//       indicatorConfig: const IndicatorConfig(
//         colorActiveIndicator: Colors.white,
//         colorIndicator: Colors.grey,
//         isShowIndicator: true,
//         sizeIndicator: 13.0,
//         typeIndicatorAnimation: TypeIndicatorAnimation.sizeTransition,
//       ),
//     );
//   }
//
//   List images = [
//     "assets/images/splashscreen/confident_guy_no1.png",
//     "assets/images/splashscreen/nightlife_people_no2.png",
//     "assets/images/splashscreen/band_performs_no3.png",
//     "assets/images/splashscreen/air_hostesses_no4.png",
//     "assets/images/splashscreen/party_no5.png",
//     "assets/images/splashscreen/people_entry_no6.png"
//   ];
//
//   List title = [
//     "Certified freak ! Seven Nights a week !",
//     "Stylin', Wildin' and Livin' it up in the club !",
//     "We go hard or we go home ! We gonna do this all night long !!",
//     "As we shoot across the sky; baby we are fireworks at night !",
//     "Come on make the party hot, we could make your body rock !",
//     "Every night is a VIP Night !",
//   ];
//
//   generateListContentConfig() {
//     var pathImages = "assets/images/logos/htp_logo_gold_full.png";
//     listContentConfig.add(const ContentConfig(
//       title: "Certified freak ! Seven Nights a week !",
//       maxLineTitle: 2,
//       backgroundImage: "assets/images/splashscreen/confident_guy_no1.png",
//       backgroundImageFit: BoxFit.cover,
//       pathImage: "assets/images/logos/htp_logo_gold_full.png",
//     ));
//     listContentConfig.add(ContentConfig(
//       title: "Stylin', Wildin' and Livin' it up in the club !",
//       maxLineTitle: 2,
//       backgroundImageFit: BoxFit.cover,
//       backgroundImage: "assets/images/splashscreen/nightlife_people_no2.png",
//       pathImage: pathImages,
//     ));
//     listContentConfig.add(ContentConfig(
//       title: "We go hard or we go home ! We gonna do this all night long !!",
//       maxLineTitle: 2,
//       backgroundImageFit: BoxFit.cover,
//       backgroundImage: "assets/images/splashscreen/band_performs_no3.png",
//       pathImage: pathImages,
//     ));
//     listContentConfig.add(ContentConfig(
//       title: "As we shoot across the sky; baby we are fireworks at night !",
//       maxLineTitle: 2,
//       backgroundImageFit: BoxFit.cover,
//       backgroundImage: "assets/images/splashscreen/air_hostesses_no4.png",
//       pathImage: pathImages,
//     ));
//     listContentConfig.add(ContentConfig(
//       title: "Come on make the party hot, we could make your body rock !",
//       maxLineTitle: 2,
//       backgroundImageFit: BoxFit.cover,
//       backgroundImage: "assets/images/splashscreen/party_no5.png",
//       pathImage: pathImages,
//     ));
//     listContentConfig.add(ContentConfig(
//       title: "Every night is a VIP Night !",
//       maxLineTitle: 2,
//       backgroundImageFit: BoxFit.cover,
//       backgroundImage: "assets/images/splashscreen/people_entry_no6.png",
//       pathImage: pathImages,
//     ));
//   }
// }
