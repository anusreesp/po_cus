// import 'dart:convert';

// import 'package:change_case/change_case.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:htp_customer/features/booking/controllers/booking_controller.dart';
// import 'package:htp_customer/features/booking/data/models/booking_details.dart';
// import 'package:htp_customer/features/booking/presentation/pages/confirmation/payment_process.dart';
// import 'package:htp_customer/features/booking/presentation/widgets/dashed_line.dart';
// import 'package:htp_customer/features/booking/presentation/widgets/flutter_ticket.dart';
// import 'package:htp_customer/features/booking/presentation/widgets/selection_dialog_box_container.dart';
// import 'package:htp_customer/features/dashboard/controllers/dashboard_controllers.dart';
// import 'package:htp_customer/features/dashboard/presentation/widgets/custom_app_bar.dart';
// import 'package:htp_customer/common/widgets_common/goldenborder_box.dart';
// import 'package:htp_customer/common/widgets_common/rounded_golden_button.dart';
// import 'package:intl/intl.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:url_launcher/url_launcher.dart';

// import '../../../../../common/widgets_common/goldborder_button.dart';
// import '../../../../../freshchat/controllers/freshchat_controller.dart';
// import '../../../../../htp_theme.dart';
// import '../../../../profile/controller/profile_controller.dart';
// import '../../../data/services/booking_services.dart';

// class TicketValue {
//   final String id;
//   final String bookingType;
//   TicketValue(this.id, this.bookingType);
// }

// class ConfirmTicket extends ConsumerWidget {
//   static const route = '/confirm-ticket';
//   // final String id;
//   // final String bookingType;
//   ConfirmTicket({
//     super.key,
//     // required this.id,
//     // required this.bookingType
//   });

//   TextStyle lightText1 = const TextStyle(
//       height: 1.4,
//       // fontFamily: "OpenSans",
//       color: Color.fromRGBO(255, 255, 255, 0.48),
//       fontSize: 12);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final currentstatusController = ref.watch(StatusProvider);
//     final data = ModalRoute.of(context)?.settings.arguments as TicketValue;

//     return SafeArea(
//       child: Scaffold(
//         appBar: const CustomAppBar(
//           height: 30,
//         ),
//         body: FutureBuilder<BookingResponseData>(
//             // future: eventBooking
//             //     ? ref.read(bookingServiceProvider).getEventBookingData(id)
//             //     : ref.read(bookingServiceProvider).getBookingData(id),
//             future: ref
//                 .read(bookingServiceProvider)
//                 .getBookingData(data.id, data.bookingType),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(
//                   child: CircularProgressIndicator(),
//                 );
//               }

//               if (snapshot.hasError) {
//                 return Text(snapshot.error.toString());
//               }

//               if (snapshot.hasData) {
//                 final BookingResponseData data = snapshot.data!;
//                 // print(data.data.toJson());
//                 return SingleChildScrollView(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                     child: Column(
//                       children: [
//                         // const SizedBox(
//                         //   height: 130,
//                         // ),

//                         Container(
//                           padding: const EdgeInsets.symmetric(horizontal: 16),
//                           child: Column(
//                             children: [
//                               Align(
//                                   alignment: Alignment.centerLeft,
//                                   child: Text(
//                                     "Get Ready to Rumble!",
//                                     style: HtpTheme.newTitleTextStyle,
//                                     //  TextStyle(
//                                     //     fontFamily: "Allrox",
//                                     //     color: Colors.white,
//                                     //     fontSize: 18,
//                                     //     fontWeight: FontWeight.w500),
//                                   )),
//                               const SizedBox(
//                                 height: 8,
//                               ),
//                             ],
//                           ),
//                         ),

//                         const SizedBox(
//                           height: 12,
//                         ),

