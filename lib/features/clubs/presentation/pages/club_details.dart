// import 'package:change_case/change_case.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:htp_customer/features/booking/presentation/pages/table_booking.dart';
// import 'package:htp_customer/features/booking/presentation/widgets/plan_upgrade_dialog.dart';
// import 'package:htp_customer/features/clubs/controllers/club_details_controller.dart';
// import 'package:htp_customer/features/clubs/controllers/photo_list_controller.dart';
// import 'package:htp_customer/features/clubs/data/models/fire_club_details.dart';
// import 'package:htp_customer/features/clubs/data/services/club_services.dart';
// import 'package:htp_customer/features/clubs/presentation/widgets/rating_box.dart';
// import 'package:htp_customer/features/dashboard/presentation/widgets/custom_app_bar.dart';
// import 'package:htp_customer/features/profile/controller/profile_controller.dart';
// import 'package:htp_customer/htp_theme.dart';
// import 'package:htp_customer/common/widgets_common/horizontal_scroll_with_controller.dart';
// import 'package:htp_customer/common/widgets_common/map_display.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:url_launcher/url_launcher.dart';

// import '../../../../common/utils/time_converter.dart';
// import '../../../../common/widgets_common/rounded_golden_button.dart';
// import '../../../booking/presentation/pages/entry_booking.dart';

// class ClubDetails extends StatelessWidget {
//   static const route = '/club-details';

//   const ClubDetails({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final id = ModalRoute.of(context)?.settings.arguments as String;
//     debugPrint(id);
//     return Scaffold(
//       body: Consumer(builder: (context, ref, _) {
//         return FutureBuilder<FireClubDetails>(
//             future: ref.read(clubServiceProvider).clubDetails(id),
//             builder: (context, snapshot) {
//               // ref.read(clubServiceProvider).clubDetails(id);

//               if (snapshot.connectionState == ConnectionState.done &&
//                   snapshot.hasData) {
//                 // snapshot.data!.map(
//                 //   (data) {
//                 final FireClubDetails data = snapshot.data!;

//                 List<String> sliderPhotos = [];
//                 List<String> photosList = [];
//                 for (final data in data.data.photos) {
//                   if (data is Map) {
//                     if (data['featured'] == true &&
//                         data['status'] == 'Active') {
//                       sliderPhotos.add(data['url']);
//                     }
//                     //Show photo at bottom, change filter condition here
//                     photosList.add(data['url']);
//                   }
//                 }

//                 return Scaffold(
//                   extendBody: true,
//                   appBar: CustomAppBar(
//                     child: Text(
//                       data.data.name.toTitleCase(),
//                       style: HtpTheme.newTitleTextStyle
//                           .apply(color: HtpTheme.goldenColor),
//                       // Theme.of(context)
//                       //     .textTheme
//                       //     .headline4
//                       //     ?.apply(color: Colors.white),
//                     ),
//                   ),
//                   bottomNavigationBar: BottomAppBar(
//                     color: Colors.transparent,
//                     child: Padding(
//                       padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 16),
//                       child: BookingCTA(
//                         data: data.data,
//                       ),
//                     ),
//                   ),
//                   body: SingleChildScrollView(
//                     child: Padding(
//                       padding: const EdgeInsets.only(
//                         left: 0,
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // const SizedBox(
//                           //   height: 8,
//                           // ),

