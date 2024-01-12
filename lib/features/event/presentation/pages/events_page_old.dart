// import 'package:change_case/change_case.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:htp_customer/exception_handling/event_exceptions.dart';
// import 'package:htp_customer/features/dashboard/controllers/location_controller.dart';
// import 'package:htp_customer/features/event/controllers/event_list_controller.dart';
// import 'package:htp_customer/features/event/data/models/event_list_response.dart';
// import 'package:htp_customer/features/event/data/services/events_services.dart';
// import 'package:htp_customer/htp_theme.dart';
// import 'package:intl/intl.dart';
// import '../../../dashboard/presentation/widgets/custom_app_bar.dart';
// import '../../../dashboard/presentation/widgets/profile_icon.dart';
// import '../../../dashboard/presentation/widgets/search_box.dart';
// import 'events_details.dart';

// class EventsPage extends StatelessWidget {
//   static const route = '/events';
//   const EventsPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
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
//               builder: (context, ref, _) {
//                 final userLocationController = ref.watch(userLocationProvider);
//                 return Text(
//                   'Events ${userLocationController is LocationLoaded ? 'in ${userLocationController.cityName}' : ''}',
//                   style: HtpTheme.newTitleTextStyle,
//                 );
//               },
//             ),
//             // title: Text('Events', style: HtpTheme.newTitleTextStyle,),
//             // title: const LocationIcon(),
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
//                     padding:
//                         EdgeInsets.symmetric(horizontal: 12.0, vertical: 18),
//                     child: SearchBox(
//                       controller: TextEditingController(),
//                     ),
//                   ),
//                 ),
//               ),
//             )),
//         SliverList(
//             delegate: SliverChildListDelegate([
//           _buildBody(context),
//         ]))
//       ],
//     );
//   }

//   Widget _buildBody(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: Column(
//         // crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(
//             height: 20,
//           ),

//           // Align(
//           //     alignment: Alignment.bottomLeft,
//           //     child: Text(
//           //       "Events",
//           //       // style: Theme.of(context)
//           //       //     .textTheme
//           //       //     .headline4
//           //       //     ?.apply(color: Colors.white),
//           //       style: HtpTheme.newTitleTextStyle,
//           //     )),
//           //
//           // const SizedBox(
//           //   height: 20,
//           // ),

//           // Container(
//           //   height: MediaQuery.of(context).size.height,
//           //   child: ListView.builder(
//           //       // shrinkWrap: true,
//           //       itemCount: 3,
//           //       itemBuilder: ((context, index) {
//           //         return Padding(
//           //           padding: const EdgeInsets.only(bottom: 20.0),
//           //           child: listTiles(listImage[index], index, context),
//           //         );
//           //       })),
//           // ),

//           Consumer(builder: (context, ref, _) {
//             // final locationController = ref.watch(userLocationProvider);
//             final eventController = ref.watch(eventListProvider);

//             return eventController.when(data: (data) {
//               if (data.isEmpty) {
//                 return const EventNotFoundExceptions();
//               }
//               return Column(
//                 children: [...data.map((data) => listTiles(data, context))],
//               );
//             }, error: (error, _) {
//               return EventTryAgainExceptions(msg: error.toString());
//             }, loading: () {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             });

//             // if(locationController is LocationLoaded){
//             //   return FutureBuilder<List<EventDataApi>>(
//             //       future: ref.read(eventServiceProvider).getAllEvents(locationController.cityName, lat: locationController.lat, lng: locationController.lng),
//             //       builder: (context, snapshot) {
//             //         if (snapshot.connectionState == ConnectionState.done &&
//             //             snapshot.hasData) {
//             //           return Column(
//             //             children: [
//             //               ...snapshot.data!
//             //                   .map((data) => listTiles(data, context))
//             //             ],
//             //           );
//             //         }
//             //         if (snapshot.hasError) {
//             //           return Text(snapshot.error.toString());
//             //         }
//             //
//             //         if (snapshot.connectionState == ConnectionState.waiting) {
//             //           return const Center(
//             //             child: CircularProgressIndicator(),
//             //           );
//             //         }
//             //
//             //         return const SizedBox.shrink();
//             //       });
//             // }

//             // return const SizedBox.shrink();
//           }),

//           const SizedBox(
//             height: 120,
//           )
//         ],
//       ),
//     );
//   }

//   // final List listImage = [
//   //   "party-crowd.jpg",
//   //   "party-pop.jpg",
//   //   "party-splash.jpg"
//   // ];

