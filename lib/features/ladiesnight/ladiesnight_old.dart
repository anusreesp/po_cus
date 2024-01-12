// `import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:htp_customer/features/dashboard/presentation/pages/home.dart';
// import 'package:htp_customer/features/ladiesnight/controllers/ladiesnight_controller.dart';
// import 'package:htp_customer/features/ladiesnight/data/models/ladiesclub_response.dart';
// import 'package:htp_customer/features/ladiesnight/ladiesnightdetails.dart';
// import 'package:htp_customer/htp_theme.dart';

// import '../clubs/presentation/widgets/rating_box.dart';
// import '../dashboard/presentation/widgets/custom_app_bar.dart';

// class LadiesNight extends ConsumerWidget {
//   static const route = '/ladiednight';

//   LadiesNight({super.key});

//   // final List listImage = [
//   //   "party-crowd.jpg",
//   //   "party-pop.jpg",
//   //   "party-splash.jpg",
//   //   "party-crowd.jpg",
//   //   "party-pop.jpg",
//   //   "party-splash.jpg"
//   // ];
//   //
//   // List title = [
//   //   "Ice bar",
//   //   "One bar",
//   //   "Sanctum Club",
//   //   "Leisure inn",
//   //   "One bar",
//   //   "One bar"
//   // ];

//   @override
//   Widget build(BuildContext context, ref) {
//     // var controller = ref.read(ladiesNightProvider);

//     return Scaffold(
//       appBar: CustomAppBar(
//         child: Text(
//           'Ladies Night',
//           style: HtpTheme.newTitleTextStyle,
//         ),
//       ),
//       body: Column(
//         // mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Padding(
//             padding:
//                 EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.16),
//             child: const Image(
//               image: AssetImage('assets/images/placeholders/ladies_night.png'),
//               width: 240,
//             ),
//           ),
//           const SizedBox(
//             height: 16,
//             width: double.infinity,
//           ),
//           const Text(
//             "This feature is coming soon !",
//             style: TextStyle(color: Colors.white, fontSize: 12),
//           ),
//         ],
//       ),
//     );

//     // return SafeArea(
//     //   child: Scaffold(
//     //     appBar: const CustomAppBar(
//     //       height: 10,
//     //     ),
//     //     body: SingleChildScrollView(
//     //       child: Padding(
//     //         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//     //         child: Column(
//     //           children: [
//     //             const SizedBox(
//     //               // height: 140,
//     //               height: 24,
//     //               width: double.infinity,
//     //               child: Align(
//     //                 alignment: Alignment.bottomCenter,
//     //                 // child: Padding(
//     //                 //   padding:
//     //                 //       EdgeInsets.symmetric(horizontal: 0.0, vertical: 18),
//     //                 //   child: SearchBox(),
//     //                 // ),
//     //               ),
//     //             ),
//     //             Row(
//     //               children: [
//     //                 const SizedBox(
//     //                   width: 8,
//     //                 ),
//     //                 Text(
//     //                   "Ladies night",
//     //                   style: HtpTheme.newTitleTextStyle,
//     //                   //  TextStyle(
//     //                   //     fontFamily: "Allrox",
//     //                   //     color: Colors.white,
//     //                   //     fontSize: 18,
//     //                   //     fontWeight: FontWeight.w500),
//     //                 ),
//     //                 const Spacer(),
//     //                 // const ClubFilter(),
//     //                 Row(
//     //                   mainAxisSize: MainAxisSize.min,
//     //                   children: const [
//     //                     Image(
//     //                       image: AssetImage('assets/images/logo.png'),
//     //                       height: 30,
//     //                       width: 30,
//     //                     ),
//     //                     Text(
//     //                       "Karnataka",
//     //                       style: TextStyle(fontSize: 14, color: Colors.white),
//     //                     )
//     //                   ],
//     //                 ),
//     //                 const SizedBox(
//     //                   width: 12,
//     //                 ),
//     //               ],
//     //             ),
//     //             const SizedBox(height: 20),
//     //             // ...List.generate(
//     //             //     6,
//     //             //     (index) => ClubCard(
//     //             //           onTap: () {
//     //             //             Navigator.push(
//     //             //                 context,
//     //             //                 MaterialPageRoute(
//     //             //                     builder: (context) =>
//     //             //                         const LadiesNightDetails()));
//     //             //           },
//     //             //           imageName: listImage[index],
//     //             //           title: title[index],
//     //             //         )),
//     //             if (controller is LadiesNightLoaded)
//     //               ...controller.ladiesNight.map((e) => ClubCard(
//     //                     // imageName: e.photos[0],
//     //                     imageName: listImage[0],
//     //                     title: e.name,
//     //                     data: e,
//     //                     //  cityName: e.cityName as String,
//     //                     rating: '${e.rating}',
//     //                   )),
//     //
//     //             if (controller is LadiesNightLoading)
//     //               const CircularProgressIndicator(),
//     //
//     //             if (controller is LadiesNightError)
//     //               Text(
//     //                 controller.message,
//     //                 style: const TextStyle(color: Colors.red),
//     //               ),
//     //
//     //             const SizedBox(
//     //               height: 60,
//     //             )
//     //           ],
//     //         ),
//     //       ),
//     //     ),
//     //   ),
//     // );
//   }
// }

// class ClubCard extends StatelessWidget {
//   final void Function()? onTap;
//   final String imageName;
//   final LadiesNightData data;
//   final String title, rating;

//   const ClubCard(
//       {Key? key,
//       this.onTap,
//       required this.imageName,
//       required this.title,
//       // required this.cityName,
//       required this.data,
//       required this.rating})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Padding(
//         padding: const EdgeInsets.only(bottom: 12.0),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(8),
//           child: Container(
//             height: 115,
//             // color: Colors.white,
//             color: HtpTheme.cardBlackColor,
//             child: Stack(
//               children: [
//                 Row(
//                   children: [
//                     Image(
//                       image: AssetImage("assets/images/temp/$imageName"),
//                       height: 115,
//                       width: 138,
//                       fit: BoxFit.cover,
//                     ),
//                     const SizedBox(
//                       width: 12,
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           data.name,
//                           style: TextStyle(
//                               fontSize: 14, fontWeight: FontWeight.w600),
//                         ),
//                         const SizedBox(
//                           height: 16,
//                         ),
//                         Row(
//                           children: [
//                             // Icon(
//                             //   Icons.location_on_sharp,
//                             //   size: 16,
//                             //   color: HtpTheme.goldenColor,
//                             // ),
//                             SvgPicture.asset(
//                                 'assets/svg/bottom_nav/location_f.svg'),
//                             Text(
//                               " ${data.cityName.name} | ${data.distance}",
//                               style: TextStyle(
//                                   fontSize: 12, fontWeight: FontWeight.w500),
//                             )
//                           ],
//                         ),
//                         // RatingBox(
//                         //   whiteText: true,
//                         //   value: "${data.rating}",
//                         // )
//                       ],
//                     )
//                   ],
//                 ),
//                 // Positioned(
//                 //   right: 0,
//                 //   child: Container(
//                 //     height: 24,
//                 //     width: 73,
//                 //     decoration: const BoxDecoration(
//                 //         image: DecorationImage(
//                 //             image:
//                 //                 AssetImage('assets/images/featured-label.png'),
//                 //             fit: BoxFit.fill)),
//                 //     child: const Center(
//                 //         child: Text(
//                 //       "Featured",
//                 //       style: TextStyle(
//                 //           fontSize: 9,
//                 //           color: Color(0xff735c09),
//                 //           fontWeight: FontWeight.w800),
//                 //     )),
//                 //   ),
//                 // ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
