// import 'package:change_case/change_case.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:htp_customer/features/dashboard/presentation/widgets/custom_app_bar.dart';
// import 'package:htp_customer/features/event/data/models/event_model.dart';
// import 'package:htp_customer/features/event/data/services/events_services.dart';

// import 'package:htp_customer/common/widgets_common/rounded_golden_button.dart';
// import 'package:htp_customer/features/event/presentation/pages/event_booking.dart';
// import 'package:htp_customer/router.dart';
// import 'package:intl/intl.dart';
// import 'package:share_plus/share_plus.dart';

// import '../../../../htp_theme.dart';
// import '../../../../common/widgets_common/horizontal_scroll_with_controller.dart';
// import '../../../booking/presentation/widgets/plan_upgrade_dialog.dart';
// import '../../../profile/controller/profile_controller.dart';

// class EventDetails extends ConsumerWidget {
//   static const route = '/event-details';
//   EventDetails({Key? key}) : super(key: key);

//   final List images = ["assets/images/temp/party.jpg"];

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final eventId = ModalRoute.of(context)?.settings.arguments as String;

//     return Scaffold(
//       body: FutureBuilder(
//         future: ref.read(eventServiceProvider).getSingleEvent(eventId),
//         builder: (context, snapshot){
//           if(snapshot.hasError){
//             //handle error here
//             print(snapshot.error);
//             return Center(child: Text(snapshot.error.toString()),);
//           }

//           if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
//             final EventModel eventData = snapshot.data!;
//             final List<String> photos = [
//               if(eventData.profileImage != null)
//                 eventData.profileImage!,
//                 ...eventData.photos
//             ];
//             return Scaffold(
//               appBar: CustomAppBar(
//                 child: SizedBox(
//                   width: 260,
//                   child: Text(
//                     eventData.name.toTitleCase(),
//                     overflow: TextOverflow.ellipsis,
//                     style: HtpTheme.newTitleTextStyle,
//                   ),
//                 ),
//               ),
//               body: SingleChildScrollView(
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 1),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Padding(
//                       //   padding: const EdgeInsets.only(bottom: 8.0, left: 14),
//                       //   child: Text(
//                       //     eventData.name.toTitleCase(),
//                       //     style: HtpTheme.newTitleTextStyle,
//                       //   ),
//                       // ),
//                       HorizontalScrollWithController(
//                         height: 216,
//                         arrowTopPosition: 80,
//                         itemCount: photos.length,
//                         itemBuilder: (context, index) {
//                           return Container(
//                             padding: const EdgeInsets.only(right: 8),
//                             child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(8),
//                                 child: Image.network(photos[index]),
//                                 // child: eventData.profileImage == null
//                                 //     ? const Image(
//                                 //   image: AssetImage(
//                                 //       "assets/images/temp/party.jpg"),
//                                 //   height: 216,
//                                 //   width: 352,
//                                 //   fit: BoxFit.fill,
//                                 // )
//                                 //     : Image.network(eventData.profileImage!)
//                             ),
//                           );
//                         },
//                         arrowIcon: true,
//                       ),

//                       //Location and share row
//                       Padding(
//                         padding: const EdgeInsets.fromLTRB(6, 10, 8, 10),
//                         child: Row(
//                           children: [
//                             const SizedBox(
//                               width: 6,
//                             ),
//                             // Icon(
//                             //   Icons.location_on_sharp,
//                             //   size: 16,
//                             //   color: HtpTheme.goldenColor,
//                             // ),
//                             SvgPicture.asset(
//                                 'assets/svg/bottom_nav/location_f.svg'),
//                             const SizedBox(
//                               width: 4,
//                             ),
//                             Text(
//                               eventData.club.cityName,
//                               style: const TextStyle(
//                                   color: Colors.white, fontWeight: FontWeight.w500),
//                             ),
//                             const Spacer(),
//                             GestureDetector(
//                               onTap: (){
//                                 Share.share('Upgrade your party game with Party.one '
//                                     '- the app for access to the best events and drinks '
//                                     'in town. \nCheck out - ${eventData.name} at ${eventData.club.address} and let the good times roll! Download the App: https://party.one/download');
//                               },
//                               child: const Padding(
//                                 padding: EdgeInsets.only(right: 8.0),
//                                 child: Icon(
//                                   Icons.share,
//                                   size: 24,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       // const Divider(),

//                       Container(
//                         padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
//                         margin: const EdgeInsets.all(12),
//                         // width: double.infinity,
//                         decoration: BoxDecoration(
//                           // color: Colors.white,
//                             color: HtpTheme.cardBlackColor,
//                             borderRadius: BorderRadius.circular(8)),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text(
//                               "Location",
//                               style: HtpTheme.detailTitleText,
//                               // TextStyle(
//                               //     fontFamily: "OpenSans",
//                               //     fontSize: 14,
//                               //     fontWeight: FontWeight.w600),
//                             ),
//                             const SizedBox(
//                               height: 6,
//                             ),
//                             SizedBox(
//                               width: 250,
//                               child: Text(
//                                 eventData.club.address ?? '',
//                                 style: const TextStyle(
//                                     fontFamily: "OpenSans",
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w500),
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 12,
//                             ),
//                             EventDetailsRow(
//                               icon: 'assets/svg/icons/clock.svg',
//                               title: "Event Timing",
//                               subtitle: DateFormat('dd-MMMM-yyyy : hh:mm a').format(eventData.eventData),
//                               // extra: TextButton(
//                               //     onPressed: () {},
//                               //     child: const Text(
//                               //       "www.dubai.armanihotel.com",
//                               //       style: TextStyle(
//                               //           fontFamily: "OpenSans",
//                               //           decoration: TextDecoration.underline,
//                               //           color: Colors.grey,
//                               //           fontSize: 12,
//                               //           fontWeight: FontWeight.w400),
//                               //     )),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(left: 4.0),
//                               child: EventDetailsRow(
//                                   icon: 'assets/svg/icons/dollar-icon.svg',
//                                   title: "Entry Fee Per Person",
//                                   subtitle: "\$ ${eventData.entryPerHead}"),
//                             ),
//                             const Padding(
//                               padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
//                               child: Divider(thickness: 1.5, color: Colors.white,),
//                             ),
//                             const SizedBox(
//                               height: 10,
//                             ),
//                             Container(
//                               padding: const EdgeInsets.symmetric(horizontal: 12),
//                               child: Text(
//                                   eventData.description ?? 'No description',
//                                   style: HtpTheme.montserratfont

