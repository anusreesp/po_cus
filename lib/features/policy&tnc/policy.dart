// import 'package:flutter/material.dart';

// import '../../authentication/presentation/widgets/background.dart';
// import '../dashboard/presentation/pages/contactus/contactus.dart';

// class PrivacyPolicy extends StatelessWidget {
//   PrivacyPolicy({super.key});

//   TextStyle txtTheme = const TextStyle(
//       fontFamily: "OpenSans",
//       height: 1.5,
//       color: Color.fromRGBO(195, 195, 195, 0.81),
//       // color: Color.fromRGBO(255, 255, 255, 0.51),
//       fontSize: 12);

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         const DefaultBackground(),
//         Padding(
//           padding: const EdgeInsets.only(top: 138.0, left: 12),
//           child: SingleChildScrollView(
//               padding: const EdgeInsets.only(bottom: 36, left: 12, right: 12),
//               child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const SizedBox(
//                       height: 32,
//                     ),
//                     const Text(
//                       "Privacy Policy",
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontFamily: "Allrox",
//                           fontSize: 18,
//                           color: Colors.white),
//                     ),
//                     const SizedBox(
//                       height: 32,
//                     ),
//                     const Padding(
//                       padding: EdgeInsets.only(right: 8.0),
//                       child: Text(
//                         "This Policy applies to information we collect on our Website.",
//                         style: TextStyle(
//                           height: 1.7,
//                           fontSize: 15,
//                           fontFamily: "OpenSans",
//                           color: Color.fromRGBO(195, 195, 195, 0.96),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 16,
//                     ),
//                     Container(
//                       padding: const EdgeInsets.only(
//                         right: 10.0,
//                       ),
//                       child: Column(
//                         children: [
//                           Text(
//                             "- In e-mail, text, and other electronic messages between you and our Website.",
//                             style: txtTheme,
//                           ),
//                           const SizedBox(
//                             height: 16,
//                           ),
//                           Text(
//                             '- Through mobile and desktop applications you download from our Website, which provides dedicated non-browser-based interaction between you and our Website.',
//                             style: txtTheme,
//                           ),
//                           const SizedBox(
//                             height: 16,
//                           ),
//                           Text(
//                             '- When you interact with our advertising and applications on third-party websites and services if those applications or advertising include links to this Policy.',
//                             style: txtTheme,
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 152,
//                     ),
//                     SizedBox(
//                         // padding: EdgeInsets.only(left: 26),
//                         height: 140,
//                         width: 300,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.stretch,
//                           children: const [
//                             ContactDetails(
//                               icon: 'location-on.png',
//                               title: 'CLOUDENT SOLUTIONS DMCC',
//                               subtitle: Text(
//                                 "Suite 3710 Platinum Tower",
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 13,
//                                     fontWeight: FontWeight.w400),
//                               ),
//                               extra: Text(
//                                 "Cluster I, JLT, Dubai, UAE",
//                                 style: TextStyle(
//                                     fontSize: 13,
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.w400),
//                               ),
//                             ),
//                             SizedBox(
//                               height: 8,
//                             ),
//                             ContactDetails(
//                               icon: 'email.png',
//                               title: 'mailus@htp.world',
//                             ),
//                             SizedBox(
//                               height: 8,
//                             ),
//                             ContactDetails(
//                               icon: 'phone-alt.png',
//                               title: '+971-5287-23645',
//                             ),
//                           ],
//                         )),
//                   ])),
//         ),
//       ],
//     );
//   }
// }
