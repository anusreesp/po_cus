import 'package:change_case/change_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../../../../common/widgets_common/app_bar_back_button.dart';
import '../../../../common/widgets_common/floatingSubmitButton.dart';
import '../../../../htp_theme.dart';
import '../../../booking/controllers/booking_controller.dart';
import '../../../booking/controllers/selection/guests_controller.dart';
import '../../../booking/presentation/pages/confirmation/entry_confirmation.dart';
import '../../../booking/presentation/widgets/new/topselection_button.dart';
import '../../data/models/event_model.dart';
import '../widget/add_guest_event.dart';

class EventBooking extends ConsumerWidget {
  static const route = '/event-booking';
  final EventModel data;
  const EventBooking({required this.data, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppbarBackButton(),
        // GestureDetector(
        //   child: Padding(
        //     padding: const EdgeInsets.all(20),
        //     child: SvgPicture.asset(
        //       'assets/svg/icons/support/arrowleft.svg',
        //     ),
        //   ),
        //   onTap: () {
        //     Navigator.of(context).pop();
        //   },
        // ),
        title: Text(data.name.toUpperCase()),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            EventBasicData(data: data),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.48,
              child: TopSelectionButtonWidget(
                isSelected: true,
                onTap: () {
                  // ref.read(selectionProvider.notifier).state =
                  //     SelectionType.guest;
                },
                activeImage: "guest_black.svg",
                data: "Add Guests",
                inActiveImage: "guest_grey.svg",
                finished: false,
              ),
            ),
            AddGuestsEvent(data: data)
          ]),
        ),
      ),
      bottomNavigationBar: Consumer(builder: (context, ref, _) {
        final bookingController = ref.watch(bookingProvider);

        ref.listen(bookingProvider, (previous, next) {
          if (next is BookingSuccess) {
            debugPrint(next.bookingId);
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
                  final guests =
                      ref.read(guestEditProvider.notifier).getGuestList();
                  ref.read(bookingProvider.notifier).bookEvent(guests, data);
                } catch (e) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(e.toString())));
                }
              },
              text: "Next"),
        );
      }),
    );
  }
}

class EventBasicData extends StatelessWidget {
  final EventModel data;
  const EventBasicData({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            data.profileImage != null
                ? Image.network(
                    data.profileImage!,
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: 120,
                    fit: BoxFit.cover,
                  )
                : Image(
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: 120,
                    image: const AssetImage(
                      'assets/images/placeholders/placeholder_15.png',
                    ),
                  ),
            const SizedBox(
              width: 12,
            ),

            // -----Name -----
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(
                    data.name,
                    style: tenor16White,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(
                    height: 8,
                  ),

                  //----------------------Date and Time-----------------------
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(
                                right: 8, left: 2, top: 4),
                            child: SvgPicture.asset(
                              "assets/svg/icons/clock.svg",
                              width: 15,
                            )),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                DateFormat('E, dd MMM yyyy')
                                    .format(data.eventData),
                                style: man14White,
                              ),
                              Text(
                                "${DateFormat('h a').format(data.eventData)} onwards",
                                style: man14LightBlue,
                              ),
                            ])
                      ]),

                  const SizedBox(
                    height: 8,
                  ),

                  //-------------------------Location and Address---------------------------------
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: SvgPicture.asset(
                            "assets/svg/bottom_nav/location_f.svg",
                            width: 18,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(data.club.name,
                                softWrap: true, style: man14White),
                            Text(
                              "at ${data.club.cityName.toTitleCase()}",
                              style: man14LightBlue,
                            )
                          ],
                        ),
                      ])
                ])),
          ]),
    );
  }
}