//                         //--------------------------------TicketWidget
//                         FlutterTicketWidget(
//                           width: 350,
//                           height: 480,
//                           isCornerRounded: true,
//                           // ticketCutHeight: 3,
//                           child: Column(
//                             children: [
//                               //Ticket data
//                               SizedBox(
//                                   height: 238,
//                                   child: TicketData(data: data.data
//                                       // name: data.data.bookingType == 'event_entry_booking' ? (data.data.eventName ?? '') : (data.data.clubName ?? ''),
//                                       //     location: data.data.clubLocation ?? '',
//                                       //     attendeeCount: data.data.attendeeCount + 1,
//                                       //     bookingDate: data.data.bookingDate,
//                                       //     arrivalTime: data.data.expectedArrival,
//                                       //     guests: data.data.people,
//                                       //     products: data.data.products,
//                                       )),

//                               const DashedLine(
//                                 height: 2,
//                                 color: Color(0xffD9D9D9),
//                               ),

//                               // if (currentstatusController ==
//                               //     CurrentStatus.qrdisplay)
//                               //   Expanded(
//                               //       child: QRCodeWidget(
//                               //     qr: data.qrCode,
//                               //     bookingId: data.bookingId,
//                               //   )),

//                               // if (currentstatusController == CurrentStatus.sent)
//                               //   const PaymentProcess(
//                               //     status: "Payment link sent",
//                               //   ),
//                               // if (currentstatusController ==
//                               //     CurrentStatus.waiting)
//                               //   const PaymentProcess(
//                               //     status: "Waiting for approval",
//                               //   ),
//                               // if (currentstatusController ==
//                               //     CurrentStatus.denied)
//                               //   const PaymentProcess(
//                               //     status: "Payment denied",
//                               //   ),

//                               data.qrCode != null
//                                   ? Expanded(
//                                       child: QRCodeWidget(
//                                       qr: data.qrCode!,
//                                       bookingId: "${data.data.bookingId}",
//                                       data: data,
//                                     ))
//                                   : PaymentProcess(
//                                       status: data.data.bookingStatus ?? '',
//                                     ),

//                               ShareBookingBar(data: data)
//                             ],
//                           ),
//                         ),
//                         // const PayNowWidget(),

//                         GestureDetector(
//                           onTap: () {
//                             launchUrl(Uri(
//                                 scheme: 'mailto', path: 'support@party.one'));
//                           },
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 16.0, vertical: 12),
//                             // child: Text('Note: If you wish to modify or cancel your booking reservation, please reach to us at support@party.one', textAlign: TextAlign.center,),
//                             child: RichText(
//                               textAlign: TextAlign.center,
//                               text: const TextSpan(
//                                   text:
//                                       'Note: If you wish to modify or cancel your booking reservation, please reach to us at',
//                                   style: TextStyle(fontSize: 16),
//                                   children: [
//                                     TextSpan(
//                                         text: ' support@party.one',
//                                         style: TextStyle(
//                                             decoration:
//                                                 TextDecoration.underline))
//                                   ]),
//                             ),
//                           ),
//                         ),

//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 12),
//                           child: SizedBox(
//                             width: 120,
//                             child: GoldBorderButton(
//                                 height: 42,
//                                 textStyle: TextStyle(color: Colors.white),
//                                 onTap: () {
//                                   ref.read(freshChatProvider).startChat();
//                                 },
//                                 text: 'Support'),
//                           ),
//                         ),

//                         //-------------------------------- Current implementation end here ------------------------

