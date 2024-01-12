// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:htp_customer/features/booking/controllers/booking_controller.dart';
// import 'package:htp_customer/features/booking/presentation/pages/confirmation/confirm_ticket.dart';
// import 'package:htp_customer/features/booking/presentation/widgets/guest_detail_box.dart';
// import 'package:htp_customer/common/widgets_common/rounded_golden_button.dart';
// import 'package:htp_customer/features/event/controllers/guest_controller_event.dart';

// import '../../../../common/widgets_common/add_people_form_new.dart';
// import '../../../../common/widgets_common/info_box.dart';
// import '../../../booking/controllers/selection/guests_controller.dart';
// import '../../../booking/data/models/guest_model.dart';

// class AddGuestsEvent extends ConsumerWidget {
//   AddGuestsEvent({super.key});

//   // final GlobalKey<AddingPeopleNewState> _key = GlobalKey();

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // final guestController = ref.watch(guestAddProviderEvent);
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
//       margin: const EdgeInsets.only(top: 8),
//       decoration: BoxDecoration(
//           color: Colors.black, borderRadius: BorderRadius.circular(12)),
//       child: Column(
//         children: [
//           // _infoBox(), //Display title to add guest
//           const InfoBox(
//             text1: "Add people to event",
//             /* text2: "Add upto 3 persons as per membership benefits", */ showGuestInfo:
//                 true,
//           ),

//           const SizedBox(
//             height: 12,
//           ),

//           // if (guestController.isNotEmpty)
//           //   for (int i = 0; i < guestController.length; i++)
//           //     GuestDetailBox(
//           //       name: guestController[i].name,
//           //       age: guestController[i].age,
//           //       count: i + 1,
//           //       deleteClick: (){
//           //         ref.read(guestAddProviderEvent.notifier).removeGuest(guestController[i].id);
//           //       },
//           //     ),

//           Consumer(builder: (context, ref, _) {
//             final editList = ref.watch(guestEditProvider);
//             return AddingPeopleNew(
//               // key: _guestListKye,
//               editGuestList: editList,
//               onAddGuestClick: () {
//                 ref.read(guestEditProvider.notifier).addGuest();
//               },
//               onDeleteItem: ref.read(guestEditProvider.notifier).removeGuest,
//               formKey: ref.read(guestEditProvider.notifier).formKey,
//             );
//           }),

//           const SizedBox(
//             height: 12,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               GestureDetector(
//                   onTap: () {
//                     //BACK BUTTON IMPLEMENTATION
//                     Navigator.pop(context);
//                   },
//                   child: const Text('BACK')),
//               const SizedBox(
//                 width: 24,
//               ),
//               SizedBox(
//                   width: 160,
//                   height: 44,
//                   child: Consumer(
//                     builder: (context, ref, _) {
//                       final bookingController = ref.watch(bookingProvider);

//                       ref.listen(bookingProvider, (previous, next) {
//                         if (next is BookingSuccess) {
//                           // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ConfirmTicket(id: next.bookingId,)), (route) => route.isFirst);
//                           // Navigator.push(
//                           //     context,
//                           //     MaterialPageRoute(
//                           //         builder: (_) => ConfirmTicket(
//                           //           id: next.bookingId, bookingType: next.bookingType,),
//                           //         fullscreenDialog: true))
//                           //     .then((_) {
//                           //   Navigator.pop(context);
//                           //   Navigator.maybePop(context);
//                           // });

//                           Navigator.pushNamed(context, ConfirmTicket.route,
//                                   arguments: TicketValue(
//                                       next.bookingId, next.bookingType))
//                               .then((value) {
//                             Navigator.pop(context);
//                             Navigator.maybePop(context);
//                           });
//                         }

//                         if (next is BookingError) {
//                           ScaffoldMessenger.of(context)
//                               .showSnackBar(SnackBar(content: Text(next.msg)));
//                         }
//                       });

//                       if (bookingController is BookingLoading) {
//                         return const Center(
//                           child: CircularProgressIndicator(),
//                         );
//                       }

//                       return RoundedGoldenButton(
//                           onTap: () {
//                             try {
//                               final guests = ref
//                                   .read(guestEditProvider.notifier)
//                                   .getGuestList();
//                               ref
//                                   .read(bookingProvider.notifier)
//                                   .bookEvent(guests);
//                             } catch (e) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                   SnackBar(content: Text(e.toString())));
//                             }

//                             // Navigator.push(
//                             //     context,
//                             //     MaterialPageRoute(
//                             //         builder: (_) => ConfirmTicket(
//                             //           id: '9fc09c85-3f9a-4a98-83a6-7f336b997ef8', eventBooking: true,),
//                             //         fullscreenDialog: true));
//                           },
//                           text: 'NEXT');
//                     },
//                   ))
//             ],
//           )
//         ],
//       ),
//     );
//   }

