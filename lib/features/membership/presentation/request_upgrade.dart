// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:htp_customer/features/membership/data/json_data/data.dart';
// import 'package:htp_customer/features/membership/presentation/widgets/bottombutton.dart';
// import 'package:htp_customer/features/dashboard/presentation/widgets/background.dart';
// import 'package:htp_customer/features/profile/controller/profile_controller.dart';
// import 'package:htp_customer/htp_theme.dart';
//
// import '../../dashboard/presentation/widgets/custom_app_bar.dart';
//
// class RequestUpgrade extends ConsumerWidget {
//   static const route = '/requestupgrade';
//   const RequestUpgrade({super.key});
//
//   @override
//   Widget build(BuildContext context, ref) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: const CustomAppBar(
//           height: -10,
//         ),
//         body: Stack(
//           children: [
//             const DefaultBackground(),
//             SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                 child: Column(
//                   children: [
//                     const SizedBox(
//                       height: 12,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 8.0),
//                       child: Align(
//                           alignment: Alignment.centerLeft,
//                           child: Text(
//                             "VIP Plans",
//                             // style: HtpTheme.newTitleTextStyle
//                           )),
//                     ),
//                     const SizedBox(
//                       height: 16,
//                     ),
//                     // HorizontalScroll(),
//                     BuildBodyData(),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//         bottomSheet: const BottomButton(),
//       ),
//     );
//   }
// }
//
// class BuildBodyData extends ConsumerWidget {
//   BuildBodyData({super.key});
//
//   final List images = ["1a.png", "2a.png", "3a.png", "4a.png", "5a.png"];
//
//   final List title = [
//     "Solitaire",
//     "Platinum",
//     "Gold",
//     "Silver",
//     "Amethyst Membership"
//   ];
//
//   List feature = [
//     'Enjoy 7% cashback points',
//     'Free entry for 3 additional guests',
//     'Exciting rewards up for offline redemption',
//     'Exclusive invites for Celebrity events',
//     'Upto 6 hours prior booking for clubs & events'
//   ];
//
//   List amount = [2499, 1499, 999];
//
//   // final List listDatas = [listData1, listData2, listData3, listData4, listData5];
//   final List listDatas = datasLists;
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final id = ModalRoute.of(context)!.settings.arguments as String;
//
//     final profileController = ref.watch(profileControllerProvider);
//     // return ListView.builder(
//     //   itemCount: 5,
//     //   itemBuilder: (context, index) {
//
//     return Container(
//       width: 350,
//       height: 480,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             profileController is ProfileLoaded
//                 ? profileController.profileData.name
//                 : 'Untitled',
//             style: const TextStyle(color: Colors.white, fontSize: 16),
//           ),
//           Text(
//             profileController is ProfileLoaded
//                 ? "${profileController.profileData.activeMembershipName} Member"
//                 : "${title[0]} Member",
//             style: const TextStyle(
//                 height: 1.4,
//                 fontFamily: "OpenSans",
//                 color: Color.fromRGBO(255, 255, 255, 0.48),
//                 fontSize: 12),
//           ),
//           SizedBox(
//             height: 12,
//           ),
//
//           ClipRRect(
//             // borderRadius: BorderRadius.circular(4),
//             child: Image(
//                 width: MediaQuery.of(context).size.width,
//                 image:
//                     AssetImage("assets/images/temp/membership/solitare1.png")),
//           ),
//           SizedBox(
//             height: 24,
//           ),
//           Text(
//             "VIP Benefits",
//             style: const TextStyle(color: Colors.white, fontSize: 22),
//           ),
//           SizedBox(
//             height: 16,
//           ),
//
//           //--------------------------------
//           Container(
//             height: 150,
//             width: 300,
//             child: Column(
//               children: [
//                 dataList(feature[0]),
//                 dataList(feature[1]),
//                 dataList(feature[2]),
//                 dataList(feature[3]),
//                 dataList(feature[4])
//                 // dataList("Enjoy 7% cashback points"),
//                 // dataList("data"),
//               ],
//             ),
//           ),
//           /*
//               SizedBox(
//                 height: 25,
//                 // width: 100,
//                 child: Row(
//                   children: [
//                     Text(
//                       " \$ ${amount[0]}",
//                       style: TextStyle(
//                           color: Colors.white, fontWeight: FontWeight.w600),
//                     ),
//                     Text(
//                       " for a year",
//                       style: TextStyle(color: Colors.white),
//                     )
//                   ],
//                 ),
//               ),
//               */
//
//           // dataList("second"),
//         ],
//       ),
//     );
//
//     //   },
//     //   // height: 510,
//     //   // arrowTopPosition: 65,
//     // );
//   }
//
//   Widget dataList(String data) {
//     return Row(
//       children: [
//         const Icon(
//           size: 9,
//           Icons.circle,
//           color: Color.fromARGB(255, 187, 176, 78),
//         ),
//         Container(
//           width: 280,
//           padding: const EdgeInsets.fromLTRB(12, 0, 0, 2),
//           child: Text(
//             data,
//             style: TextStyle(
//                 fontSize: 13,
//                 height: 1.4,
//                 fontFamily: "Open Sans",
//                 color: Color.fromARGB(255, 180, 180, 180),
//                 fontWeight: FontWeight.w400),
//           ),
//         )
//       ],
//     );
//   }
// }
