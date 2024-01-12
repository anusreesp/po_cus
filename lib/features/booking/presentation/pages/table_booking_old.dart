// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:htp_customer/features/booking/presentation/widgets/club_details.dart';
// import 'package:htp_customer/features/clubs/data/models/fire_club_details.dart';
// import 'package:htp_customer/features/dashboard/presentation/widgets/custom_app_bar.dart';
// import 'package:htp_customer/htp_theme.dart';
// // import 'package:htp_customer/sample_data.dart' as sample;
// // import '../../../clubs/data/models/club_list_response.dart';
// import '../../controllers/selection/table_selection_controller.dart';
// import 'booking_table/booking_table.dart';

// class TableBookingPage extends ConsumerWidget {
//   static const route = '/table-booking-page';
//   final ClubDataModel data;
//   const TableBookingPage({Key? key, required this.data}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // final data = ModalRoute.of(context)?.settings.arguments as ClubDetailData;
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       ref.read(clubTableProvider.notifier).setTable(data.sittingTables);
//     });
//     return Scaffold(
//       appBar: CustomAppBar(
//         child: Text(
//           "Book your table",
//           style: HtpTheme.newTitleTextStyle,
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           // padding: const EdgeInsets.only(/*top: 120.0, */ left: 12),
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               ///Club details area
//               // Padding(
//               //   padding: const EdgeInsets.only(left: 8.0, bottom: 12),
//               //   child: Text(
//               //     "Book your table",
//               //     style: HtpTheme.newTitleTextStyle,
//               //   ),
//               // ),

//               Row(
//                 // mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Expanded(
//                       child: ClipRRect(
//                     borderRadius: BorderRadius.circular(8),
//                     child: data.displayImage == null
//                         ? const Image(
//                             image: AssetImage(
//                               'assets/images/placeholders/placeholder_15.png',
//                             ),
//                             height: 120,
//                             fit: BoxFit.cover,
//                           )
//                         : Image.network(
//                             data.displayImage!,
//                             height: 120,
//                             fit: BoxFit.cover,
//                           ),
//                   )),
//                   const SizedBox(
//                     width: 12,
//                   ),
//                   Expanded(
//                       child: ClubDetails(
//                     data: data,
//                   )),
//                 ],
//               ),

//               ///Selection area
//               const Padding(
//                 padding: EdgeInsets.only(
//                   top: 18.0,
//                 ),
//                 child: Text(
//                   "Let's get ready to rock !",
//                   style: TextStyle(
//                       fontSize: 17,
//                       color: Colors.white,
//                       fontWeight: FontWeight.w500),
//                 ),
//               ),

//               BookingTableSelectionButtons(
//                 data: data,
//               ),
//               TableData(
//                 data: data,
//               ),

//               const SizedBox(
//                 height: 80,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