//                                 // TextStyle(
//                                 //     fontFamily: 'OpenSans',
//                                 //     fontSize: 12,
//                                 //     color: Color.fromRGBO(0, 0, 0, 0.712),
//                                 //     fontWeight: FontWeight.w400),
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 20,
//                             ),

//                             Consumer(builder: (context, ref, _){
//                               final profileController = ref.watch(profileControllerProvider);

//                               if(profileController is ProfileLoaded){
//                                 return Row(
//                                   children: [
//                                     Expanded(
//                                       child: RoundedGoldenButton(
//                                         isActive: eventData.eventData.isAfter(DateTime.now()),
//                                         onTap: () {

//                                           if(profileController.activeMembershipData?.id == '5557d9dd-53ff-499d-a037-c8881d9da732'){
//                                             showDialog(
//                                                 context: context,
//                                                 useRootNavigator: true,
//                                                 builder: (context) {
//                                                   return const PlanUpgradeDialog();
//                                                 });
//                                           }else{
//                                             mainNavigatorKey.currentState?.push(MaterialPageRoute(builder: (context) => EventBooking(data: eventData,)));
//                                           }

//                                           // Navigator.push(context, MaterialPageRoute(builder: (context) => EventBooking(data: eventData,)));

//                                           // Navigator.pushNamed(
//                                           //   context, SingleEventDetails.route,
//                                           // arguments: <String, dynamic>{
//                                           //   "imagePath": images[0]
//                                           // }
//                                           // );
//                                         },
//                                         text: "BOOK ENTRY",
//                                       ),
//                                     ),
//                                   ],
//                                 );
//                               }

//                               return const SizedBox.shrink();
//                             }),


//                           ],
//                         ),
//                       ),


//                       Consumer(builder: (context, ref, _){
//                         return FutureBuilder(
//                             future: ref.watch(eventServiceProvider).getUpcomingEvents(eventId),
//                             builder: (context, snapshot){
//                               if(snapshot.connectionState == ConnectionState.waiting){
//                                 return const Center(child: CircularProgressIndicator(),);
//                               }
//                               if(snapshot.hasError){
//                                 debugPrint(snapshot.error.toString());
//                               }
//                               if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
//                                 final events = snapshot.data;
//                                 return Column(
//                                   children: [