//                         //-----------------------------------------------Pricing----------------
//                         const SizedBox(
//                           height: 16,
//                         ),
//                         // const DropDown(),
//                         if (currentstatusController == CurrentStatus.qrdisplay)
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               Container(
//                                 padding: const EdgeInsets.only(right: 24),
//                                 height: 44,
//                                 width: 170,
//                                 child: GoldBorderButton(
//                                   onTap: () {},
//                                   text: "Cancel booking",
//                                   textStyle: const TextStyle(
//                                       fontFamily: "Montserrat",
//                                       color: HtpTheme.whiteColor,
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.w600),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         const SizedBox(
//                           height: 16,
//                         ),
//                         if (currentstatusController == CurrentStatus.qrdisplay)
//                           Padding(
//                             padding:
//                                 const EdgeInsets.symmetric(horizontal: 14.0),
//                             child: GoldenBorderBox(
//                                 content: Column(
//                               children: [
//                                 const SizedBox(
//                                   height: 20,
//                                 ),
//                                 const SizedBox(
//                                   width: 220,
//                                   child: Text(
//                                     "Upload the bills after the party for a ton of cashbacks!",
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(fontSize: 14),
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   height: 12,
//                                 ),
//                                 GestureDetector(
//                                   onTap: () {},
//                                   child: billButton(),
//                                 ),
//                                 const SizedBox(
//                                   height: 18,
//                                 ),
//                               ],
//                             )),
//                           ),

//                         // const SizedBox(
//                         //   height: 18,
//                         // ),
//                         // const Padding(
//                         //   padding: EdgeInsets.symmetric(horizontal: 12.0),
//                         //   child: MembershipUpgradePart(), //Membership card commented here and at the end ---------
//                         // ),
//                         // const SizedBox(
//                         //   height: 18,
//                         // ),

//                         // Padding(
//                         //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                         //   child: referal("#GHYXTE"),
//                         // ),

//                         const SizedBox(
//                           height: 18,
//                         ),
//                         const SizedBox(
//                           height: 4,
//                         ),
//                         if (currentstatusController == CurrentStatus.qrdisplay)
//                           GestureDetector(
//                             onTap: (() {}),
//                             child: Container(
//                               padding: const EdgeInsets.symmetric(
//                                   vertical: 12, horizontal: 16),
//                               child: Ink(
//                                   width: MediaQuery.of(context).size.width,
//                                   height: 45,
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(25),
//                                       border: Border.all(
//                                           color: HtpTheme.goldenColor)),
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       // Image(
//                                       //     width: 18,
//                                       //     height: 18,
//                                       // image: AssetImage(
//                                       //     "assets/images/icons/calendar-check.png")),
//                                       SvgPicture.asset(
//                                           'assets/svg/icons/event_calendar_icon.svg'),
//                                       const SizedBox(
//                                         width: 25,
//                                       ),
//                                       Container(
//                                         alignment: Alignment.center,
//                                         child: const Text(
//                                           "Add Event to Calendar",
//                                           style: TextStyle(
//                                               fontFamily: "Open Sans",
//                                               fontSize: 15,
//                                               fontWeight: FontWeight.w600,
//                                               color: Colors.white),
//                                         ),
//                                       ),
//                                       const SizedBox(
//                                         width: 32,
//                                       ),
//                                     ],
//                                   )),
//                             ),
//                           ),
//                         const SizedBox(
//                           height: 44,
//                         )
//                       ],
//                     ),
//                   ),
//                 );
//               }

//               return const SizedBox.shrink();
//             }),
//       ),
//     );
//   }

//   Widget billButton() {
//     return Container(
//       padding: const EdgeInsets.only(top: 9),
//       // padding: EdgeInsets.symmetric(vertical: 4),
//       width: 150,
//       height: 45,
//       decoration: BoxDecoration(
//           color: HtpTheme.cardBlackColor,
//           borderRadius: BorderRadius.circular(20),
//           border: Border.all(
//             color: HtpTheme.whiteColor.withOpacity(0.6),
//           )),
//       child: const Text(
//         "Upload bill",
//         style: TextStyle(fontSize: 16, color: Colors.grey),
//         textAlign: TextAlign.center,
//       ),
//     );
//   }

//   // Widget referal(String referCode) {
//   //   return Container(
//   //     padding: EdgeInsets.symmetric(vertical: 12),
//   //     decoration: BoxDecoration(
//   //         color: HtpTheme.cardBlackColor,
//   //         borderRadius: BorderRadius.circular(12)),
//   //     child: Column(
//   //       children: [
//   //         SizedBox(
//   //           height: 8,
//   //         ),
//   //         Row(
//   //           mainAxisAlignment: MainAxisAlignment.center,
//   //           children: [
//   //             SvgPicture.asset("assets/svg/icons/ticket-tickicon.svg"),
//   //             const SizedBox(
//   //               width: 8,
//   //             ),
//   //             const SizedBox(
//   //               // width: 155,
//   //               child: Text(
//   //                 "Invite your friends using your referral code! ",
//   //                 style: TextStyle(
//   //                     fontWeight: FontWeight.w600,
//   //                     color: HtpTheme.whiteColor,
//   //                     fontSize: 13),
//   //               ),
//   //             ),
//   //           ],
//   //         ),
//   //         const SizedBox(
//   //           height: 8,
//   //         ),
//   //         Row(
//   //           children: [
//   //             const SizedBox(
//   //               width: 28,
//   //             ),
//   //             Text(
//   //               referCode,
//   //               style:
//   //                   const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
//   //             ),
//   //             Spacer(),
//   //             GestureDetector(
//   //               onTap: () {},
//   //               child: SvgPicture.asset("assets/svg/icons/share-gold.svg"),
//   //             ),
//   //             const SizedBox(
//   //               width: 28,
//   //             ),
//   //           ],
//   //         ),
//   //         const SizedBox(
//   //           height: 8,
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }

