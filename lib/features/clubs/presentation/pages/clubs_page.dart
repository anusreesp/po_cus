// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:htp_customer/exception_handling/club_exceptions.dart';
// import 'package:htp_customer/features/clubs/controllers/club_filter_list_controller.dart';
// import 'package:htp_customer/features/clubs/controllers/club_list_controller.dart';
// import 'package:htp_customer/features/clubs/data/models/club_list_api_response.dart';
// import 'package:htp_customer/features/dashboard/presentation/widgets/club_filter.dart';
// import 'package:htp_customer/htp_theme.dart';
// import '../../../dashboard/controllers/location_controller.dart';
// import '../../../dashboard/presentation/widgets/custom_app_bar.dart';
// import '../../../dashboard/presentation/widgets/search_box.dart';
// import '../widgets/club_card.dart';
// import 'club_details.dart';

// class ClubsPage extends ConsumerWidget {
//   const ClubsPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final controller = ref.watch(clubListProvider);
//     final clubFilteredController = ref.watch(clubFilteredListProvider);
//     return CustomScrollView(
//       slivers: [
//         SliverAppBar(
//             pinned: true,
//             floating: true,
//             backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//             elevation: 0,
//             expandedHeight: 130,
//             excludeHeaderSemantics: true,
//             titleTextStyle: const TextStyle(fontSize: 14),
//             title: Consumer(
//               builder: (context, ref, _){
//                 final userLocationController = ref.watch(userLocationProvider);
//                 return Text('Clubs ${userLocationController is LocationLoaded ? 'in ${userLocationController.cityName}' : ''}',
//                   style: HtpTheme.newTitleTextStyle,);
//               },
//             ),
//             // title: Text('Clubs', style: HtpTheme.newTitleTextStyle,),
//             // title: const Image(
//             //   image: AssetImage('assets/images/logos/htp_logo_gold.png'),
//             //   height: 50,

//             // ),
//             leading: const DrawerIcon(),
//             leadingWidth: 50,
//             // actions: const [
//             //   Padding(
//             //     padding: EdgeInsets.only(right: 12.0),
//             //     child: ProfileIcon(),
//             //   )
//             // ],
//             flexibleSpace: FlexibleSpaceBar(
//               background: SizedBox(
//                 height: 200,
//                 width: double.infinity,
//                 child: Align(
//                   alignment: Alignment.bottomCenter,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 18),
//                     child: SearchBox(controller: TextEditingController(),),
//                   ),
//                 ),
//               ),
//             )),
//         SliverList(
//             delegate: SliverChildListDelegate([
//           _buildBody(context, controller, clubFilteredController),
//         ]))
//       ],
//     );
//   }

//   Widget _buildBody(BuildContext context, ClubListStates controller, List<ClubDataNew> clubs) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               // Text(
//               //   "Clubs",
//               //   // style: Theme.of(context).textTheme.headline5,
//               //   style: HtpTheme.newTitleTextStyle,
//               // ),
//               const Spacer(),
//               const ClubFilter()
//             ],
//           ),

//           if (controller is ClubLoaded && controller.clubs.isNotEmpty)
//             ...clubs.map((data) => ClubCard(
//                   data: data,
//                   onTap: () {
//                     Navigator.pushNamed(context, ClubDetails.route,
//                         arguments: data.id);
//                   },
//                 )),

//           if (controller is ClubLoaded && controller.clubs.isEmpty)
//             const ClubNotFoundExceptions(),

//           if (controller is ClubsLoading) const CircularProgressIndicator(),

//           if (controller is ClubError)
//             const ClubTryAgainExceptions(),

//           // ...List.generate(
//           //     4,
//           //     (index) => ClubCard(
//           //           data: SampleData().sampleClub2[index],
//           //           onTap: () {
//           //             Navigator.pushNamed(context, ClubDetails.route);
//           //           },
//           //         )),

//           const SizedBox(
//             height: 120,
//           )
//         ],
//       ),
//     );
//   }
// }