//                           Stack(
//                             alignment: AlignmentDirectional.center,
//                             clipBehavior: Clip.none,
//                             children: [
//                               if (sliderPhotos.isEmpty ||
//                                   sliderPhotos.length == 1)
//                                 Container(
//                                   height: 216,
//                                   width: double.infinity,
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 12),
//                                   margin: const EdgeInsets.only(bottom: 18),
//                                   child: ClipRRect(
//                                     borderRadius: BorderRadius.circular(8),
//                                     child: sliderPhotos.length == 1
//                                         ? Image.network(
//                                             sliderPhotos.first,
//                                             fit: BoxFit.cover,
//                                           )
//                                         : const Image(
//                                             image: AssetImage(
//                                                 'assets/images/placeholders/placeholder_15.png'),
//                                             fit: BoxFit.cover,
//                                           ),
//                                   ),
//                                 ),
//                               if (sliderPhotos.length > 1)
//                                 HorizontalScrollWithController(
//                                   height: 216,
//                                   arrowTopPosition: 80,
//                                   scrollWidth: 352,
//                                   itemCount: sliderPhotos.length,
//                                   itemBuilder: (context, index) {
//                                     return Container(
//                                       padding: const EdgeInsets.only(right: 8),
//                                       child: ClipRRect(
//                                           borderRadius:
//                                               BorderRadius.circular(8),
//                                           child: Image(
//                                             image: NetworkImage(
//                                                 sliderPhotos[index]),
//                                             height: 216,
//                                             width: 352,
//                                             fit: BoxFit.fill,
//                                           )),
//                                     );
//                                     // return Stack(
//                                     //   children: [
//                                     //     Container(
//                                     //       padding: const EdgeInsets.only(right: 8),
//                                     //       child: ClipRRect(
//                                     //           borderRadius: BorderRadius.circular(8),
//                                     //           child: const Image(
//                                     //             image: AssetImage(
//                                     //                 "assets/images/temp/party.jpg"),
//                                     //             height: 216,
//                                     //             width: 352,
//                                     //             fit: BoxFit.fill,
//                                     //           )),
//                                     //     ),
//                                     /*
//                                     Positioned(
//                                         bottom: 20,
//                                         right: 20,
//                                         child: Container(
//                                           decoration: BoxDecoration(
//                                               color:
//                                                   Colors.white.withOpacity(0.7),
//                                               borderRadius:
//                                                   BorderRadius.circular(20)),
//                                           padding: const EdgeInsets.symmetric(
//                                               horizontal: 4, vertical: 2),
//                                           child: GestureDetector(
//                                             child: Row(
//                                               children: const [
//                                                 Image(
//                                                   image: AssetImage(
//                                                       "assets/images/icons/play_btn.png"),
//                                                   height: 30,
//                                                   width: 30,
//                                                 ),
//                                                 SizedBox(
//                                                   width: 6,
//                                                 ),
//                                                 Text(
//                                                   "What's Playing Now?",
//                                                   style: TextStyle(
//                                                       color: HtpTheme
//                                                           .greytext1Color,
//                                                       fontSize: 12,
//                                                       fontFamily: "Montserrat",
//                                                       fontWeight:
//                                                           FontWeight.w600),
//                                                 )
//                                               ],
//                                             ),
//                                             onTap: () {
//                                               Navigator.pushNamed(
//                                                   context, PlayingNow.route);
//                                             },
//                                           ),
//                                         ))
//                                         */
//                                     // ],
//                                     // );
//                                   },
//                                   arrowIcon: true,
//                                 ),
//                               if (data.data.logo != null)
//                                 Positioned(
//                                   bottom: -50,
//                                   child: Container(
//                                     height: 100,
//                                     width: 100,
//                                     padding: const EdgeInsets.all(2),
//                                     decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(50),
//                                         color: HtpTheme.goldenColor),
//                                     child: ClipRRect(
//                                         borderRadius: BorderRadius.circular(50),
//                                         child: Image.network(
//                                           data.data.logo!,
//                                           height: 100,
//                                           width: 100,
//                                           fit: BoxFit.cover,
//                                         )),
//                                   ),
//                                 )
//                             ],
//                           ),

//                           ///Spacing for logo
//                           if (data.data.logo != null)
//                             const SizedBox(
//                               height: 60,
//                             ),

//                           Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 16.0, vertical: 10),
//                             child: Row(
//                               children: [
//                                 RatingBox(
//                                   whiteText: true,
//                                   value: data.data.rating != null
//                                       ? "${data.data.rating}"
//                                       : "0",
//                                 ),
//                                 const SizedBox(
//                                   width: 12,
//                                 ),
//                                 // Icon(
//                                 //   Icons.location_on_sharp,
//                                 //   size: 16,
//                                 //   color: HtpTheme.goldenColor,
//                                 // ),
//                                 SvgPicture.asset(
//                                     'assets/svg/bottom_nav/location_f.svg'),
//                                 const SizedBox(
//                                   width: 2,
//                                 ),
//                                 Text(
//                                   data.data.cityName,
//                                   style: const TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.w600),
//                                 ),
//                                 const Spacer(),
//                                 GestureDetector(
//                                   onTap: () {
//                                     Share.share(
//                                         'Upgrade your party game with Party.one '
//                                         '- the app for access to the best events and drinks '
//                                         'in town. \nCheck out - ${data.data.name} at ${data.data.address} and let the good times roll! Download the App: https://party.one/download');
//                                   },
//                                   child: const Icon(
//                                     Icons.share,
//                                     size: 24,
//                                     color: Colors.white,
//                                   ),
//                                 ),

