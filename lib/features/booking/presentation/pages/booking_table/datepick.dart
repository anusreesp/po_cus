// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:htp_customer/common/utils/time_converter.dart';
// import 'package:htp_customer/common/widgets_common/custom_radio.dart';
// import 'package:htp_customer/features/booking/controllers/booking_selection_controller.dart';
// import 'package:htp_customer/features/booking/controllers/selection/date_controller.dart';
// import 'package:htp_customer/features/profile/controller/profile_controller.dart';
// import 'package:htp_customer/htp_theme.dart';
// import 'package:htp_customer/common/widgets_common/rounded_golden_button.dart';
// import 'package:intl/intl.dart';

// import '../../widgets/time_slot_selection_widget.dart';
// import '../../widgets/timeslot_selection.dart';

// class PickTheDate extends ConsumerWidget {
//   final List<DateTime> holidays;
//   final List<String> slots;
//   final VoidCallback onNextClick;
//   const PickTheDate(
//       {super.key,
//       required this.onNextClick,
//       required this.holidays,
//       required this.slots});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final slotPickController = ref.watch(slotPickProvider);

//     return Padding(
//       padding: const EdgeInsets.only(top: 8),
//       child: Container(
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//             color:
//                 //  Colors.white,
//                 HtpTheme.cardBlackColor,
//             borderRadius: BorderRadius.circular(12)),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 "Date",
//                 style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
//               ),
//             ),
//             DatePickField(
//               holidays: holidays,
//             ),
//             TimeSlotSelection(
//               // slots: slots.map((e) => e.format(context)).toList(),
//               slots: slots,
//               onSelection: (value) {
//                 ref.read(slotPickProvider.notifier).state = value;
//               },
//               selectedSlot: slotPickController,
//             ),
//             const SizedBox(
//               height: 32,
//             ),
//             Consumer(
//               builder: (context, ref, _) {
//                 final datePickController = ref.watch(datePickProvider);
//                 // final datetickProvider = ref.watch(dateDonetickProvider);

//                 return Padding(
//                     padding: const EdgeInsets.symmetric(),
//                     child:
//                         datePickController != null && slotPickController != null
//                             ? RoundedGoldenButton(
//                                 height: 44,
//                                 onTap: onNextClick,
//                                 text: "NEXT",
//                               )
//                             : RoundedGoldenButton(
//                                 height: 44,
//                                 onTap: () {},
//                                 text: 'NEXT',
//                                 isActive: false,
//                               ));
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// class DatePickField extends ConsumerWidget {
//   final List<DateTime> holidays;
//   DatePickField({Key? key, required this.holidays}) : super(key: key);

//   final TextEditingController _controller = TextEditingController();

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final dateController = ref.watch(datePickProvider);
//     final profileController = ref.watch(profileControllerProvider);
//     if (dateController != null) {
//       _controller.text = DateFormat('dd MMMM yyyy').format(dateController);
//     }
//     return TextField(
//       controller: _controller,
//       readOnly: true,
//       onTap: () {
//         if (profileController is ProfileLoaded) {
//           pickData(
//               context,
//               ref,
//               holidays,
//               profileController.activeMembershipData.membershipCalculations!
//                   .tableBookingUpToHours);
//         }
//       },
//       decoration: InputDecoration(
//           hintText: "DD/MM/YYYY",
//           hintStyle: TextStyle(fontSize: 14, color: Colors.grey.shade500),
//           border: const UnderlineInputBorder(
//               borderSide: BorderSide(color: HtpTheme.goldenColor)),
//           focusedBorder: const UnderlineInputBorder(
//               borderSide: BorderSide(color: HtpTheme.goldenColor)),
//           disabledBorder: const UnderlineInputBorder(
//               borderSide: BorderSide(color: HtpTheme.goldenColor)),
//           enabledBorder: const UnderlineInputBorder(
//               borderSide:
//                   BorderSide(color: Color.fromARGB(255, 233, 233, 233))),
//           suffixIcon: IconButton(
//             icon: const Icon(
//               Icons.calendar_today_outlined,
//               color: HtpTheme.goldenColor,
//             ),
//             onPressed: () async {
//               if (profileController is ProfileLoaded) {
//                 pickData(
//                     context,
//                     ref,
//                     holidays,
//                     profileController.activeMembershipData
//                         .membershipCalculations!.tableBookingUpToHours);
//               }
//             },
//           )),
//     );
//   }

//   pickData(BuildContext context, WidgetRef ref, List<DateTime> holidays,
//       int bookBlockHour) async {
//     final List<String> stringHolidays = holidays
//         .map((e) => DateTime(e.year, e.month, e.day).toIso8601String())
//         .toList();
//     DateTime allowedBookDate =
//         DateTime.now().add(Duration(hours: bookBlockHour));

//     while (stringHolidays.contains(DateTime(
//             allowedBookDate.year, allowedBookDate.month, allowedBookDate.day)
//         .toIso8601String())) {
//       allowedBookDate = allowedBookDate.add(const Duration(days: 1));
//     }

//     final dateTime = await showDatePicker(
//         context: context,
//         initialDate: allowedBookDate,
//         firstDate: allowedBookDate,
//         lastDate: DateTime.now().add(const Duration(days: 30)),
//         selectableDayPredicate: (DateTime val) {
//           final stringDate =
//               DateTime(val.year, val.month, val.day).toIso8601String();
//           if (stringHolidays.contains(stringDate)) {
//             // print(stringDate);
//             return false;
//           }
//           // return val.weekday == 7 ? false : true;
//           return true;
//         });
//     if (dateTime != null) {
//       ref.read(datePickProvider.notifier).state = dateTime;
//     }
//   }
// }
