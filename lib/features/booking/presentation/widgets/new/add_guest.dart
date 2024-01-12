import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/common/widgets_common/custom_radio.dart';
import 'package:htp_customer/features/booking/controllers/selection/guests_controller.dart';
import 'package:htp_customer/features/booking/data/models/guest_model.dart';
import 'package:htp_customer/features/clubs/data/models/fire_club_details.dart';

import '../../../../../common/widgets_common/info_box.dart';
import '../../../controllers/selection/table_selection_controller.dart';
import 'add_guest_form.dart';

class AddGuestsDetails extends StatelessWidget {
  final ClubDataModel data;
  final Function(List<GuestModel>) onNextClick;
  final VoidCallback onBackClick;

  final bool showTablePreference;
  AddGuestsDetails(
      {Key? key,
      required this.onNextClick,
      required this.onBackClick,
      this.showTablePreference = false,
      required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          // horizontal: 18,
          vertical: 18),
      margin: const EdgeInsets.only(top: 8),
      child: Column(
        children: [
          const InfoBox(
            text1: "Bringing Friends?",
            showGuestInfo: true,
          ),
          Consumer(builder: (context, ref, _) {
            final editList = ref.watch(guestEditProvider);
            return AddingPeopleForm(
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
            height: 60,
          ),
          // if (showTablePreference) const PreferredTableSelection(),
          // const SizedBox(
          //   height: 12,
          // ),
          /* Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
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

                          Navigator.pushNamed(context, ConfirmTicket.route,
                                  arguments: TicketValue(
                                      next.bookingId, next.bookingType))
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
                          child: CircularProgressIndicator(),
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
                          text: 'NEXT');
                    },
                  ))
            ],
          ) */

          /* Consumer(builder: (context, ref, _) {
            final bookingController = ref.watch(bookingProvider);

            ref.listen(bookingProvider, (previous, next) {
              if (next is BookingSuccess) {
                debugPrint(next.bookingId);

                // Navigator.pushNamed(context, EntryConfirmation.route,
                //     arguments:
                //         ConfirmValue(next.bookingId, next.bookingType, data));

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EntryConfirmation(
                              bookingType: next.bookingType,
                              id: next.bookingId,
                              clubData: data,
                            )));
                // Navigator.pop(context);
                // Navigator.maybePop(context);
              }

              if (next is BookingError) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(next.msg)));
              }
            });

            if (bookingController is BookingLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return FloatingSubmitButton(
              onTap: () {
                try {
                  // final guestList = _guestListKye.currentState!.getAllGuest();
                  // onNextClick(guestList);
                  try {
                    final guests =
                        ref.read(guestEditProvider.notifier).getGuestList();
                    onNextClick(guests);
                  } catch (e) {
                    _showMessage(context, e.toString());
                  }
                } catch (_) {
                  //handle guest list error
                }
              },
              text: "Confirm Booking",
            );
          }) */
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
                  text1: 'Preferred table',
                  // text2: 'Select a table type as per your need'
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