//                                 const SizedBox(
//                                   width: 24,
//                                 ),

//                                 Consumer(builder: (context, ref, _) {
//                                   final favController =
//                                       ref.watch(favProvider(data.data.id));

//                                   return GestureDetector(
//                                     onTap: () async {
//                                       if (favController == FavStates.fav) {
//                                         // await ref.read(clubServiceProvider).deleteFav(data.data.id);
//                                         // ref.invalidate(checkFavClubProvider);
//                                         // await ref.read(clubServiceProvider).deleteFav(data.data.id);
//                                         ref
//                                             .read(favProvider(data.data.id)
//                                                 .notifier)
//                                             .deleteFav();
//                                         // ref.invalidate(checkFavClubProvider);
//                                       } else {
//                                         await ref
//                                             .read(favProvider(data.data.id)
//                                                 .notifier)
//                                             .markFav(data.data);
//                                         // ref.invalidate(checkFavClubProvider);
//                                       }
//                                     },
//                                     child: favController == FavStates.fav
//                                         ? SvgPicture.asset(
//                                             "assets/svg/icons/heart/redheart_filled.svg")
//                                         : const Image(
//                                             image: AssetImage(
//                                                 "assets/images/icons/heart_icon.png"),
//                                             height: 18,
//                                           ),
//                                   );

//                                   // return isFavController.when(
//                                   //     data: (bool isFav) {
//                                   //
//                                   //       return ;
//                                   //     },
//                                   //     error: (error, _) => const SizedBox.shrink(),
//                                   //     loading: () => const SizedBox(height: 18, child: CircularProgressIndicator(),));
//                                 }),
//                               ],
//                             ),
//                           ),
//                           const Divider(),

//                           //Book card section ------------------------------------------

//                           Container(
//                             padding: const EdgeInsets.fromLTRB(16, 28, 16, 26),
//                             margin: const EdgeInsets.all(12),
//                             // width: double.infinity,
//                             decoration: BoxDecoration(
//                                 // color: Colors.white,
//                                 color: HtpTheme.cardBlackColor,
//                                 borderRadius: BorderRadius.circular(8)),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 // const SizedBox(height: 16,),

//                                 const Text(
//                                   "Location",
//                                   // style: TextStyle(
//                                   //     fontSize: 14,
//                                   //     fontWeight: FontWeight.w600),
//                                   style: HtpTheme.detailTitleText,
//                                 ),
//                                 const SizedBox(
//                                   height: 16,
//                                 ),
//                                 Text(
//                                   data.data.address ?? " ",
//                                   style: const TextStyle(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w400),
//                                 ),
//                                 // const SizedBox(
//                                 //   height: 12,
//                                 // ),
//                                 Container(
//                                   width: 260,
//                                   padding:
//                                       const EdgeInsets.symmetric(vertical: 6),
//                                   child: GestureDetector(
//                                     onTap: () {
//                                       launchUrl(Uri.parse(
//                                           data.data.websiteUrl ?? ''));
//                                     },
//                                     child: Text(
//                                       data.data.websiteUrl ?? '',
//                                       softWrap: true,
//                                       style: const TextStyle(
//                                           fontFamily: "OpenSans",
//                                           decoration: TextDecoration.underline,
//                                           color: Colors.grey,
//                                           fontSize: 14,
//                                           fontWeight: FontWeight.w400),
//                                     ),
//                                   ),
//                                 ),

