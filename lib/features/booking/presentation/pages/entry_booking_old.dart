// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:htp_customer/features/booking/controllers/booking_selection_controller.dart';
// import 'package:htp_customer/features/booking/controllers/selection/time_slot_selection.dart';
// import 'package:htp_customer/features/booking/presentation/widgets/date_pick_widget.dart';
// import 'package:htp_customer/features/clubs/controllers/club_misc_data_controller.dart';
// import 'package:htp_customer/features/clubs/data/models/fire_club_details.dart';
// import 'package:htp_customer/features/dashboard/presentation/widgets/custom_app_bar.dart';
// import 'package:htp_customer/htp_theme.dart';
// import 'package:htp_customer/shimmers/base_shimmer.dart';
// import 'package:intl/intl.dart';

// import '../../../../common/utils/time_converter.dart';
// import '../../../../sample_data.dart' as smpl;
// import '../../../clubs/data/models/club_list_response.dart';
// import '../../controllers/booking_controller.dart';
// import '../../controllers/selection/date_controller.dart';
// import '../../controllers/selection/guests_controller.dart';
// import '../widgets/buttons/selection_button.dart';
// import '../widgets/club_details.dart';
// import 'booking_table/datepick.dart';
// import 'booking_table/guest_table.dart';
// import 'booking_table/time_selection.dart';

// class EntryBooking extends ConsumerWidget {
//   static const route = '/entry-booking';
//   final ClubDataModel data;
//   const EntryBooking({Key? key, required this.data}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final selectedTab = ref.watch(selectionProvider);
//     final datePickerProvider = ref.watch(datePickProvider);
//     final guestTickController = ref.watch(guestEditProvider);
//     final timeSelectionController = ref.watch(slotPickProvider);
//     ref.read(bookingProvider.notifier).clubId = data.id;
//     ref.read(bookingProvider.notifier).clubName = data.name;
//     return Scaffold(
//       appBar: CustomAppBar(
//         child: Text(
//           "Booking your entry",
//           style: HtpTheme.newTitleTextStyle,
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               ///Club details area
//               // Padding(
//               //   padding: const EdgeInsets.only(left: 8.0, bottom: 12),
//               //   child: Text(
//               //     "Booking your entry",
//               //     style: HtpTheme.newTitleTextStyle,
//               //   ),
//               // ),

//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     child: ClipRRect(
//                         borderRadius: BorderRadius.circular(8),
//                         // child: Image.network(data.displayImage ??
//                         //     smpl.SampleData.networkClubImages[0],
//                         //   width: 180,
//                         // )
//                         child: data.displayImage == null
//                             ? const Image(
//                                 image: AssetImage(
//                                 'assets/images/placeholders/placeholder_15.png',
//                               ))
//                             : Image.network(
//                                 data.displayImage!,
//                                 height: 120,
//                                 fit: BoxFit.cover,
//                               )),
//                   ),
//                   const SizedBox(
//                     width: 12,
//                   ),
//                   Expanded(
//                       child: ClubDetails(
//                     data: data,
//                   )),
//                 ],
//               ),

//               const Padding(
//                 padding: EdgeInsets.only(top: 18.0),
//                 child: Text(
//                   "Let's get ready to rock !",
//                   style: TextStyle(
//                       fontSize: 17,
//                       color: Colors.white,
//                       fontWeight: FontWeight.w500),
//                 ),
//               ),

//               Padding(
//                 padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
//                 child: Row(
//                   children: [
//                     TopSelectionButton(
//                       isSelected: selectedTab == SelectionType.date,
//                       onTap: () {
//                         ref.read(selectionProvider.notifier).state =
//                             SelectionType.date;
//                       },
//                       data: "Date",
//                       activeImage: "datepick.svg",
//                       inActiveImage: "datepick.svg",
//                       finished: datePickerProvider != null,
//                     ),

//                     // const SizedBox(width: 12,),
//                     //
//                     // TopSelectionButton(
//                     //   isSelected: selectedTab == SelectionType.time,
//                     //   onTap: () {
//                     //     ref.read(selectionProvider.notifier).state = SelectionType.time;
//                     //   },
//                     //   activeImage: "drinks.svg",
//                     //   data: "Time",
//                     //   inActiveImage: "drinks.svg",
//                     //   finished: timeSelectionController != null,
//                     // ),

//                     const SizedBox(
//                       width: 12,
//                     ),

//                     TopSelectionButton(
//                       isSelected: selectedTab == SelectionType.guest,
//                       onTap: () {
//                         ref.read(selectionProvider.notifier).state =
//                             SelectionType.guest;
//                       },
//                       activeImage: "guests.svg",
//                       data: "Add Guests",
//                       inActiveImage: "guests.svg",
//                       finished: false,
//                     )
//                   ],
//                 ),
//               ),

