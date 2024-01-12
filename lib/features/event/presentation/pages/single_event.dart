// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:htp_customer/features/dashboard/presentation/widgets/custom_app_bar.dart';
// import 'package:htp_customer/features/event/presentation/widget/eventconfirm.dart';
// import 'package:htp_customer/features/event/presentation/widget/termsandconditions.dart';
// import 'package:htp_customer/htp_theme.dart';
// import '../../../booking/controllers/selection/drinks_controller.dart';
// import '../../../booking/presentation/widgets/expansion_selection_list.dart';
//
// class SingleEventDetails extends StatelessWidget {
//   static const route = '/single-event-details';
//   // final String imagePath;
//   SingleEventDetails({
//     super.key,
//     // required this.imagePath
//   });
//
//   GlobalKey dropdownButtonKey1 = GlobalKey();
//   GlobalKey dropdownButtonKey2 = GlobalKey();
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: const CustomAppBar(
//           height: 20,
//         ),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.only(/* top: 120.0, */ left: 12),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding:
//                       const EdgeInsets.only(bottom: 8.0, left: 12, top: 32),
//                   child: Text(
//                     "Booking",
//                     style: HtpTheme
//                         .newTitleTextStyle /* TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontFamily: "Allrox",
//                         fontSize: 16,
//                         color: Colors.white )*/
//                     ,
//                   ),
//                 ),
//                 const SingelEvent(
//                     imageName: "party.jpg",
//                     eventTitle: "Event / party name here",
//                     date: "04 April 2023",
//                     place: "Razzle Dazzle"),
//
//
//                 // SingleChildScrollView(
//                 //   child: Container(
//                 //     padding: const EdgeInsets.all(16),
//                 //     margin: const EdgeInsets.all(12),
//                 //     // width: double.infinity,
//                 //     decoration: BoxDecoration(
//                 //         // color: Colors.white,
//                 //         color: HtpTheme.cardBlackColor,
//                 //         borderRadius: BorderRadius.circular(8)),
//                 //     child: Column(
//                 //       crossAxisAlignment: CrossAxisAlignment.start,
//                 //       children: [
//                 //         const SizedBox(
//                 //           height: 8,
//                 //         ),
//                 //         Consumer(builder: (context, ref, _) {
//                 //           final drinks = ref.watch(drinksProvider);
//                 //           return ExpansionSelectionList(
//                 //             title: "Preferred Drinks",
//                 //             subtitle: "Add upto any number of drinks.",
//                 //             selectedDrinks: drinks,
//                 //             select: ref.read(drinksProvider.notifier).addDrink,
//                 //             deSelect:
//                 //                 ref.read(drinksProvider.notifier).removeDrink,
//                 //           );
//                 //         }),
//                 //         Consumer(builder: (context, ref, _) {
//                 //           final drinks = ref.watch(drinksProvider);
//                 //           return ExpansionSelectionList(
//                 //             title: "Preferred Smoke",
//                 //             subtitle: "Add upto any number of smoke.",
//                 //             selectedDrinks: drinks,
//                 //             select: ref.read(drinksProvider.notifier).addDrink,
//                 //             deSelect:
//                 //                 ref.read(drinksProvider.notifier).removeDrink,
//                 //           );
//                 //         }),
//                 //         // SingleEventRow(
//                 //         //   title: "Preferred Drinks",
//                 //         //   subtitle: "Add upto any number of drinks",
//                 //         //   dropKey: dropdownButtonKey1,
//                 //         // ),
//                 //         // SingleEventRow(
//                 //         //     title: "Preferred Smoke",
//                 //         //     dropKey: dropdownButtonKey2,
//                 //         //     subtitle: "Add upto any number"),
//                 //         const SizedBox(
//                 //           height: 14,
//                 //         ),
//                 //         TermsConditions(),
//                 //         Row(
//                 //           children: [
//                 //             Expanded(
//                 //               child: GestureDetector(
//                 //                 onTap: () {
//                 //                   Navigator.push(
//                 //                       context,
//                 //                       MaterialPageRoute(
//                 //                           builder: (context) =>
//                 //                               EventConfirm()));
//                 //
//                 //                   // arguments: <String, dynamic>{
//                 //                   //   "imagePath": images[0]
//                 //                   // }
//                 //                   // );
//                 //                 },
//                 //                 child: Container(
//                 //                   decoration: BoxDecoration(
//                 //                       borderRadius: BorderRadius.circular(25),
//                 //                       gradient: const LinearGradient(
//                 //                         colors: <Color>[
//                 //                           Color.fromARGB(255, 250, 241, 160),
//                 //                           Color.fromARGB(255, 226, 209, 53)
//                 //                         ],
//                 //                       )),
//                 //                   child: const Padding(
//                 //                     padding: EdgeInsets.all(12.0),
//                 //                     child: Center(
//                 //                         child: Text(
//                 //                       "CONFIRM BOOKING",
//                 //                       style: TextStyle(
//                 //                           fontSize: 14,
//                 //                           color: HtpTheme.blackColor,
//                 //                           fontWeight: FontWeight.bold),
//                 //                     )),
//                 //                   ),
//                 //                 ),
//                 //               ),
//                 //             ),
//                 //           ],
//                 //         ),
//                 //       ],
//                 //     ),
//                 //   ),
//                 // ),
//
//
//                 SizedBox(
//                   height: 50,
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
// //
// // class SingleEventRow extends StatefulWidget {
// //   final String title;
// //   final String subtitle;
// //   final Widget? extra;
// //   final GlobalKey dropKey;
// //   SingleEventRow(
// //       {Key? key,
// //       required this.title,
// //       required this.subtitle,
// //       this.extra,
// //       required this.dropKey})
// //       : super(key: key);
// //
// //   @override
// //   State<SingleEventRow> createState() => _SingleEventRowState();
// // }
// //
// // class _SingleEventRowState extends State<SingleEventRow> {
// //   List drinks = ["Brandy", "Whiskey", "Vodka", "Cognac"];
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(vertical: 8.0),
// //       child:
// //           //  Row(
// //           //   mainAxisAlignment: MainAxisAlignment.start,
// //           //   crossAxisAlignment: CrossAxisAlignment.start,
// //           //   mainAxisSize: MainAxisSize.min,
// //           //   children: [
// //
// //           Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         mainAxisAlignment: MainAxisAlignment.start,
// //         mainAxisSize: MainAxisSize.min,
// //         children: [
// //           Row(
// //             children: [
// //               Text(
// //                 widget.title,
// //                 style:
// //                     const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
// //               ),
// //               Spacer(),
// //               DropdownButton<int>(
// //                 icon: const Image(
// //                     width: 28,
// //                     height: 28,
// //                     image: AssetImage("assets/images/icons/add-more.png")),
// //                 key: widget.dropKey,
// //                 // isExpanded: true,
// //                 items: [
// //                   DropdownMenuItem(value: 1, child: Text(drinks[0])),
// //                   DropdownMenuItem(value: 2, child: Text(drinks[1])),
// //                   DropdownMenuItem(value: 3, child: Text(drinks[2])),
// //                   DropdownMenuItem(value: 3, child: Text(drinks[3])),
// //                 ],
// //                 onChanged: (value) {
// //                   debugPrint("$value");
// //                 },
// //               ),
// //             ],
// //           ),
// //           Row(
// //             children: [
// //               Padding(
// //                 padding: const EdgeInsets.only(top: 4.0, right: 6),
// //                 child: Image(
// //                   image: AssetImage("assets/images/icons/help-circle.png"),
// //                   height: 16,
// //                 ),
// //               ),
// //               Text(widget.subtitle),
// //             ],
// //           ),
// //           if (widget.extra != null) widget.extra!,
// //         ],
// //       ),
// //     );
// //   }
// // }