//                                 //Club schedule ---------------------------------------------------------
//                                 ClubDetailsRow(
//                                   icon: 'assets/svg/icons/clock.svg',
//                                   title: "Business Hours",
//                                   subtitle: Padding(
//                                     padding: const EdgeInsets.only(top: 8.0),
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         for (final day in daysOfWeek.entries)
//                                           _slotRow(data.data.schedule,
//                                               day.value, context)
//                                         // Row(
//                                         //   children: [
//                                         //     Container(
//                                         //       width: 90,
//                                         //       margin: const EdgeInsets.only(bottom: 4),
//                                         //       child: Text(day.value,
//                                         //         style: const TextStyle(fontSize: 12),),
//                                         //     ),
//                                         //     Text('${timeConverter(data.data.schedule[day.value]?['from_time'], context)} - ${timeConverter(data.data.schedule[day.value]?['to_time'], context)}')
//                                         //   ],
//                                         // ),

//                                         // ...data.data.schedule.entries.map((e) => Row(
//                                         //   children: [
//                                         //     Container(
//                                         //       width: 90,
//                                         //       margin: const EdgeInsets.only(bottom: 4),
//                                         //       child: Text("${e.key}",
//                                         //       style: const TextStyle(fontSize: 12),),
//                                         //     ),
//                                         //     Text('${timeConverter(e.value['from_time'], context)} - ${timeConverter(e.value['to_time'], context)}')
//                                         //   ],
//                                         // ))
//                                       ],
//                                     ),
//                                   ),
//                                   // subtitle: data.data.schedule.isNotEmpty
//                                   //     ? Row(children: [
//                                   //         //  data.single.schedule.isNotEmpty ?
//                                   //         Text(
//                                   //           " ${data.single.schedule.single.days}",
//                                   //           style: HtpTheme.detailTitleText
//                                   //               .apply(fontWeightDelta: -2),
//                                   //         ),
//                                   //         Text(
//                                   //           " ${data.single.schedule.single.fromTime} ",
//                                   //           style: HtpTheme.detailTitleText
//                                   //               .apply(fontWeightDelta: -2),
//                                   //         ),
//                                   //         Text("to"),
//                                   //         Text(
//                                   //           data.single.schedule.single
//                                   //               .toTime,
//                                   //           style: HtpTheme.detailTitleText
//                                   //               .apply(fontWeightDelta: -2),
//                                   //         )
//                                   //         // : "Saturday - Sunday 11 am to 11:30 am",
//                                   //       ])
//                                   //     : Container(),
//                                 ),
//                                 ClubDetailsRow(
//                                     icon: 'assets/svg/icons/dress-code.svg',
//                                     title: "Dress Code",
//                                     subtitle: Padding(
//                                       padding: const EdgeInsets.only(top: 8.0),
//                                       child: Text(
//                                         data.data.dress?.toTitleCase() ?? 'Any',
//                                         // "${data.data.dress}",
//                                         style: HtpTheme.detailTitleText
//                                             .apply(fontWeightDelta: -2),
//                                       ),
//                                     )),
//                                 // const ClubDetailsRow(
//                                 //     icon: 'assets/svg/icons/group-people.svg',
//                                 //     title: "People already booked",
//                                 //     subtitle: Text("160+")),
//                                 // const ClubDetailsRow(
//                                 //     icon: 'assets/svg/icons/dollar-icon.svg',
//                                 //     title: "Minimum table spend",
//                                 //     subtitle: Text("\$ 360")),
//                                 // const SizedBox(
//                                 //   height: 14,
//                                 // ),
//                                 //
//                                 // Consumer(builder: (context, ref, _){
//                                 //   final profileController = ref.watch(profileControllerProvider);
//                                 //
//                                 //   if(profileController is ProfileLoaded){
//                                 //     return Row(
//                                 //       children: [
//                                 //         Flexible(
//                                 //           flex: 1,
//                                 //           child: GestureDetector(
//                                 //             onTap: () {
//                                 //               // Navigator.pushNamed(
//                                 //               //     context,
//                                 //               //     EntryBooking.route);
//                                 //
//                                 //               if(profileController.activeMembershipData.id == '5557d9dd-53ff-499d-a037-c8881d9da732'){
//                                 //                 showDialog(
//                                 //                     context: context,
//                                 //                     useRootNavigator: true,
//                                 //                     builder: (context) {
//                                 //                       return const PlanUpgradeDialog();
//                                 //                     });
//                                 //               }else{
//                                 //                 mainNavigatorKey.currentState?.push(MaterialPageRoute(builder: (context) => EntryBooking(data: data.data,)));
//                                 //               }
//                                 //
//                                 //
//                                 //             },
//                                 //             child: Container(
//                                 //               height: 50,
//                                 //               decoration: BoxDecoration(
//                                 //                   borderRadius:
//                                 //                   BorderRadius
//                                 //                       .circular(26),
//                                 //                   border: Border.all(
//                                 //                       color: HtpTheme
//                                 //                           .goldenColor)),
//                                 //               child: const Padding(
//                                 //                 padding: EdgeInsets.all(
//                                 //                     12.0),
//                                 //                 child: Center(
//                                 //                     child: Text(
//                                 //                       "BOOK ENTRY",
//                                 //                       style: TextStyle(
//                                 //                         fontWeight: FontWeight.w700,
//                                 //                         fontSize: 14,
//                                 //                       ),
//                                 //                     )),
//                                 //               ),
//                                 //             ),
//                                 //           ),
//                                 //         ),
//                                 //
//                                 //         const SizedBox(width: 12,),
//                                 //
//                                 //         Flexible(
//                                 //           flex: 1,
//                                 //           child: RoundedGoldenButton(
//                                 //             onTap: () {
//                                 //
//                                 //               //Check if plan is silver
//                                 //               if(profileController.activeMembershipData.id == '5557d9dd-53ff-499d-a037-c8881d9da732'){
//                                 //                 showDialog(
//                                 //                     context: context,
//                                 //                     useRootNavigator: true,
//                                 //                     builder: (context) {
//                                 //                       return const PlanUpgradeDialog();
//                                 //                     });
//                                 //               }else{
//                                 //                 mainNavigatorKey.currentState?.push(MaterialPageRoute(builder: (context) => TableBookingPage(data: data.data,)));
//                                 //               }
//                                 //
//                                 //               // Navigator.pushNamed(context,
//                                 //               //     TableBookingPage.route, arguments: data.single);
//                                 //             },
//                                 //             text: "BOOK A TABLE",
//                                 //             textStyle: const TextStyle(
//                                 //                 fontWeight: FontWeight.w700,
//                                 //                 fontSize: 14,
//                                 //                 color: HtpTheme.cardBlackColor),
//                                 //           ),
//                                 //         ),
//                                 //
//                                 //
//                                 //       ],
//                                 //     );
//                                 //
//                                 //   }
//                                 //
//                                 //   return const SizedBox.shrink();
//                                 // })
//                               ],
//                             ),
//                           ),

