// import 'package:flutter/material.dart';

// import '../../authentication/presentation/widgets/background.dart';
// import '../dashboard/presentation/pages/contactus/contactus.dart';

// class TermsAndUsage extends StatelessWidget {
//   TermsAndUsage({super.key});

//   TextStyle txtTheme = TextStyle(
//       fontFamily: "OpenSans",
//       height: 1.5,
//       color: Color.fromRGBO(195, 195, 195, 0.81),
//       fontSize: 12);

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         const DefaultBackground(),
//         Padding(
//           padding: const EdgeInsets.only(top: 138.0, left: 12),
//           child: SingleChildScrollView(
//               padding: const EdgeInsets.only(bottom: 36),
//               child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const SizedBox(
//                       height: 38,
//                     ),
//                     const Padding(
//                       padding: EdgeInsets.only(bottom: 8.0, left: 12),
//                       child: Text(
//                         "Terms and usage",
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontFamily: "Allrox",
//                             fontSize: 18,
//                             color: Colors.white),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 30,
//                     ),
//                     Container(
//                       padding: const EdgeInsets.only(
//                         left: 10,
//                         right: 16.0,
//                       ),
//                       child: Column(
//                         children: [
//                           Text(
//                             "I. Membership of Nordic Choice Club is personal and is only available to persons over the age of 21. The membership and benefits cannot be used by anyone apart from the individual members",
//                             style: txtTheme,
//                           ),
//                           const SizedBox(
//                             height: 16,
//                           ),
//                           Text(
//                             "II. The member consents to and accepts registration and processing of personal information by Nordic Choice Club in accordance with prevailing legislation and these membership terms and conditions. Nordic Choice Commercial Services AS is responsible for processing the personal information a member agrees to provide. This information, as well as purchase and bonus redemption information, may be used by Nordic Choice Hotels and participating businesses to administer Nordic Choice Club, including storage and calculation of bonus points. Members’ postal address, e-mail address and mobile number may be used to send out information and offers within the framework of prevailing Norwegian, Swedish and Danish laws and regulations. ",
//                             style: txtTheme,
//                           ),
//                           const SizedBox(
//                             height: 16,
//                           ),
//                           Text(
//                             "III. Members have the right to inspect or correct own personal information. Members can withdraw consent for allowing Nordic Choice Commercial Services AS to register and process their personal information. Withdrawal of consent will be treated as termination of membership of Nordic Choice Club",
//                             style: txtTheme,
//                           )
//                         ],
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 36,
//                     ),
//                     Container(
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
