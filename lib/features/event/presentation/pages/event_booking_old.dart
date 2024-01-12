// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:htp_customer/features/booking/controllers/booking_controller.dart';
// import 'package:htp_customer/features/event/data/models/event_model.dart';
// import 'package:htp_customer/features/event/presentation/widget/add_guest_event.dart';
// import 'package:intl/intl.dart';

// import '../../../../htp_theme.dart';
// import '../../../booking/presentation/widgets/buttons/selection_button.dart';
// import '../../../dashboard/presentation/widgets/custom_app_bar.dart';

// class EventBookingOld extends ConsumerWidget {
//   static const route = '/event-booking';
//   final EventModel data;
//   const EventBookingOld({Key? key, required this.data}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     ref.read(bookingProvider.notifier).eventData = data;
//     // final guestTickController = ref.watch(guestAddProviderEvent);
//     return Scaffold(
//       appBar: CustomAppBar(
//         child: Text("Booking entry", style: HtpTheme.newTitleTextStyle),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 12),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Padding(
//               //   padding:
//               //   const EdgeInsets.only(bottom: 8.0, left: 12),
//               //   child: Text(
//               //     "Booking entry",
//               //     style: HtpTheme
//               //         .newTitleTextStyle
//               //   ),
//               // ),

//               _EventDetails(data),

//               const Padding(
//                 padding: EdgeInsets.only(top: 9.0, bottom: 12),
//                 child: Text(
//                   "Lets get ready to rock!",
//                   style: TextStyle(
//                       fontSize: 17,
//                       color: Colors.white,
//                       fontWeight: FontWeight.w500),
//                 ),
//               ),

//               TopSelectionButton(
//                 isSelected: true,
//                 onTap: () {
//                   // ref.read(selectionProvider.notifier).state = SelectionType.guest;
//                   // ref.read(guestDonetickProvider.notifier).state = false;
//                 },
//                 activeImage: "guests.svg",
//                 data: "Add Guests",
//                 inActiveImage: "guests.svg",
//                 finished: false,
//                 // finished: guestTickController.isNotEmpty,
//               ),

//               AddGuestsEvent(),

//               const SizedBox(
//                 height: 80,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _EventDetails extends StatelessWidget {
//   final EventModel data;

//   const _EventDetails(this.data);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.fromLTRB(12, 16, 0, 12),
//       height: 180,
//       child: Row(
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(10),
//             child: data.profileImage != null
//                 ? Image.network(
//                     data.profileImage!,
//                     height: 130,
//                     width: 180,
//                     fit: BoxFit.cover,
//                   )
//                 : const Image(
//                     fit: BoxFit.cover,
//                     height: 130,
//                     width: 180,
//                     image: AssetImage(
//                       "assets/images/temp/club0.jpg",
//                     ),
//                   ),
//           ),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     data.name,
//                     overflow: TextOverflow.ellipsis,
//                     style:
//                         const TextStyle(color: Color(0xffe8d48a), fontSize: 15),
//                   ),
//                   const SizedBox(
//                     height: 12,
//                   ),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // const Icon(
//                       //   Icons.location_on_sharp,
//                       //   size: 17,
//                       //   color: HtpTheme.goldenColor,
//                       // ),
//                       SvgPicture.asset(
//                         'assets/svg/bottom_nav/location_f.svg',
//                         height: 18,
//                       ),
//                       const SizedBox(
//                         width: 4,
//                       ),
//                       Expanded(
//                         child: Text(
//                           data.club.name,
//                           softWrap: true,
//                           style: const TextStyle(
//                               color: Colors.white, fontSize: 14),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 22.0),
//                     child: Text(
//                       "at ${data.club.cityName}",
//                       style: const TextStyle(
//                           color: Color.fromARGB(255, 190, 190, 190),
//                           fontSize: 12,
//                           fontWeight: FontWeight.w400),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 8,
//                   ),
//                   Row(
//                     children: [
//                       // const Image(
//                       //   image:
//                       //       AssetImage("assets/images/icons/awesome-clock.png"),
//                       //   height: 16,
//                       // ),
//                       SvgPicture.asset(
//                         "assets/svg/icons/clock.svg",
//                         height: 16,
//                       ),
//                       const SizedBox(
//                         width: 4,
//                       ),
//                       Text(
//                         DateFormat('dd MMMM yyyy').format(data.eventData),
//                         style:
//                             const TextStyle(color: Colors.white, fontSize: 13),
//                       ),
//                     ],
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 22.0),
//                     child: Text(
//                       "${DateFormat('hh').format(data.eventData)} PM onwards",
//                       style: const TextStyle(
//                           color: Color.fromARGB(255, 190, 190, 190),
//                           fontSize: 12,
//                           fontWeight: FontWeight.w400),
//                     ),
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