//                           // const SizedBox(height: 22,),

//                           // Container(
//                           //   height: 60,
//                           //   margin: const EdgeInsets.symmetric(vertical: 22),
//                           //   child: ListView(
//                           //     scrollDirection: Axis.horizontal,
//                           //     children: [
//                           //       Container(
//                           //         width: 60,
//                           //         margin: const EdgeInsets.only(left: 12),
//                           //         decoration: BoxDecoration(
//                           //             borderRadius: BorderRadius.circular(8),
//                           //             border: Border.all(
//                           //                 color: HtpTheme.goldenColor)),
//                           //         padding: const EdgeInsets.only(top: 4),
//                           //         child: Column(
//                           //           children: [
//                           //             Container(
//                           //               height: 30,
//                           //               width: 50,
//                           //               decoration: BoxDecoration(
//                           //                 borderRadius:
//                           //                     BorderRadius.circular(6),
//                           //                 // color: Colors.white
//                           //                 color: const Color(0xffF2F2F2),
//                           //               ),
//                           //               child: Image.asset('assets/images/icons/drink_jar.png'),
//                           //             ),
//                           //             const SizedBox(
//                           //               height: 4,
//                           //             ),
//                           //             const Text(
//                           //               "Drinks",
//                           //               style: TextStyle(
//                           //                   color: Colors.white, fontSize: 10),
//                           //             )
//                           //           ],
//                           //         ),
//                           //       ),
//                           //       const SizedBox(
//                           //         width: 12,
//                           //       ),
//                           //       ...List.generate(3, (index) {
//                           //         return Container(
//                           //           height: 60,
//                           //           width: 180,
//                           //           decoration: BoxDecoration(
//                           //               // color: Colors.white,
//                           //               color: HtpTheme.cardBlackColor,
//                           //               borderRadius: BorderRadius.circular(8)),
//                           //           padding: const EdgeInsets.all(8),
//                           //           margin: const EdgeInsets.only(right: 12),
//                           //           child: Row(
//                           //             mainAxisAlignment:
//                           //                 MainAxisAlignment.start,
//                           //             crossAxisAlignment:
//                           //                 CrossAxisAlignment.center,
//                           //             children: [
//                           //               ClipRRect(
//                           //                 borderRadius:
//                           //                     BorderRadius.circular(8),
//                           //                 child: Image.network(
//                           //                   "https://images.unsplash.com/photo-1594844181208-dea2c4cfc0bf?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=538&q=80",
//                           //                   height: 40,
//                           //                   width: 50,
//                           //                   fit: BoxFit.fitWidth,
//                           //                 ),
//                           //               ),
//                           //               const SizedBox(width: 9,),
//                           //               const Text(
//                           //                 "Cosmopolitan",
//                           //                 style: TextStyle(
//                           //                     fontWeight: FontWeight.bold),
//                           //               )
//                           //             ],
//                           //           ),
//                           //         );
//                           //       }),
//                           //     ],
//                           //   ),
//                           // ),

