// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:htp_customer/features/clubs/controllers/club_filter_list_controller.dart';
// import 'package:htp_customer/features/clubs/controllers/club_list_controller.dart';

// import '../../../clubs/controllers/new/clubs_filterlist_controller.dart';

// class ClubFilter extends ConsumerWidget {
//   const ClubFilter({Key? key}) : super(key: key);

//   final _filters = const [
//     "Nearby",
//     "Popular",
//     "A - Z list",
//     "Z - A list",
//     "Open Now"
//   ];

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return PopupMenuButton(
//       iconSize: 60,
//       padding: const EdgeInsets.all(0),
//       onSelected: (index) {
//         ref
//             .read(clubsFilterListProvider.notifier)
//             .filterClubs(FilterEnum.values[index]);
//         // ref.read(clubListProvider.notifier).getClubs(FilterEnum.values[index]);
//       },
//       icon: Row(
//         children: const [
//           Image(
//             image: AssetImage('assets/images/icons/filter_icon.png'),
//             height: 16,
//           ),
//           SizedBox(
//             width: 6,
//           ),
//           Text(
//             "Sort",
//             style: TextStyle(fontSize: 14, color: Colors.white),
//           )
//         ],
//       ),
//       offset: const Offset(0, 40),
//       color: Colors.black87,
//       shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(16),
//               bottomLeft: Radius.circular(16),
//               bottomRight: Radius.circular(16))),
//       itemBuilder: (context) {
//         final selectedFilter =
//             ref.read(clubFilteredListProvider.notifier).selectedFilter;
//         return [
//           for (int index = 0; index < _filters.length; index++)
//             PopupMenuItem(
//                 value: index,
//                 child: Row(
//                   children: [
//                     Text(
//                       _filters[index],
//                       style: Theme.of(context).textTheme.bodyText1,
//                     ),
//                     const SizedBox(
//                       width: 4,
//                     ),
//                     if (selectedFilter?.index == index)
//                       Icon(
//                         Icons.check,
//                         size: 16,
//                       ),
//                   ],
//                 )),
//         ];
//       },
//     );
//   }
// }
