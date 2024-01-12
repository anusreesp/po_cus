// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:htp_customer/common/utils/time_converter.dart';
// import 'package:htp_customer/features/booking/controllers/booking_controller.dart';
// import 'package:htp_customer/features/booking/controllers/booking_selection_controller.dart';
// import 'package:htp_customer/features/booking/controllers/selection/date_controller.dart';
// import 'package:htp_customer/features/booking/controllers/selection/drinks_controller.dart';
// import 'package:htp_customer/features/booking/controllers/selection/guests_controller.dart';
// import 'package:htp_customer/features/booking/controllers/selection/table_selection_controller.dart';
// import 'package:htp_customer/features/booking/presentation/pages/booking_table/datepick.dart';
// import 'package:htp_customer/features/booking/presentation/pages/booking_table/drinks/drink_table.dart';
// import 'package:htp_customer/features/booking/presentation/pages/booking_table/guest_table.dart';
// import 'package:htp_customer/features/booking/presentation/pages/booking_table/smoke/smoke_table.dart';
// import 'package:htp_customer/features/booking/presentation/widgets/buttons/selection_button.dart';
// import 'package:intl/intl.dart';
//
// import '../../../../../shimmers/base_shimmer.dart';
// import '../../../../clubs/controllers/club_misc_data_controller.dart';
// import '../../../../clubs/data/models/fire_club_details.dart';
// import '../../../controllers/selection/smoke_controller.dart';
// import '../../widgets/date_pick_widget.dart';
// import '../../widgets/new/add_guest.dart';
//
// class BookingTableSelectionButtons extends ConsumerWidget {
//   final ClubDataModel data;
//   const BookingTableSelectionButtons({super.key, required this.data});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     ref.read(bookingProvider.notifier).clubId = data.id;
//     ref.read(bookingProvider.notifier).clubName = data.name;
//
//     final BookingController = ref.watch(selectionProvider);
//
//     final datePickerProvider = ref.watch(datePickProvider);
//     // final drinkTickController = ref.watch(drinkProvider);
//     // final smokeTickController = ref.watch(smokeProvider);
//     final guestTickController = ref.watch(guestEditProvider);
//     final preferredTableController = ref.watch(clubTableProvider);
//     final selectedTableController = ref.watch(selectedTableProvider);
//     final timeSlotController = ref.watch(slotPickProvider);
//
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
//       child: Row(
//         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           /* OptionSelection() */
//           TopSelectionButton(
//             isSelected: BookingController == SelectionType.date,
//             onTap: () {
//               ref.read(selectionProvider.notifier).state = SelectionType.date;
//               // ref.read(dateDonetickProvider.notifier).state = false;
//             },
//             data: "Date",
//             activeImage: "datepick.svg",
//             inActiveImage: "datepick.svg",
//             finished: datePickerProvider != null,
//           ),
//
//           const SizedBox(
//             width: 12,
//           ),
//           // TopSelectionButton(
//           //   isSelected: BookingController == SelectionType.drinks,
//           //   onTap: () {
//           //     ref.read(selectionProvider.notifier).state = SelectionType.drinks;
//           //     // ref.read(drinkDonetickProvider.notifier).state = false;
//           //   },
//           //   activeImage: "drinks.svg",
//           //   data: "Drinks",
//           //   inActiveImage: "drinks.svg",
//           //   finished: drinkTickController.isNotEmpty,
//           // ),
//           // TopSelectionButton(
//           //   isSelected: BookingController == SelectionType.smokes,
//           //   onTap: () {
//           //     ref.read(selectionProvider.notifier).state = SelectionType.smokes;
//           //     // ref.read(smokeDonetickProvider.notifier).state = false;
//           //   },
//           //   activeImage: "smoke.svg",
//           //   data: "Smokes",
//           //   inActiveImage: "smoke.svg",
//           //   finished: smokeTickController.isNotEmpty,
//           // ),
//           TopSelectionButton(
//             // isSelected: BookingController == SelectionType.guest && preferredTableController.isNotEmpty,
//             isSelected: BookingController == SelectionType.guest,
//             onTap: () {
//               ref.read(selectionProvider.notifier).state = SelectionType.guest;
//               // ref.read(guestDonetickProvider.notifier).state = false;
//             },
//             activeImage: "guests.svg",
//             data: "Add Guests",
//             inActiveImage: "guests.svg",
//             // finished: guestTickController.isNotEmpty,
//             finished: false,
//           )
//         ],
//       ),
//     );
//   }
// }
//
// class TableData extends ConsumerWidget {
//   final ClubDataModel data;
//   const TableData({super.key, required this.data});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final selectionController = ref.watch(selectionProvider);
//
//     // final miscDataController = ref.watch(clubMiscDataProvider('681151ae-d879-4743-9f03-a25159d0189c'));
//     final miscDataController = ref.watch(clubMiscDataProvider(data.id));
//
//     if (miscDataController is ClubMisLoaded) {
//       return Container(
//         child: buildArea(selectionController, ref, miscDataController, data),
//       );
//     }
//     return const ShimmerBoxCornered(
//       width: double.infinity,
//       height: 260,
//     );
//   }
//
//   Widget buildArea(SelectionType type, WidgetRef ref, ClubMisLoaded data,
//       ClubDataModel clubData) {
//     // final today = DateTime.now();
//     // final Map<String, dynamic>? todaySchedule = clubData.schedule[DateFormat('EEEE').format(today)];
//     final fromTime = timeConverterTimeOfDay(clubData.schedule['Monday']['from_time']);
//     final toTime = timeConverterTimeOfDay(clubData.schedule['Monday']['to_time']);
//     final timeSlots = timeSlotGenerator(fromTime, toTime, const Duration(minutes: 60));
//     print("TIME SLOT $timeSlots");
//     // List<String> slots =
//     //     clubData.slots.map((e) => '${e['slot_time']} ${e['zone']}').toList();
//     // if (slots.isEmpty) {
//     //   slots = ['10 PM'];
//     // }
//     List<String> slots = timeSlots.map((e) => e.toString()).toList();
//
//
//     switch (type) {
//       case SelectionType.date:
//         return DatePickWidget(
//           holidays: data.closedDates,
//           slots: slots,
//           onNextClick: () {
//             ref.read(selectionProvider.notifier).state = SelectionType.guest;
//           },
//         );
//       // case SelectionType.drinks:
//       //   return AddDrinks(drinks: data.drinks,);
//       // case SelectionType.smokes:
//       //   return AddSmokes(smokes: data.smokes,);
//       case SelectionType.guest:
//       // return AddGuestsDetails(
//       //   showTablePreference: true,
//       //   data: clubData.data,
//       //   onNextClick: (guests) {
//       //     ref.read(bookingProvider.notifier).bookTable(guests);
//       //   },
//       //   onBackClick: () {
//       //     ref.read(selectionProvider.notifier).state = SelectionType.date;
//       //   },
//       // );
//
//       default:
//         return DatePickWidget(
//           holidays: data.closedDates,
//           slots: slots,
//           onNextClick: () {
//             ref.read(selectionProvider.notifier).state = SelectionType.drinks;
//           },
//         );
//     }
//   }
// }
