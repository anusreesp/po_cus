// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:htp_customer/features/booking/presentation/pages/table_booking.dart';
// import 'package:htp_customer/features/clubs/presentation/widgets/rating_box.dart';
// import 'package:htp_customer/htp_theme.dart';
// import 'package:htp_customer/common/widgets_common/horizontal_scroll_with_controller.dart';
// import '../../../../../common/widgets_common/rounded_golden_button.dart';
// import '../booking/presentation/pages/entry_booking.dart';
// import '../dashboard/presentation/widgets/custom_app_bar.dart';

// class LadiesNightDetails extends StatelessWidget {
//   static const route = '/ladiesnight-details';
//   const LadiesNightDetails({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: const CustomAppBar(
//           height: 20,
//         ),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.only(/* top: 120.0, */ left: 12),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 8.0, left: 12),
//                   child: Text(
//                     "Ice Bar",
//                     style: Theme.of(context).textTheme.headline5,
//                   ),
//                 ),
//                 HorizontalScrollWithController(
//                   height: 216,
//                   arrowTopPosition: 80,
//                   itemBuilder: (context, index) {
//                     return Stack(
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.only(right: 8),
//                           child: ClipRRect(
//                               borderRadius: BorderRadius.circular(8),
//                               child: const Image(
//                                 image:
//                                     AssetImage("assets/images/temp/party.jpg"),
//                                 height: 216,
//                                 width: 352,
//                                 fit: BoxFit.fill,
//                               )),
//                         ),
//                         Positioned(
//                             bottom: 20,
//                             right: 20,
//                             child: Container(
//                               decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(20)),
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 4, vertical: 2),
//                               child: Row(
//                                 children: const [
//                                   Image(
//                                     image: AssetImage(
//                                         "assets/images/icons/play_btn.png"),
//                                     height: 30,
//                                     width: 30,
//                                   ),
//                                   SizedBox(
//                                     width: 6,
//                                   ),
//                                   Text(
//                                     "What's Playing Now?",
//                                     style: TextStyle(
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.w600),
//                                   )
//                                 ],
//                               ),
//                             ))
//                       ],
//                     );
//                   },
//                   arrowIcon: true,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 16.0, vertical: 10),
//                   child: Row(
//                     children: [
//                       const RatingBox(
//                         whiteText: true,
//                       ),
//                       const SizedBox(
//                         width: 6,
//                       ),
//                       // Icon(
//                       //   Icons.location_on_sharp,
//                       //   size: 16,
//                       //   color: HtpTheme.goldenColor,
//                       // ),
//                       SvgPicture.asset('assets/svg/bottom_nav/location_f.svg'),
//                       const SizedBox(
//                         width: 6,
//                       ),
//                       const Text(
//                         "Bengaluru | 7.21 Km",
//                         style: TextStyle(
//                             color: Colors.white, fontWeight: FontWeight.w600),
//                       ),
//                       const Spacer(),
//                       const Icon(
//                         Icons.share,
//                         size: 24,
//                         color: Colors.white,
//                       ),
//                       const SizedBox(
//                         width: 14,
//                       ),
//                       const Image(
//                         image: AssetImage('assets/images/icons/heart_icon.png'),
//                         height: 20,
//                       )
//                     ],
//                   ),
//                 ),
//                 const Divider(),
//                 Container(
//                   padding: const EdgeInsets.all(16),
//                   margin: const EdgeInsets.all(12),
//                   // width: double.infinity,
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(8)),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         "Location",
//                         style: TextStyle(
//                             fontSize: 14, fontWeight: FontWeight.w600),
//                       ),
//                       const SizedBox(
//                         height: 6,
//                       ),
//                       Text(
//                         "Le maring " * 6,
//                         style: const TextStyle(
//                             fontSize: 14, fontWeight: FontWeight.w600),
//                       ),
//                       const SizedBox(
//                         height: 12,
//                       ),
//                       const ClubDetailsRow(
//                           icon: 'assets/svg/icons/clock.svg',
//                           title: "Opening hours",
//                           subtitle: "Saturday - Sunday 11 am to 11:30 am"),
//                       const ClubDetailsRow(
//                           icon: 'assets/svg/icons/dress-code.svg',
//                           title: "Dress Code",
//                           subtitle: "Casual"),
//                       // const ClubDetailsRow(
//                       //     notSvg: 1,
//                       //     icon: 'assets/svg/icons/group-people.svg',
//                       //     title: "People already booked",
//                       //     subtitle: "160+"),
//                       // const ClubDetailsRow(
//                       //     icon: 'assets/svg/icons/dollar-icon.svg',
//                       //     title: "Minimum table spend",
//                       //     subtitle: "\$ 360"),
//                       const SizedBox(
//                         height: 14,
//                       ),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: RoundedGoldenButton(
//                               onTap: () {
//                                 Navigator.pushNamed(
//                                     context, TableBookingPage.route);
//                               },
//                               text: "BOOK A TABLE",
//                             ),
//                           ),
//                           const SizedBox(
//                             width: 20,
//                           ),
//                           Expanded(
//                             child: GestureDetector(
//                               onTap: () {
//                                 Navigator.pushNamed(
//                                     context, EntryBooking.route);
//                               },
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(26),
//                                     border: Border.all(
//                                         color: HtpTheme.goldenColor)),
//                                 child: const Padding(
//                                   padding: EdgeInsets.all(12.0),
//                                   child: Center(
//                                       child: Text(
//                                     "BOOK ENTRY",
//                                     style: TextStyle(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.bold),
//                                   )),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   height: 60,
//                   margin: const EdgeInsets.symmetric(vertical: 22),
//                   child: ListView(
//                     scrollDirection: Axis.horizontal,
//                     children: [
//                       Container(
//                         width: 60,
//                         margin: const EdgeInsets.only(left: 12),
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8),
//                             border: Border.all(color: HtpTheme.goldenColor)),
//                         padding: const EdgeInsets.only(top: 4),
//                         child: Column(
//                           children: [
//                             Container(
//                               height: 30,
//                               width: 50,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(6),
//                                   color: Colors.white),
//                             ),
//                             const SizedBox(
//                               height: 4,
//                             ),
//                             const Text(
//                               "Drinks",
//                               style:
//                                   TextStyle(color: Colors.white, fontSize: 10),
//                             )
//                           ],
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 12,
//                       ),
//                       ...List.generate(3, (index) {
//                         return Container(
//                           height: 60,
//                           width: 180,
//                           decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(8)),
//                           padding: const EdgeInsets.all(8),
//                           margin: const EdgeInsets.only(right: 12),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               ClipRRect(
//                                 borderRadius: BorderRadius.circular(8),
//                                 child: Image.network(
//                                   "https://images.unsplash.com/photo-1594844181208-dea2c4cfc0bf?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=538&q=80",
//                                   height: 40,
//                                   width: 50,
//                                   fit: BoxFit.fitWidth,
//                                 ),
//                               ),
//                               const Text(
//                                 "Cosmopolitan",
//                                 style: TextStyle(fontWeight: FontWeight.bold),
//                               )
//                             ],
//                           ),
//                         );
//                       }),
//                     ],
//                   ),
//                 ),
//                 const Padding(
//                   padding: EdgeInsets.only(right: 12.0, bottom: 8),
//                   child: Image(image: AssetImage('assets/images/temp/map.png')),
//                 ),
//                 /*
//                 GridView.count(
//                   padding: const EdgeInsets.only(
//                       right: 20.0, left: 8, top: 12, bottom: 16),
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   crossAxisCount: 2,
//                   mainAxisSpacing: 10,
//                   crossAxisSpacing: 10,
//                   children: [
//                     ...List.generate(4, (index) {
//                       return ClipRRect(
//                           // borderRadius: BorderRadius.circular(8),
//                           // child: Image.network(SampleData.networkClubImages[index], height: 100, fit: BoxFit.cover,),
//                           );
//                     })
//                   ],
//                 ),
//                 Center(
//                   child: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(16),
//                       border: Border.all(color: HtpTheme.goldenColor),
//                     ),
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                     child: const Text(
//                       "LOAD MORE RECENT UPDATES",
//                       style: TextStyle(color: Colors.white, fontSize: 12),
//                     ),
//                   ),
//                 ),
//                 */
//                 const SizedBox(
//                   height: 40,
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ClubDetailsRow extends StatelessWidget {
//   final String icon;
//   final String title;
//   final String subtitle;
//   final Widget? extra;
//   final int? notSvg;
//   const ClubDetailsRow(
//       {Key? key,
//       required this.icon,
//       required this.title,
//       required this.subtitle,
//       this.extra,
//       this.notSvg})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(top: 4.0, right: 6),
//             child: notSvg != null
//                 ? Image(
//                     image: AssetImage(icon),
//                     height: 16,
//                   )
//                 : SvgPicture.asset(
//                     icon,
//                     height: 16,
//                     width: 16,
//                   ),
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style:
//                     const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
//               ),
//               Text(subtitle),
//               if (extra != null) extra!,
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