//                                     Container(
//                                       margin: const EdgeInsets.fromLTRB(12, 12, 0, 0),
//                                       child: Align(
//                                           alignment: Alignment.bottomLeft,
//                                           child: Text(
//                                             "Upcoming Events",
//                                             style: mont14,
//                                             // style: Theme.of(context)
//                                             //     .textTheme
//                                             //     .headline4
//                                             //     ?.apply(color: Colors.white),
//                                           )),
//                                     ),

//                                     ...events!.map((event) => GestureDetector(
//                                       onTap: (){
//                                         Navigator.pushNamed(context, EventDetails.route, arguments: event.id);
//                                       },
//                                       child: UpcomingEvents(
//                                           imageName: event.profileImage,
//                                           eventTitle: event.name,
//                                           date: DateFormat('dd MMMM yyyy').format(event.eventData),
//                                           place: event.club.cityName
//                                       ),
//                                     ),)
//                                   ],
//                                 );
//                               }

//                               return const SizedBox.shrink();
//                             });
//                       }),
//                       // const UpcomingEvents(
//                       //     imageName: "party-crowd.jpg",
//                       //     eventTitle: "Ice-bar",
//                       //     date: "01 Mar 2023",
//                       //     place: "Singapore"),
//                       // const UpcomingEvents(
//                       //     imageName: "party-nopath.jpg",
//                       //     eventTitle: "Sanctum club",
//                       //     date: "18 Mar 2023",
//                       //     place: "Miami"),
//                       const SizedBox(
//                         height: 80,
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           }

//           return const Center(child: CircularProgressIndicator());
//         },
//       ),
//     );
//   }
// }

// class EventDetailsRow extends StatelessWidget {
//   final String icon;
//   final String title;
//   final String subtitle;
//   final Widget? extra;
//   const EventDetailsRow(
//       {Key? key,
//       required this.icon,
//       required this.title,
//       required this.subtitle,
//       this.extra})
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
//             child: SvgPicture.asset(icon),
//             //  Image(
//             //   image: AssetImage(icon),
//             //   height: 16,
//             // ),
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style: HtpTheme.detailTitleText,
//                 // const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
//               ),
//               const SizedBox(height: 4,),
//               Text(
//                 subtitle,
//                 style: const TextStyle(
//                     // fontFamily: "Montserrat",
//                     fontSize: 14,
//                     fontWeight: FontWeight.w400),
//               ),
//               if (extra != null) extra!,
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }

// class UpcomingEvents extends StatelessWidget {
//   final String? imageName;
//   final String eventTitle;
//   final String date;
//   final String place;

//   const UpcomingEvents(
//       {super.key,
//       required this.imageName,
//       required this.eventTitle,
//       required this.date,
//       required this.place});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.only(left: 12, right: 12),
//       height: 150,
//       child: Row(
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(10),
//             child: imageName == null
//                 ? const Image(
//                     fit: BoxFit.cover,
//                     height: 100,
//                     width: 120,
//                     image: AssetImage(
//                       "assets/images/temp/party-crowd.jpg",
//                     ),
//                   )
//                 : Image.network(imageName!, height: 100, width: 120, fit: BoxFit.cover,),
//           ),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.fromLTRB(16, 38, 0, 0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     eventTitle.toTitleCase(),
//                     overflow: TextOverflow.ellipsis,
//                     style:
//                         const TextStyle(color: Color(0xffe8d48a), fontSize: 15),
//                   ),
//                   const SizedBox(
//                     height: 12,
//                   ),
//                   Text(
//                     date,
//                     style: const TextStyle(color: Colors.white, fontSize: 13),
//                   ),
//                   const SizedBox(
//                     height: 4,
//                   ),
//                   Row(
//                     children: [
//                       // const Icon(
//                       //   Icons.location_on_sharp,
//                       //   size: 18,
//                       //   color: HtpTheme.goldenColor,
//                       // ),
//                       SvgPicture.asset('assets/svg/bottom_nav/location_f.svg'),
//                       const SizedBox(
//                         width: 2,
//                       ),
//                       Text(
//                         place,
//                         style: const TextStyle(color: Colors.white, fontSize: 14),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