//                           // const Padding(
//                           //   padding: EdgeInsets.only(right: 12.0, bottom: 8),
//                           //   child: Image(
//                           //       image:
//                           //           AssetImage('assets/images/temp/map.png')),
//                           // ),
//                           Container(
//                               height: 320,
//                               padding: const EdgeInsets.only(
//                                   right: 16.0, bottom: 18, left: 16, top: 18),
//                               child: MapDisplay(
//                                   lat: data.data.latitude ?? 0,
//                                   lng: data.data.longitude ?? 0,
//                                   title: data.data.name)),

//                           Consumer(builder: (context, ref, _) {
//                             final photos =
//                                 ref.watch(photoListProvider(photosList));
//                             return GridView.count(
//                               padding: const EdgeInsets.only(
//                                   right: 16.0, left: 16, top: 12, bottom: 16),
//                               shrinkWrap: true,
//                               physics: const NeverScrollableScrollPhysics(),
//                               crossAxisCount: 2,
//                               mainAxisSpacing: 10,
//                               crossAxisSpacing: 10,
//                               children: [
//                                 // ...List.generate(4, (index) {
//                                 //   return ClipRRect(
//                                 //     borderRadius: BorderRadius.circular(6),
//                                 //     child: Image(
//                                 //         fit: BoxFit.cover,
//                                 //         height: 124,
//                                 //         image: AssetImage(
//                                 //             "assets/images/temp/clubs/${gridImages[index]}")),
//                                 //     // child: Image.network(SampleData.networkClubImages[index], height: 100, fit: BoxFit.cover,),
//                                 //   );

//                                 ...photos.map((photo) => ClipRRect(
//                                       borderRadius: BorderRadius.circular(6),
//                                       child: Image(
//                                           fit: BoxFit.cover,
//                                           height: 124,
//                                           image: NetworkImage(photo)),
//                                     ))
//                               ],
//                             );
//                           }),

//                           ///Load more button
//                           Consumer(builder: (context, ref, _) {
//                             final photos =
//                                 ref.watch(photoListProvider(photosList));
//                             if (photosList.length == photos.length) {
//                               return const SizedBox.shrink();
//                             }

//                             return Center(
//                               child: GestureDetector(
//                                 onTap: () {
//                                   ref
//                                       .read(photoListProvider(photosList)
//                                           .notifier)
//                                       .loadPhotos();
//                                 },
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(16),
//                                     border:
//                                         Border.all(color: HtpTheme.goldenColor),
//                                   ),
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 12, vertical: 8),
//                                   child: const Text(
//                                     "LOAD MORE RECENT UPDATES",
//                                     style: TextStyle(
//                                         color: Colors.white, fontSize: 12),
//                                   ),
//                                 ),
//                               ),
//                             );
//                           }),

//                           const SizedBox(
//                             height: 120,
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//                 //   },
//                 // )
//               }

//               if (snapshot.hasError) {
//                 return Center(child: Text(snapshot.error.toString()));
//               }

