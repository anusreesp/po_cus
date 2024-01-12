import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/common/widgets_common/add_people_form_new.dart';
import 'package:htp_customer/common/widgets_common/custom_radio.dart';
import 'package:htp_customer/features/booking/controllers/booking_controller.dart';
import 'package:htp_customer/features/booking/controllers/selection/guests_controller.dart';
import 'package:htp_customer/features/booking/data/models/guest_model.dart';
import 'package:htp_customer/common/widgets_common/rounded_golden_button.dart';
import 'package:htp_customer/features/clubs/data/models/fire_club_details.dart';
import '../../../../../common/widgets_common/info_box.dart';
import '../../../../../htp_theme.dart';
import '../../../controllers/entryconfirmation_controller.dart';
import '../../../controllers/selection/table_selection_controller.dart';
import '../confirmation/entry_confirmation.dart';

class AddGuestsNew extends StatelessWidget {
  final Function(List<GuestModel>) onNextClick;
  final VoidCallback onBackClick;
  final bool showTablePreference;
  AddGuestsNew(
      {Key? key,
      required this.onBackClick,
      required this.onNextClick,
      this.showTablePreference = false})
      : super(key: key);

  // final GlobalKey<AddingPeopleNewState> _guestListKye = GlobalKey();

  // final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          // horizontal: 18,
          vertical: 18),
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          const InfoBox(
            text1: "Add People To Party",
            /* text2: "Add upto 3 persons as per membership benefits", */ showGuestInfo:
                true,
          ),
          const SizedBox(
            height: 12,
          ),
          Consumer(builder: (context, ref, _) {
            final editList = ref.watch(guestEditProvider);
            return AddingPeopleNew(
              // key: _guestListKye,
              editGuestList: editList,
              onAddGuestClick: () {
                ref.read(guestEditProvider.notifier).addGuest();
                // ref.read(clubTableProvider.notifier).updateTableWithCount(editList.length);
                // ref.read(clubTableProvider.notifier).updateTableWithCount(editList.length);
              },
              // onDeleteItem: ref.read(guestEditProvider.notifier).removeGuest,
              onDeleteItem: (id) {
                ref.read(guestEditProvider.notifier).removeGuest(id);
                // ref.read(clubTableProvider.notifier).updateTableWithCount(editList.length);
              },
              formKey: ref.read(guestEditProvider.notifier).formKey,
            );
          }),
          const SizedBox(
            height: 20,
          ),
          if (showTablePreference) const PreferredTableSelection(),
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                  onTap: () {
                    onBackClick();
                  },
                  child: const Text('BACK')),
              const SizedBox(
                width: 24,
              ),
              SizedBox(
                  width: 160,
                  height: 44,
                  child: Consumer(
                    builder: (context, ref, _) {
                      final bookingController = ref.watch(bookingProvider);

                      ref.listen(bookingProvider, (previous, next) {
                        if (next is BookingSuccess) {
                          // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ConfirmTicket(id: next.bookingId,)), (route) => route.isFirst);
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (_) => ConfirmTicket(
                          //             id: next.bookingId, bookingType: next.bookingType,),
                          //         fullscreenDialog: true))
                          //     .then((_) {
                          //   Navigator.pop(context);
                          //   Navigator.maybePop(context);
                          // });

                          // Navigator.pushNamed(context, ConfirmTicket.route,
                          //         arguments: TicketValue(
                          //             next.bookingId, next.bookingType))

                          // ref.read(uniqueIdProvider.notifier).state =
                          //     next.bookingId;
                          // ref.read(bookingTypeProvider.notifier).state =
                          //     next.bookingType;
                          FirebaseAnalytics.instance.logEvent(
                              name: 'entry_booking',
                              parameters: <String, dynamic>{
                                "bookingType": next.bookingType,
                                "id": next.bookingId,
                              });

                          Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EntryConfirmation(
                                          id: next.bookingId,
                                          bookingType: next.bookingType)))
                              .then((value) {
                            Navigator.pop(context);
                            Navigator.maybePop(context);
                          });
                        }

                        if (next is BookingError) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text(next.msg)));
                        }
                      });

                      if (bookingController is BookingLoading) {
                        return const Center(
                          child: CircularProgressIndicator(color: HtpTheme.goldenColor),
                        );
                      }

                      return RoundedGoldenButton(
                          onTap: () {
                            try {
                              // final guestList = _guestListKye.currentState!.getAllGuest();
                              // onNextClick(guestList);
                              try {
                                final guests = ref
                                    .read(guestEditProvider.notifier)
                                    .getGuestList();
                                onNextClick(guests);
                              } catch (e) {
                                _showMessage(context, e.toString());
                              }
                            } catch (_) {
                              //handle guest list error
                            }
                            // ref.read(selectionProvider.notifier).state =
                            //     SelectionType.smokes;
                          },
                          text: 'Next');
                    },
                  ))
            ],
          )
        ],
      ),
    );
  }

  _showMessage(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}