//   TextStyle clubdetailhint = const TextStyle(
//       fontFamily: "OpenSans",
//       color: Color.fromRGBO(255, 255, 255, 0.92),
//       fontSize: 10);

//   TextStyle clubDetailData = const TextStyle(
//       fontFamily: "Open Sans",
//       color: Color.fromRGBO(0, 0, 0, .96),
//       fontSize: 14);
// }
// //
// // class PayNowWidget extends StatelessWidget {
// //   const PayNowWidget({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       decoration: const BoxDecoration(
// //           color: HtpTheme.cardBlackColor,
// //           borderRadius: BorderRadius.only(
// //               bottomLeft: Radius.circular(10),
// //               bottomRight: Radius.circular(10))),
// //
// //       height: 100,
// //       width: 350,
// //       // decoration: const BoxDecoration(
// //       //   image: DecorationImage(
// //       //       fit: BoxFit.cover,
// //       //       image: svg_image.Svg(
// //       //           "assets/svg/icons/booking/other_icons/blackbg.svg")),
// //       // ),
// //       child: Row(
// //         children: [
// //           Container(
// //             padding: const EdgeInsets.only(left: 24.0, bottom: 4),
// //             width: 150,
// //             child: Row(
// //               children: const [
// //                  Text(
// //                   "\$",
// //                   style: TextStyle(
// //                       fontSize: 24,
// //                       color: Colors.white,
// //                       fontWeight: FontWeight.w600),
// //                 ),
// //                 Text(
// //                   "4999",
// //                   style: TextStyle(
// //                       fontSize: 40,
// //                       color: Colors.white,
// //                       fontWeight: FontWeight.w600),
// //                 )
// //               ],
// //             ),
// //           ),
// //           Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Container(
// //                 height: 50,
// //                 width: 160,
// //                 padding: const EdgeInsets.only(top: 8),
// //                 child: const Text(
// //                   "Please complete your payment now to confirm reservation",
// //                   style: TextStyle(
// //                       fontFamily: "OpenSans",
// //                       height: 1.5,
// //                       color: Color.fromRGBO(255, 255, 255, 0.78),
// //                       fontSize: 11),
// //                 ),
// //               ),
// //               Container(
// //                   height: 25,
// //                   width: 75,
// //                   child: RoundedGoldenButton(
// //                     height: 20,
// //                     onTap: () {},
// //                     text: "Pay Now!",
// //                     textStyle: const TextStyle(
// //                       fontSize: 11,
// //                       // fontWeight: FontWeight.w600,
// //                     ),
// //                   ))
// //             ],
// //           )
// //         ],
// //       ),
// //     );
// //   }
// // }