//   // Widget _infoBox() {
//   //   return Column(
//   //     crossAxisAlignment: CrossAxisAlignment.start,
//   //     children: [
//   //       const Text(
//   //         "Add people to event",
//   //         style: TextStyle(
//   //             fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
//   //       ),
//   //       const SizedBox(
//   //         height: 4,
//   //       ),
//   //       Row(
//   //         children: [
//   //           Icon(
//   //             Icons.info,
//   //             size: 14,
//   //             color: Colors.grey.shade500.withOpacity(0.5),
//   //           ),
//   //           const SizedBox(
//   //             width: 6,
//   //           ),
//   //           Text(
//   //             "Add upto 3 persons as per membership benefits",
//   //             softWrap: true,
//   //             style: TextStyle(
//   //                 fontSize: 12, color: Colors.grey.shade500.withOpacity(0.6)),
//   //           ),
//   //         ],
//   //       ),
//   //     ],
//   //   );
//   // }
// }

// // final formCountProvider = StateProvider.autoDispose<int>((ref) => 1);


// //
// // class AddingPeople extends ConsumerWidget {
// //   AddingPeople({super.key});
// //
// //   final TextEditingController nameController = TextEditingController();
// //   final TextEditingController ageController = TextEditingController();
// //   final _formKey = GlobalKey<FormState>();
// //
// //   void _savePeople(WidgetRef ref) {
// //     if (_formKey.currentState?.validate() ?? false) {
// //       ref
// //           .read(guestAddProviderEvent.notifier)
// //           .addGuest(nameController.text, ageController.text);
// //       ref.read(showAddGuestBox.notifier).state = false;
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context, WidgetRef ref) {
// //     final showForm = ref.watch(showAddGuestBox);
// //     if (!showForm) {
// //       return AddMoreGuests(
// //         onTap: (){
// //           ref.read(showAddGuestBox.notifier).state = true;
// //         },
// //       );
// //     }
// //     return Container(
// //         padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
// //         decoration: BoxDecoration(
// //           // color: Colors.white,
// //             color: Colors.white.withOpacity(0.08),
// //             borderRadius: BorderRadius.circular(12)),
// //         child: Form(
// //           key: _formKey,
// //           child: Column(
// //             children: [
// //               // const Align(
// //               //   alignment: Alignment.centerLeft,
// //               //   child: Text(
// //               //     "Guest ",
// //               //     style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
// //               //   ),
// //               // ),
// //
// //               Row(
// //                 children: [
// //                   Text(
// //                     "Guest ",
// //                     style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
// //                   ),
// //                   const Spacer(),
// //                   IconButton(
// //                       onPressed: () {
// //                         _savePeople(ref);
// //                         FocusManager.instance.primaryFocus?.unfocus();
// //                       },
// //                       icon: Icon(
// //                         Icons.add_circle,
// //                         color: Colors.white,
// //                       ))
// //                 ],
// //               ),
// //
// //               TextFormField(
// //                 controller: nameController,
// //                 textInputAction: TextInputAction.next,
// //                 validator: (value) {
// //                   if (value == null || value.isEmpty) {
// //                     return 'Name required';
// //                   }
// //                   return null;
// //                 },
// //                 decoration: const InputDecoration(
// //                   hintText: "Enter guest name",
// //                   hintStyle: TextStyle(
// //                     fontSize: 14,
// //                     color: Color.fromARGB(255, 170, 170, 170),
// //                   ),
// //                   enabledBorder: UnderlineInputBorder(
// //                       borderSide: BorderSide(
// //                           color: Color.fromARGB(255, 233, 233, 233))),
// //                 ),
// //               ),
// //
// //               const SizedBox(
// //                 height: 8,
// //               ),
// //
// //               TextFormField(
// //                 keyboardType: TextInputType.number,
// //                 textInputAction: TextInputAction.done,
// //                 onFieldSubmitted: (value) {
// //                   _savePeople(ref);
// //                 },
// //                 controller: ageController,
// //                 validator: (value) {
// //                   if (value == null || value.isEmpty) {
// //                     return 'Age required';
// //                   } else {
// //                     final age = int.tryParse(value);
// //                     if (age == null) {
// //                       return 'Enter a valid age';
// //                     } else {
// //                       if (age >= 18) {
// //                         return null;
// //                       } else {
// //                         return 'Age should be above 18';
// //                       }
// //                     }
// //                   }
// //                   return null;
// //                 },
// //                 decoration: const InputDecoration(
// //                   hintText: "Enter age",
// //                   hintStyle: TextStyle(
// //                     fontSize: 14,
// //                     color: Color.fromARGB(255, 170, 170, 170),
// //                   ),
// //                   enabledBorder: UnderlineInputBorder(
// //                       borderSide: BorderSide(
// //                           color: Color.fromARGB(255, 233, 233, 233))),
// //                 ),
// //               ),
// //
// //               const SizedBox(
// //                 height: 20,
// //               ),
// //             ],
// //           ),
// //         ));
// //   }
// // }