class PreferredTableSelection extends ConsumerWidget {
  const PreferredTableSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(clubTableProvider);
    final tableController = ref.watch(selectedTableProvider);
    return controller.isNotEmpty
        ? Container(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                const InfoBox(
                  text1:
                      'Preferred table', /* text2: 'Select a table type as per your need' */
                ),
                const SizedBox(
                  height: 18,
                ),
                ...controller.map((table) => PreferredRadio(
                      table: table,
                      isSelected: table.name == tableController,
                      onTap: () {
                        ref.read(clubTableProvider.notifier).selectTable(table);
                      },
                    ))
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}

class PreferredRadio extends StatelessWidget {
  final SittingTable table;
  final VoidCallback onTap;
  final bool isSelected;
  const PreferredRadio(
      {Key? key,
      required this.table,
      required this.onTap,
      this.isSelected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomRadio(
              onTap: (val) {
                onTap();
              },
              selected: isSelected,
            ),
            const SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  table.name,
                  style: const TextStyle(fontSize: 12),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  'Min. spent USD \$${table.minimumSpent}',
                  style: const TextStyle(fontSize: 10, color: Colors.white38),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}






//
// class AddGuests extends ConsumerWidget {
//   final VoidCallback onNextClick;
//   final VoidCallback onBackClick;
//   const AddGuests({super.key, required this.onNextClick, required this.onBackClick});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // final addNewGuestsProvider = ref.watch(addGuestProvider);
//     final guestController = ref.watch(guestAddProvider);
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
//       margin: const EdgeInsets.only(top: 8),
//       decoration: BoxDecoration(
//           color: Colors.black, borderRadius: BorderRadius.circular(12)),
//       child: Column(
//         children: [
//           _infoBox(),
//           const SizedBox(
//             height: 12,
//           ),
//           if (guestController.isNotEmpty)
//             for (int i = 0; i < guestController.length; i++)
//               GuestDetailBox(
//                 name: guestController[i].name,
//                 age: guestController[i].age,
//                 count: i + 1,
//                 deleteClick: (){
//                   ref.read(guestAddProvider.notifier).removeGuest(guestController[i].id);
//                 },
//               ),
//           AddingPeople(),
//           const SizedBox(
//             height: 12,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               GestureDetector(
//                   onTap: () {
//                     onBackClick();
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
//
//                       ref.listen(bookingProvider, (previous, next) {
//                         if (next is BookingSuccess) {
//                           // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ConfirmTicket(id: next.bookingId,)), (route) => route.isFirst);
//                           Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (_) => ConfirmTicket(
//                                           id: next.bookingId),
//                                       fullscreenDialog: true))
//                               .then((_) {
//                             Navigator.pop(context);
//                             Navigator.maybePop(context);
//                           });
//                         }
//
//                         if (next is BookingError) {
//                           ScaffoldMessenger.of(context)
//                               .showSnackBar(SnackBar(content: Text(next.msg)));
//                         }
//                       });
//
//                       if (bookingController is BookingLoading) {
//                         return const Center(
//                           child: CircularProgressIndicator(),
//                         );
//                       }
//
//                       return RoundedGoldenButton(
//                           onTap: () {
//                             onNextClick();
//                             // ref.read(selectionProvider.notifier).state =
//                             //     SelectionType.smokes;
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
//
//   Widget _infoBox() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           "Add People To Party",
//           style: TextStyle(
//               fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(
//           height: 4,
//         ),
//         Row(
//           children: [
//             Icon(
//               Icons.info,
//               size: 14,
//               color: Colors.grey.shade500.withOpacity(0.5),
//             ),
//             const SizedBox(
//               width: 6,
//             ),
//             Text(
//               "Add upto 3 person as per membership benefits",
//               softWrap: true,
//               style: TextStyle(
//                   fontSize: 12, color: Colors.grey.shade500.withOpacity(0.6)),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
//
// class AddingPeople extends ConsumerWidget {
//   AddingPeople({super.key});
//
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController ageController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//
//   void _savePeople(WidgetRef ref) {
//     if (_formKey.currentState?.validate() ?? false) {
//       ref
//           .read(guestAddProvider.notifier)
//           .addGuest(nameController.text, ageController.text);
//       ref.read(showAddGuestBox.notifier).state = false;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final showForm = ref.watch(showAddGuestBox);
//     if (!showForm) {
//       return AddMoreGuests(
//         onTap: (){
//           ref.read(showAddGuestBox.notifier).state = true;
//         },
//       );
//     }
//     return Container(
//         padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
//         decoration: BoxDecoration(
//             // color: Colors.white,
//             color: Colors.white.withOpacity(0.08),
//             borderRadius: BorderRadius.circular(12)),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               // const Align(
//               //   alignment: Alignment.centerLeft,
//               //   child: Text(
//               //     "Guest ",
//               //     style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
//               //   ),
//               // ),
//
//               Row(
//                 children: [
//                   Text(
//                     "Guest ",
//                     style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
//                   ),
//                   const Spacer(),
//                   IconButton(
//                       onPressed: () {
//                         _savePeople(ref);
//                         FocusManager.instance.primaryFocus?.unfocus();
//                       },
//                       icon: Icon(
//                         Icons.add_circle,
//                         color: Colors.white,
//                       ))
//                 ],
//               ),
//
//               TextFormField(
//                 controller: nameController,
//                 textInputAction: TextInputAction.next,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Name required';
//                   }
//                   return null;
//                 },
//                 decoration: const InputDecoration(
//                   hintText: "Enter guest name",
//                   hintStyle: TextStyle(
//                     fontSize: 14,
//                     color: Color.fromARGB(255, 170, 170, 170),
//                   ),
//                   enabledBorder: UnderlineInputBorder(
//                       borderSide: BorderSide(
//                           color: Color.fromARGB(255, 233, 233, 233))),
//                 ),
//               ),
//
//               const SizedBox(
//                 height: 8,
//               ),
//
//               TextFormField(
//                 keyboardType: TextInputType.number,
//                 textInputAction: TextInputAction.done,
//                 onFieldSubmitted: (value) {
//                   _savePeople(ref);
//                 },
//                 controller: ageController,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Age required';
//                   } else {
//                     final age = int.tryParse(value);
//                     if (age == null) {
//                       return 'Enter a valid age';
//                     } else {
//                       if (age >= 18) {
//                         return null;
//                       } else {
//                         return 'Age should be above 18';
//                       }
//                     }
//                   }
//                   return null;
//                 },
//                 decoration: const InputDecoration(
//                   hintText: "Enter age",
//                   hintStyle: TextStyle(
//                     fontSize: 14,
//                     color: Color.fromARGB(255, 170, 170, 170),
//                   ),
//                   enabledBorder: UnderlineInputBorder(
//                       borderSide: BorderSide(
//                           color: Color.fromARGB(255, 233, 233, 233))),
//                 ),
//               ),
//
//               const SizedBox(
//                 height: 20,
//               ),
//             ],
//           ),
//         ));
//   }
// }