// class TicketData extends ConsumerWidget {
//   final BookingDetailsModel data;
//   // final DateTime bookingDate;
//   // final String location;
//   // final String name;
//   // final int attendeeCount;
//   // final String? arrivalTime;
//   // final List<Map> guests;
//   // final List<SelectedProducts> products;
//   const TicketData({super.key, required this.data
//       // required this.bookingDate,
//       // required this.attendeeCount,
//       // required this.location,
//       // required this.name,
//       // this.arrivalTime,
//       // required this.guests,
//       // required this.products
//       });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 16),
//       child: Column(
//         children: [
//           Center(
//             child: Column(children: [
//               const Text(
//                 "Booking Details",
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 15,
//                     fontWeight: FontWeight.w700),
//               ),
//               const SizedBox(
//                 height: 4,
//               ),
//               SizedBox(
//                 height: 44,
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 12),
//                   child: FittedBox(
//                     child: Text(
//                       data.bookingType == 'event_entry_booking'
//                           ? (data.eventName ?? '')
//                           : (data.clubName ?? ''),
//                       style: const TextStyle(
//                           color: Colors.black,
//                           fontSize: 28,
//                           fontWeight: FontWeight.w600),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 4,
//               ),
//               Text(
//                 "${DateFormat('MMMM dd, yyyy').format(data.bookingDate)} ${data.expectedArrival != null ? ' •  ${data.expectedArrival}' : ''}",
//                 style: const TextStyle(
//                     color: Colors.black,
//                     fontSize: 18,
//                     fontWeight: FontWeight.w500),
//               ),
//             ]),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 4.0, top: 12),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     // titleandData("Attendees count", '$attendeeCount'),
//                     attendeeCountWidget(data.people, context),
//                     const Spacer(),
//                     titleandData("Location", data.clubLocation ?? '')
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 8,
//                 ),
//                 Row(
//                   children: [
//                     if (data.bookingType == 'table_booking')
//                       preferredProducts(data.products, context)
//                   ],
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   Widget titleandData(String title, String Data) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12),
//       // width: 140,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: const TextStyle(
//                 fontFamily: "OpenSans", color: Colors.grey, fontSize: 14),
//           ),
//           const SizedBox(
//             height: 2,
//           ),
//           Text(Data,
//               style: const TextStyle(
//                 fontFamily: "Open Sans",
//                 color: Color.fromRGBO(0, 0, 0, .96),
//                 fontWeight: FontWeight.w500,
//                 fontSize: 18,
//               )),
//         ],
//       ),
//     );
//   }

