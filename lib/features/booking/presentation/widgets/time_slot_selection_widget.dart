// import 'package:flutter/material.dart';

// import '../../../../common/widgets_common/custom_radio.dart';

// class TimeSlotSelectionWidget extends StatelessWidget {
//   final List<String> slots;
//   final String? selectedSlot;
//   final Function(String) onSelection;
//   const TimeSlotSelectionWidget(
//       {Key? key,
//       required this.slots,
//       this.selectedSlot,
//       required this.onSelection})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Padding(
//           padding: EdgeInsets.fromLTRB(0, 22, 0, 12),
//           child: Text('Select an entry slot'),
//         ),
//         const SizedBox(
//           height: 6,
//         ),
//         Wrap(
//           runSpacing: 22,
//           alignment: WrapAlignment.start,
//           children: [
//             ...slots.map((e) => SizedBox(
//                   width: 106,
//                   child: RadioWithTitle(
//                     onTap: (val) {
//                       onSelection(e);
//                     },
//                     selected: e == selectedSlot,
//                     title: e.toUpperCase(),
//                   ),
//                 )),
//           ],
//         )
//       ],
//     );
//   }
// }
