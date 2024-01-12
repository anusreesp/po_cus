import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/features/clubs/data/models/fire_club_details.dart';
import '../../../../common/utils/time_converter.dart';
import '../../../../common/widgets_common/app_bar_back_button.dart';
import '../../../../common/widgets_common/floatingSubmitButton.dart';
import '../../../../common/widgets_common/rounded_golden_button.dart';
import '../../../../htp_theme.dart';
import '../../../../shimmers/base_shimmer.dart';
import '../../../clubs/controllers/club_misc_data_controller.dart';
import '../../controllers/booking_controller.dart';
import '../../controllers/booking_selection_controller.dart';
import '../../controllers/entryconfirmation_controller.dart';
import '../../controllers/selection/date_controller.dart';
import '../../controllers/selection/guests_controller.dart';
import '../widgets/date_pick_widget.dart';
import '../widgets/new/add_guest.dart';
import '../widgets/new/club_basicdata.dart';
import '../widgets/new/topselection_button.dart';
import 'confirmation/entry_confirmation.dart';

class TableBookingPage extends StatelessWidget {
  static const route = '/table-booking-page';
  final ClubDataModel data;
  const TableBookingPage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   ref.read(clubTableProvider.notifier).setTable(data.sittingTables);
    // });

    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   onPressed: () => Navigator.pop(context),
        //   icon: SvgPicture.asset(
        //     "assets/svg/icons/arrow/sidearrow.svg",
        //     height: 12,
        //     width: 12,
        //   ),
        // ),
        leading: const AppbarBackButton(),
        title: Text("${data.name.toUpperCase()} - TABLE BOOKING "),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
          child: Consumer(
            builder: (context, ref, _) {
              final selectedTab = ref.watch(selectionProvider);
              final datePickerProvider = ref.watch(datePickProvider);
              final guestTickController = ref.watch(guestEditProvider);
              final timeselectionController = ref.watch(slotPickProvider);

              ref.read(bookingProvider.notifier).clubId = data.id;
              ref.read(bookingProvider.notifier).clubName = data.name;

              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClubBasicData(
                      data: data,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(children: [
                      //----------------------- TopSelectionButtonWidget --------------------------

                      //---Date Selection

                      Flexible(
                        flex: 1,
                        child: TopSelectionButtonWidget(
                            isSelected: selectedTab == SelectionType.date,
                            onTap: () {
                              ref.read(selectionProvider.notifier).state =
                                  SelectionType.date;
                            },
                            activeImage: "date.svg",
                            data: "Date",
                            inActiveImage: "date_gold.svg",
                            finished: datePickerProvider != null),
                      ),

                      const SizedBox(
                        width: 12,
                      ),

                      //---Guests Selection

                      Flexible(
                        flex: 1,
                        child: TopSelectionButtonWidget(
                          isSelected: selectedTab == SelectionType.guest,
                          onTap: () {
                            ref.read(selectionProvider.notifier).state =
                                SelectionType.guest;
                          },
                          activeImage: "guest_black.svg",
                          data: "Add Guests",
                          inActiveImage: "guest_grey.svg",
                          finished: false,
                        ),
                      ),
                    ]),
                    OptionField(
                      data: data,
                    )
                  ]);
            },
          ),
        ),
      ),
      bottomNavigationBar: Consumer(
        builder: (context, ref, _) {
          final selectedTab = ref.watch(selectionProvider);

          return selectedTab == SelectionType.guest
              ? Consumer(builder: (context, ref, _) {
                  final bookingController = ref.watch(bookingProvider);

                  ref.listen(bookingProvider, (previous, next) {
                    if (next is BookingSuccess) {
                      debugPrint(next.bookingId);

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

                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EntryConfirmation(
                                    bookingType: next.bookingType,
                                    id: next.bookingId,
                                  )));
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

                  return Padding(
                    padding: EdgeInsets.only(
                        left: 16.0,
                        right: 16,
                        bottom: 40 + MediaQuery.of(context).viewInsets.bottom),
                    child: FloatingSubmitButton(
                      onTap: () {
                        try {
                          // final guestList = _guestListKye.currentState!.getAllGuest();
                          // onNextClick(guestList);
                          try {
                            final guests = ref
                                .read(guestEditProvider.notifier)
                                .getGuestList();
                            // onNextClick(guests);
                            ref
                                .read(bookingProvider.notifier)
                                .bookTable(guests);
                          } catch (e) {
                            // _showMessage(context, e.toString());
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString())));
                          }
                        } catch (_) {
                          //handle guest list error
                        }
                      },
                      text: "Confirm Booking",
                    ),
                  );
                })
              : Consumer(builder: (context, ref, _) {
                  final datePickController = ref.watch(datePickProvider);
                  final slotPickController = ref.watch(slotPickProvider);

                  // final datetickProvider = ref.watch(dateDonetickProvider);

                  return Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16, bottom: 40),
                      child: datePickController != null &&
                              slotPickController != null
                          ? RoundedGoldenButton(
                              // height: 44,
                              onTap: () {
                                ref.read(selectionProvider.notifier).state =
                                    SelectionType.guest;
                              },
                              text: "Next",
                            )
                          : RoundedGoldenButton(
                              // height: 44,
                              onTap: () {},
                              text: 'Next',
                              isActive: false,
                            ));
                });
        },
      ),
    );
  }
}

class OptionField extends ConsumerWidget {
  final ClubDataModel data;
  const OptionField({super.key, required this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectionController = ref.watch(selectionProvider);
    final miscDataController = ref.watch(clubMiscDataProvider(data.id));

    if (miscDataController is ClubMisLoaded) {
      return Container(
        child: buildArea(
            selectionController, ref, miscDataController, data, context),
      );
    }

    return const BaseShimmer(
      child: ShimmerBoxCornered(
        width: double.infinity,
        height: 260,
      ),
    );
  }

  Widget buildArea(SelectionType type, WidgetRef ref, ClubMisLoaded miscData,
      ClubDataModel clubData, BuildContext context) {
    List<String> slots =
        clubData.slots.map((e) => '${e['slot_time']} ${e['zone']}').toList();
    if (slots.isEmpty) {
      // slots = ['9 PM', '10 PM', '11 PM'];
      final fromTime =
          timeConverterTimeOfDay(clubData.schedule['Monday']['from_time']);
      final toTime =
          timeConverterTimeOfDay(clubData.schedule['Monday']['to_time']);
      final timeSlots =
          timeSlotGenerator(fromTime, TimeOfDay(hour: toTime.hour, minute: toTime.minute - 30), const Duration(minutes: 30));

      final timeZone = clubData.clubTimeZone;
      slots = timeSlots.map((e) => '${e.format(context)} $timeZone').toList();
    }

    switch (type) {
      case SelectionType.date:
        return DatePickWidget(
          holidays: miscData.closedDates,
          slots: slots,
          onNextClick: () {
            ref.read(selectionProvider.notifier).state = SelectionType.guest;
          },
        );

      case SelectionType.guest:
        return AddGuestsDetails(
          data: data,
          onBackClick: () {
            ref.read(selectionProvider.notifier).state = SelectionType.date;
          },
          onNextClick: (guests) {
            ref.read(bookingProvider.notifier).bookTable(guests);
          },
        );

      default:
        return DatePickWidget(
          holidays: miscData.closedDates,
          slots: slots.toList(),
          onNextClick: () {
            // ref.read(selectionProvider.notifier).state = SelectionType.drinks;

            ref.read(selectionProvider.notifier).state = SelectionType.guest;
          },
        );
    }
  }
}