//   Widget attendeeCountWidget(List<Map> guests, BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12),
//       // width: 140,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             "Guest count",
//             style: TextStyle(
//                 fontFamily: "OpenSans", color: Colors.grey, fontSize: 14),
//           ),
//           const SizedBox(
//             height: 2,
//           ),
//           Row(
//             children: [
//               Text('${guests.length + 1} ',
//                   style: const TextStyle(
//                     fontFamily: "Open Sans",
//                     color: Color.fromRGBO(0, 0, 0, .96),
//                     fontWeight: FontWeight.w500,
//                     fontSize: 18,
//                   )),
//               // if(guests.isNotEmpty)
//               GestureDetector(
//                 onTap: () {
//                   showDialog(
//                       context: context,
//                       builder: (context) {
//                         return SelectionDialogBoxContainer(
//                             height: 240,
//                             titleText: guests.isEmpty ? 'Guest' : 'Guests',
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Consumer(builder: (context, ref, _) {
//                                   final profileController =
//                                       ref.watch(profileControllerProvider);
//                                   if (profileController is ProfileLoaded) {
//                                     return Padding(
//                                         padding: const EdgeInsets.fromLTRB(
//                                             12, 8, 12, 0),
//                                         child: Text(
//                                             '${profileController.profileData.name} (You)'
//                                                 .toTitleCase()));
//                                   }
//                                   return const SizedBox.shrink();
//                                 }),
//                                 for (final guest in guests)
//                                   Padding(
//                                     padding:
//                                         const EdgeInsets.fromLTRB(12, 8, 12, 0),
//                                     child: Row(
//                                       children: [
//                                         Expanded(
//                                             child: Text(
//                                           '${guest['name']}'.toTitleCase(),
//                                           softWrap: true,
//                                         )),
//                                         // const Spacer(),
//                                         SizedBox(
//                                           width: 54,
//                                           child: Text(
//                                             '${guest['age']} | ${guest['gender'][0]}',
//                                             style: const TextStyle(
//                                                 color: Colors.white60),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                               ],
//                             ));
//                       });
//                 },
//                 child: const Text(
//                   'View',
//                   style: TextStyle(
//                     color: Color(0xffC49600),
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     // decoration: TextDecoration.underline
//                   ),
//                 ),
//               )
//             ],
//           )
//         ],
//       ),
//     );
//   }

//   Widget preferredProducts(
//       List<SelectedProducts> products, BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12),
//       // width: 140,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             "Drinks & Smokes",
//             style: TextStyle(
//                 // fontFamily: "OpenSans",
//                 color: Colors.grey,
//                 fontSize: 14),
//           ),
//           const SizedBox(
//             height: 2,
//           ),
//           Row(
//             children: [
//               Text('${products.length} ',
//                   style: const TextStyle(
//                     // fontFamily: "Open Sans",
//                     color: Color.fromRGBO(0, 0, 0, .96),
//                     fontWeight: FontWeight.w500,
//                     fontSize: 18,
//                   )),
//               // if(guests.isNotEmpty)
//               GestureDetector(
//                 onTap: () {
//                   showDialog(
//                       context: context,
//                       builder: (context) {
//                         return SelectionDialogBoxContainer(
//                             height: 240,
//                             titleText: 'Drinks & Smokes',
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 for (final product in products)
//                                   Padding(
//                                     padding:
//                                         const EdgeInsets.fromLTRB(12, 8, 12, 0),
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           product.categoryName.toTitleCase(),
//                                         ),
//                                         // const Spacer(),
//                                         Text(
//                                           '${product.brandName.toTitleCase()} (${product.productType?.toTitleCase() ?? ''})',
//                                           style: const TextStyle(
//                                               color: Colors.white60,
//                                               fontSize: 12),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 const SizedBox(
//                                   height: 12,
//                                 )
//                               ],
//                             ));
//                       });
//                 },
//                 child: products.isNotEmpty
//                     ? const Text(
//                         'View',
//                         style: TextStyle(
//                           color: Color(0xffC49600),
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                           // decoration: TextDecoration.underline
//                         ),
//                       )
//                     : const SizedBox.shrink(),
//               )
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }

// class QRCodeWidget extends StatelessWidget {
//   final String qr;
//   final String bookingId;
//   final BookingResponseData data;
//   const QRCodeWidget(
//       {super.key,
//       required this.qr,
//       required this.bookingId,
//       required this.data});

//   Uint8List convertBase64Image(String base64String) {
//     return const Base64Decoder().convert(base64String.split(',').last);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.only(top: 20),
//       child: Center(
//         child: Column(
//           children: [
//             Image.memory(
//               convertBase64Image(qr),
//               height: 96,
//             ),
//             // SvgPicture.asset("assets/svg/icons/booking/other_icons/qrcode.svg"),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 "Booking ID : $bookingId",
//                 style: const TextStyle(
//                     fontFamily: "OpenSans", color: Colors.black, fontSize: 12),
//                 textAlign: TextAlign.left,
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SvgPicture.asset("assets/svg/icons/ticket-tickicon.svg"),
//                 const SizedBox(
//                   width: 6,
//                 ),
//                 const SizedBox(
//                   // width: 155,
//                   child: Text(
//                     "Display the QR at the time of club entry ",
//                     style: TextStyle(
//                         fontWeight: FontWeight.w600,
//                         color: Colors.black,
//                         fontSize: 12),
//                   ),
//                 ),
//               ],
//             ),

//             // const Spacer(),
//             // ShareBookingBar(data: data)
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ShareBookingBar extends StatelessWidget {
//   final BookingResponseData data;
//   const ShareBookingBar({Key? key, required this.data}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 44,
//       decoration: BoxDecoration(
//         // color: Color.fromARGB(255, 228, 228, 228),
//         color: const Color(0xffE4E1E2).withOpacity(0.2),
//         borderRadius: const BorderRadius.only(
//             bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
//         child: Row(
//           children: [
//             const Text(
//               "Share Booking",
//               style: TextStyle(
//                   fontWeight: FontWeight.w600,
//                   color: Colors.black,
//                   fontSize: 14),
//             ),
//             const Spacer(),
//             GestureDetector(
//               onTap: () {
//                 Share.share(
//                     'Exciting news! Your table booking at ${data.data.clubName} for ${DateFormat('dd MMMM yyyy').format(data.data.bookingDate)} has been confirmed through Party.One. We look forward to hosting you soon. Download the App: https://party.one/download');
//               },
//               child: Container(
//                   height: 24,
//                   width: 24,
//                   color: Colors.white12,
//                   child: SvgPicture.asset("assets/svg/icons/share-gold.svg")),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// class MembershipUpgradePart extends ConsumerWidget {
//   const MembershipUpgradePart({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Stack(
//       alignment: Alignment.bottomCenter,
//       children: [
//         // ClipRRect(
//         //   borderRadius: BorderRadius.circular(6),
//         //   child: SvgPicture.asset(
//         //     "assets/svg/icons/booking/other_icons/blackbg.svg",
//         //     // "assets/svg/images/membership/cards/solitaire.svg",
//         //     fit: BoxFit.contain,
//         //     width: 320,
//         //     height: 98,
//         //   ),
//         // ),
//         SizedBox(
//           width: 320,
//           height: 135,
//           child: Column(
//             children: [
//               ClipRRect(
//                 // decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(6),
//                 // ),
//                 // child: SvgPicture.asset(
//                 //   "assets/svg/images/membership/cards/solitaire.svg",
//                 //   width: 320,
//                 //   height: 72,
//                 // ),
//                 child: const Image(
//                   image: AssetImage('assets/images/others/solitaire_card.png'),
//                   height: 72,
//                   width: 320,
//                 ),
//               ),
//               const SizedBox(
//                 height: 6,
//               ),
//               const Text(
//                 "Level up! Get the Solitaire membership plan!",
//                 style: /* HtpTheme.detailTitleText
//                         .apply(fontSizeDelta: 0.50, fontSizeFactor: 1) */
//                     TextStyle(
//                         fontFamily: "Montserrat",
//                         fontSize: 12,
//                         fontWeight: FontWeight.w700,
//                         color: Colors.white),
//               ),
//               const SizedBox(
//                 height: 6,
//               ),
//               SizedBox(
//                 width: 120,
//                 child: RoundedGoldenButton(
//                   childPadding: const EdgeInsets.all(0),
//                   onTap: () {
//                     Navigator.maybePop(context);
//                     // ref
//                     //     .read(dashboardProvider.notifier)
//                     //     .selectTab(TabItem.membership);
//                   },
//                   text: "Become a Solitaire",
//                   textStyle: const TextStyle(
//                       fontSize: 8,
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold),
//                   height: 25,
//                 ),
//               ),
//               const SizedBox(
//                 height: 6,
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