//               BuildOption(
//                 data: data,
//               )

//               /// Selections area

//               // SingleChildScrollView(
//               //   child: Container(
//               //     width: double.infinity,
//               //     margin: const EdgeInsets.only(top: 20, right: 12),
//               //     decoration: BoxDecoration(
//               //         color: Colors.white,
//               //         borderRadius: BorderRadius.circular(8)),
//               //     padding: const EdgeInsets.all(8),
//               //     child: Column(
//               //       crossAxisAlignment: CrossAxisAlignment.start,
//               //       children: [
//               //         Padding(
//               //           padding: const EdgeInsets.only(
//               //               left: 12.0, top: 8, right: 12),
//               //           child: Column(
//               //             crossAxisAlignment: CrossAxisAlignment.start,
//               //             children: [
//               //               const Text(
//               //                 "Be there on",
//               //                 style: TextStyle(fontSize: 12),
//               //               ),
//               //               DateTextField(),
//               //             ],
//               //           ),
//               //         ),
//               //         Consumer(builder: (context, ref, _) {
//               //           final drinks = ref.watch(drinksProvider);
//               //           return ExpansionSelectionList(
//               //             title: "Preferred Drinks",
//               //             subtitle: "Add upto any number of drinks.",
//               //             selectedDrinks: drinks,
//               //             select: ref.read(drinksProvider.notifier).addDrink,
//               //             deSelect:
//               //                 ref.read(drinksProvider.notifier).removeDrink,
//               //           );
//               //         }),
//               //         Consumer(builder: (context, ref, _) {
//               //           final drinks = ref.watch(drinksProvider);
//               //           return ExpansionSelectionList(
//               //             title: "Preferred Smoke",
//               //             subtitle: "Add upto any number of drinks.",
//               //             selectedDrinks: drinks,
//               //             select: ref.read(drinksProvider.notifier).addDrink,
//               //             deSelect:
//               //                 ref.read(drinksProvider.notifier).removeDrink,
//               //           );
//               //         }),
//               //         const AgeConfirmationCheckbox(),
//               //         Padding(
//               //           padding: const EdgeInsets.symmetric(vertical: 8.0),
//               //           child: RoundedGoldenButton(
//               //               onTap: () {
//               //                 Navigator.push(
//               //                     context,
//               //                     MaterialPageRoute(
//               //                         builder: (context) =>
//               //                             const Confirmation()));
//               //               },
//               //               text: "CONFIRM BOOKING"),
//               //         )
//               //       ],
//               //     ),
//               //   ),
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class BuildOption extends ConsumerWidget {
//   final ClubDataModel data;
//   const BuildOption({super.key, required this.data});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final selectionController = ref.watch(selectionProvider);
//     final miscDataController = ref.watch(clubMiscDataProvider(data.id));

//     if (miscDataController is ClubMisLoaded) {
//       return Container(
//         child: buildArea(selectionController, ref, miscDataController, data),
//       );
//     }
//     return const BaseShimmer(
//       child: ShimmerBoxCornered(
//         width: double.infinity,
//         height: 260,
//       ),
//     );
//   }

//   Widget buildArea(SelectionType type, WidgetRef ref, ClubMisLoaded miscData,
//       ClubDataModel clubData) {
//     // final today = DateTime.now();
//     // final Map<String, dynamic>? todaySchedule = clubData.schedule[DateFormat('EEEE').format(today)];
//     // final fromTime = timeConverterTimeOfDay(todaySchedule?['from_time']);
//     // final toTime = timeConverterTimeOfDay(todaySchedule?['to_time']);
//     // final slots = timeSlotGenerator(fromTime, toTime, const Duration(minutes: 60));
//     List<String> slots =
//         clubData.slots.map((e) => '${e['slot_time']} ${e['zone']}').toList();
//     if (slots.isEmpty) {
//       slots = ['10 PM'];
//     }

//     switch (type) {
//       case SelectionType.date:
//         return DatePickWidget(
//           holidays: miscData.closedDates,
//           slots: slots,
//           onNextClick: () {
//             ref.read(selectionProvider.notifier).state = SelectionType.guest;
//           },
//         );
//       case SelectionType.guest:
//         return AddGuestsNew(
//           onBackClick: () {
//             ref.read(selectionProvider.notifier).state = SelectionType.date;
//           },
//           onNextClick: (guests) {
//             ref.read(bookingProvider.notifier).bookEntry(guests);
//           },
//         );

//       // case SelectionType.time:
//       //   return const TimeSelection();

//       default:
//         return DatePickWidget(
//           holidays: miscData.closedDates,
//           slots: slots.toList(),
//           onNextClick: () {
//             ref.read(selectionProvider.notifier).state = SelectionType.guest;
//           },
//         );
//     }
//   }
// }
