import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/authentication/data/service/firebase_auth_service.dart';
import 'package:htp_customer/common/widgets_common/needles_widget.dart';
import 'package:htp_customer/features/booking/controllers/selection/date_controller.dart';
import 'package:htp_customer/features/profile/controller/profile_controller.dart';
import 'package:htp_customer/htp_theme.dart';
import 'package:intl/intl.dart';
import 'timeslot_selection.dart';

class DatePickWidget extends ConsumerWidget {
  final List<DateTime> holidays;
  final List<String> slots;
  final VoidCallback onNextClick;
  const DatePickWidget(
      {super.key,
      required this.onNextClick,
      required this.holidays,
      required this.slots});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final slotPickController = ref.watch(slotPickProvider);

    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Date of Booking",
              style: man14White,
            ),
          ),
          DatePickField(
            holidays: holidays,
          ),
          TimeSlotSelection(
            // slots: slots.map((e) => e.format(context)).toList(),
            slots: slots,
            onSelection: (value) {
              ref.read(slotPickProvider.notifier).state = value;
            },
            selectedSlot: slotPickController,
          ),
          const SizedBox(
            height: 88,
          ),
          // Consumer(
          //   builder: (context, ref, _) {
          //     final datePickController = ref.watch(datePickProvider);
          //     // final datetickProvider = ref.watch(dateDonetickProvider);

          //     return Padding(
          //         padding: const EdgeInsets.symmetric(vertical: 12),
          //         child:
          //             datePickController != null && slotPickController != null
          //                 ? FloatingSubmitButton(
          //                     // height: 44,
          //                     onTap: onNextClick,
          //                     text: "NEXT",
          //                   )
          //                 : FloatingSubmitButton(
          //                     // height: 44,
          //                     onTap: () {},
          //                     text: 'NEXT',
          //                     isActive: false,
          //                   ));
          //   },
          // )
        ],
      ),
    );
  }
}

class DatePickField extends ConsumerWidget {
  final List<DateTime> holidays;
  DatePickField({Key? key, required this.holidays}) : super(key: key);

  final TextEditingController _controller = TextEditingController();

  List specialUserEmail = [
    'sathish.leovirgo@gmail.com',
    'swami.sg2023@gmail.com',
    'swami@party.one',
    'anutestfs@gmail.com'
  ];

  List uidOfSpecialUser = [
    "mM9Gqz0lYXeG0jh0W8GfGOnjFf02",
    "FnRpfxjMuQdLMlxStjIS5xokQQB2",
    "vz0LdrTzCBeFggOTlXHCYitarw73",
    'AhRTtJ6ro8QAxIUYcCJVcA3IoJK2'
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateController = ref.watch(datePickProvider);
    final profileController = ref.watch(profileControllerProvider);
    if (dateController != null) {
      _controller.text = DateFormat('dd MMMM yyyy').format(dateController);
    }
    return Column(
      children: [
        TextField(
          controller: _controller,
          readOnly: true,
          onTap: () {
            if (profileController is ProfileLoaded) {
              debugPrint(
                  "=================================${profileController.profileData.id}");
              bool isSpecailUser = false;
              // int blockHours = 0;

              if (uidOfSpecialUser.contains(profileController.profileData.id) ==
                  true) {
                isSpecailUser = true;
                // if (profileController.activeMembershipData
                //             ?.membershipCalculations?.tableBookingUpToHours !=
                //         null &&
                //     profileController.activeMembershipData
                //             ?.membershipCalculations?.tableBookingUpToHours !=
                //         0) {
                //   blockHours = profileController.activeMembershipData
                //       ?.membershipCalculations?.tableBookingUpToHours as int;
                //   blockHours = blockHours - 24;
                // }
              }

              pickData(
                  context,
                  ref,
                  holidays,
                  isSpecailUser == true
                      ? 0
                      // blockHours
                      : profileController.activeMembershipData
                          ?.membershipCalculations?.tableBookingUpToHours);
            }
          },
          decoration: InputDecoration(
              hintText: "DD/MM/YYYY",
              hintStyle: TextStyle(fontSize: 14, color: Colors.grey.shade500),
              // border: const UnderlineInputBorder(
              //     borderSide: BorderSide(color: HtpTheme.goldenColor)),
              focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: HtpTheme.darkBlue2Color)),
              // disabledBorder: const UnderlineInputBorder(
              //     borderSide: BorderSide(color: HtpTheme.goldenColor)),
              enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: HtpTheme.darkBlue2Color)),
              suffixIcon: IconButton(
                icon: const Icon(
                  Icons.calendar_today_outlined,
                  color: HtpTheme.goldenColor,
                ),
                onPressed: () async {
                  if (profileController is ProfileLoaded) {
                    bool isSpecailUser = false;
                    // int blockHours = 0;

                    if (uidOfSpecialUser
                            .contains(profileController.profileData.id) ==
                        true) {
                      isSpecailUser = true;
                    }
                    pickData(
                        context,
                        ref,
                        holidays,
                        isSpecailUser == true
                            ? 0
                            : profileController
                                .activeMembershipData
                                ?.membershipCalculations
                                ?.tableBookingUpToHours);
                  }
                },
              )),
        ),
        const NeedleDoubleSided()
      ],
    );
  }

  pickData(BuildContext context, WidgetRef ref, List<DateTime> holidays,
      int? bookBlockHour) async {
    final List<String> stringHolidays = holidays
        .map((e) => DateTime(e.year, e.month, e.day).toIso8601String())
        .toList();
    DateTime allowedBookDate =
        DateTime.now().add(Duration(hours: bookBlockHour ?? 0));

    while (stringHolidays.contains(DateTime(
            allowedBookDate.year, allowedBookDate.month, allowedBookDate.day)
        .toIso8601String())) {
      allowedBookDate = allowedBookDate.add(const Duration(days: 1));
    }

    final dateTime = await showDatePicker(
        context: context,
        initialDate: allowedBookDate,
        firstDate: allowedBookDate,
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        lastDate: DateTime.now().add(const Duration(days: 30)),
        selectableDayPredicate: (DateTime val) {
          final stringDate =
              DateTime(val.year, val.month, val.day).toIso8601String();
          if (stringHolidays.contains(stringDate)) {
            // print(stringDate);
            return false;
          }
          // return val.weekday == 7 ? false : true;
          return true;
        });
    if (dateTime != null) {
      ref.read(datePickProvider.notifier).state = dateTime;
    }
  }
}