//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(
//                   child: CircularProgressIndicator(),
//                 );
//               }
//               return const SizedBox.shrink();
//             });
//       }),
//     );
//   }

//   Widget _slotRow(
//       Map<String, dynamic>? schedule, String day, BuildContext context) {
//     if (schedule?[day] == null) {
//       return const SizedBox.shrink();
//     }

//     return Row(
//       children: [
//         Container(
//           width: 90,
//           margin: const EdgeInsets.only(bottom: 4),
//           child: Text(
//             day,
//             style: const TextStyle(fontSize: 13),
//           ),
//         ),
//         Text(
//           '${timeConverter(schedule![day]?['from_time'], context)} - ${timeConverter(schedule[day]?['to_time'], context)}',
//           style: const TextStyle(fontSize: 13),
//         )
//       ],
//     );
//   }
// }

// class ClubDetailsRow extends StatelessWidget {
//   final String icon;
//   final String title;
//   final Widget subtitle;
//   final Widget? extra;

//   const ClubDetailsRow({
//     Key? key,
//     required this.icon,
//     required this.title,
//     required this.subtitle,
//     this.extra,
//   }) : super(key: key);

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
//             child: SvgPicture.asset(
//               icon,
//               height: 16,
//               width: 16,
//             ),
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style: HtpTheme.detailTitleText,
//                 // const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
//               ),
//               subtitle,
//               // ?? " "

//               if (extra != null) extra!,
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }

// class BookingCTA extends StatelessWidget {
//   final ClubDataModel data;
//   const BookingCTA({super.key, required this.data});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer(builder: (context, ref, _) {
//       final profileController = ref.watch(profileControllerProvider);

//       if (profileController is ProfileLoaded) {
//         return Row(
//           children: [
//             Flexible(
//               flex: 1,
//               child: GestureDetector(
//                 onTap: () {
//                   // Navigator.pushNamed(
//                   //     context,
//                   //     EntryBooking.route);

//                   if (profileController.activeMembershipData?.id ==
//                       '5557d9dd-53ff-499d-a037-c8881d9da732') {
//                     showDialog(
//                         context: context,
//                         useRootNavigator: true,
//                         builder: (context) {
//                           return const PlanUpgradeDialog();
//                         });
//                   } else {
//                     Navigator.pushNamed(context, EntryBooking.route,
//                         arguments: data);
//                     // mainNavigatorKey.currentState?.push(MaterialPageRoute(builder: (context) => EntryBooking(data: data.data,)));
//                   }
//                 },
//                 child: Container(
//                   height: 50,
//                   decoration: BoxDecoration(
//                       color: Colors.black,
//                       borderRadius: BorderRadius.circular(26),
//                       border: Border.all(color: HtpTheme.goldenColor)),
//                   child: const Padding(
//                     padding: EdgeInsets.all(12.0),
//                     child: Center(
//                         child: Text(
//                       "BOOK ENTRY",
//                       style: TextStyle(
//                         fontWeight: FontWeight.w700,
//                         fontSize: 14,
//                       ),
//                     )),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(
//               width: 12,
//             ),
//             Flexible(
//               flex: 1,
//               child: RoundedGoldenButton(
//                 onTap: () {
//                   //Check if plan is silver
//                   if (profileController.activeMembershipData?.id ==
//                       '5557d9dd-53ff-499d-a037-c8881d9da732') {
//                     showDialog(
//                         context: context,
//                         useRootNavigator: true,
//                         builder: (context) {
//                           return const PlanUpgradeDialog();
//                         });
//                   } else {
//                     Navigator.pushNamed(context, TableBookingPage.route,
//                         arguments: data);
//                     // mainNavigatorKey.currentState?.push(MaterialPageRoute(builder: (context) => TableBookingPage(data: data.data,)));
//                   }

//                   // Navigator.pushNamed(context,
//                   //     TableBookingPage.route, arguments: data.single);
//                 },
//                 text: "BOOK A TABLE",
//                 textStyle: const TextStyle(
//                     fontWeight: FontWeight.w700,
//                     fontSize: 14,
//                     color: HtpTheme.cardBlackColor),
//               ),
//             ),
//           ],
//         );
//       }

//       return const SizedBox.shrink();
//     });
//   }
// }