//   Widget listTiles(EventDataApi data, BuildContext context
//       // final Function() onTap
//       ) {
//     // return ListTile(leading: Image.asset("assetsimages/temp/$imageName"));
//     return GestureDetector(
//       onTap: () {
//         Navigator.pushNamed(context, EventDetails.route, arguments: data.id);
//       },
//       child: Column(
//         children: [
//           Container(
//             // padding: const EdgeInsets.only(bottom: 16),
//             decoration: const BoxDecoration(
//                 // color: Colors.black,
//                 color: HtpTheme.cardBlackColor,
//                 borderRadius: BorderRadius.all(Radius.circular(8.0))),
//             // height: 340,
//             child: Column(children: [
//               //Image part
//               SizedBox(
//                   height: 180,
//                   width: MediaQuery.of(context).size.width,
//                   child: ClipRRect(
//                     borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(8),
//                         topRight: Radius.circular(8)),
//                     child: data.displayImage != null
//                         ? Image(
//                             fit: BoxFit.cover,
//                             width: MediaQuery.of(context).size.width,
//                             image: NetworkImage(data.displayImage!)
//                             // AssetImage(data.photos.isEmpty
//                             //     ? "assets/images/temp/party-crowd.jpg"
//                             //     : data.photos[0]),
//                             )
//                         : const Image(
//                             image: AssetImage(
//                                 'assets/images/placeholders/placeholder_15.png'),
//                             fit: BoxFit.cover,
//                           ),
//                   )),

//               //Description Part
//               const SizedBox(
//                 height: 14,
//               ),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(
//                     width: 8,
//                   ),
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.only(right: 12),
//                       child: Text(
//                         data.name.toTitleCase(),
//                         overflow: TextOverflow.ellipsis,
//                         // softWrap: true,
//                         style: mont14Golden,
//                       ),
//                     ),
//                   ),
//                   // const SizedBox(
//                   //   width: 6,
//                   // ),
//                   // const Spacer(),

//                   Padding(
//                     padding: const EdgeInsets.only(right: 10.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         //Location and distance row
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             // Image(
//                             //   image: AssetImage(
//                             //       'assets/images/icons/location_f.png'),
//                             //   height: 20,
//                             //   width: 20,
//                             // ),
//                             SvgPicture.asset(
//                               "assets/svg/bottom_nav/location_f.svg",
//                               height: 14,
//                             ),
//                             const SizedBox(width: 2),

//                             Text(
//                               '${data.club?.cityName ?? ''} ${data.distance == null ? '' : '| ${data.distance} Km'}',
//                               // data.distance == null
//                               //     ? " ${data.location} |7.21 Km"
//                               //     : " ${data.location} | ${data.distance} ",
//                               style: const TextStyle(
//                                   color: Colors.white, fontSize: 12),
//                             )
//                           ],
//                         ),
//                         const SizedBox(
//                           height: 4,
//                         ),
//                         //Days row
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             // Image(
//                             //   alignment: Alignment.centerLeft,
//                             //   image:
//                             //   AssetImage(
//                             //       'assets/images/icons/awesome-clock.png'),
//                             //   height: 17,
//                             //   width: 17,
//                             // ),
//                             SvgPicture.asset("assets/svg/icons/clock.svg"),
//                             const SizedBox(
//                               width: 5,
//                             ),
//                             Text(
//                               DateFormat('dd MMMM yyyy')
//                                   .format(data.dateAndTime),
//                               style: const TextStyle(
//                                   color: Colors.white, fontSize: 12),
//                             ),
//                             const SizedBox(
//                               width: 8,
//                             ),
//                           ],
//                         ),
//                         // const Padding(
//                         //   padding: EdgeInsets.symmetric(
//                         //       vertical: 6.0, horizontal: 16),
//                         //   child: Text(
//                         //     "11am - 11:30pm",
//                         //     style: TextStyle(
//                         //         fontSize: 12,
//                         //         color: Color.fromARGB(255, 146, 146, 146)),
//                         //   ),
//                         // )
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//               Align(
//                 alignment: Alignment.topLeft,
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//                   child: Text(
//                     data.description ?? "Description right here...",
//                     maxLines: 3,
//                     overflow: TextOverflow.ellipsis,
//                     style: const TextStyle(
//                         fontSize: 13,
//                         color: Color.fromARGB(255, 146, 146, 146)),
//                   ),
//                 ),
//               )
//             ]),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//         ],
//       ),
//     );
//   }
// }
