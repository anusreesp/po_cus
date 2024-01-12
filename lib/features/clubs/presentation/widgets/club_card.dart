// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:htp_customer/features/clubs/data/models/club_list_api_response.dart';
// import 'package:htp_customer/features/clubs/data/models/club_list_response.dart';
// import 'package:htp_customer/htp_theme.dart';
// import 'rating_box.dart';

// class ClubCard extends StatelessWidget {
//   final ClubDataNew data;
//   // final String? cityName;
//   final void Function()? onTap;
//   const ClubCard({Key? key, this.onTap, required this.data}) : super(key: key);

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

//             // color: HtpTheme.cardBlackColor,
//             child: Stack(
//               children: [
//                 Row(
//                   children: [
//                     data.displayImage != null
//                         ? Image.network(
//                             data.displayImage!,
//                             height: 115,
//                             width: 138,
//                             fit: BoxFit.cover,
//                           )
//                         : const Image(
//                             image: AssetImage(
//                                 'assets/images/placeholders/placeholder_15.png'),
//                             height: 115,
//                             width: 138,
//                             fit: BoxFit.fill,
//                           ),
//                     const SizedBox(
//                       width: 12,
//                     ),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             data.name,
//                             // style: mont14Golden,
//                             softWrap: true,
//                           ),
//                           const SizedBox(
//                             height: 16,
//                           ),
//                           Row(
//                             children: [
//                               SvgPicture.asset(
//                                 "assets/svg/bottom_nav/location_f.svg",
//                                 color: Colors.white70,
//                               ),
//                               const SizedBox(
//                                 width: 4,
//                               ),
//                               // Expanded(
//                               //   child:
//                               Text(
//                                 // data.distance == null
//                                 //     ? " ${data.cityName.name} | 7.21 Km" :
//                                 data.cityName ?? '',

//                                 style: const TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w500,
//                                     color: Colors.white70),
//                                 softWrap: true,
//                                 maxLines: 2,
//                               ),
//                               // ),
//                               if (data.distance != null)
//                                 Text(
//                                   " | ${data.distance} Km",
//                                   style: TextStyle(color: Colors.white70),
//                                 ),
//                             ],
//                           ),
//                           SizedBox(
//                             width: 44,
//                             child: RatingBox(
//                               whiteText: true,
//                               value: "${data.rating ?? 0}",
//                             ),
//                           )
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//                 if (data.featured ?? false)
//                   Positioned(
//                     // right: 0,
//                     child: Container(
//                       height: 24,
//                       width: 73,
//                       decoration: const BoxDecoration(
//                           image: DecorationImage(
//                               image: AssetImage(
//                                   'assets/images/featured_label_left.png'),
//                               fit: BoxFit.fill)),
//                       child: const Center(
//                           child: Text(
//                         "Featured",
//                         style: TextStyle(
//                             fontSize: 9,
//                             color: Color(0xff735c09),
//                             fontWeight: FontWeight.w800),
//                       )),
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
