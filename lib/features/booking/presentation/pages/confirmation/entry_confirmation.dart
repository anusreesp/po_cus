import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:htp_customer/common/widgets_common/needles_widget.dart';
import 'package:htp_customer/features/booking/data/services/booking_services.dart';
import 'package:htp_customer/features/booking/presentation/pages/confirmation/invoice/bill_capture.dart';
import 'package:htp_customer/features/booking/presentation/widgets/new/confirmation_card.dart';
import 'package:htp_customer/features/clubs/presentation/widgets/new/floatingButtons.dart';
import 'package:htp_customer/features/profile/presentation/widgets/support.dart';
import 'package:htp_customer/htp_theme.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../../common/widgets_common/app_bar_back_button.dart';
import '../../../../../exception_handling/common_exceptions.dart';
import '../../../controllers/booking_controller.dart';
import '../../../data/models/booking_details.dart';
import 'dart:math' as math;

class EntryConfirmation extends ConsumerWidget {
  final String id;
  final String bookingType;
  const EntryConfirmation(
      {required this.id, required this.bookingType, super.key});

  static const route = '/entry-confirm';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentstatusController = ref.watch(StatusProvider);

    return FutureBuilder<BookingResponseData>(
        future:
            ref.read(bookingServiceProvider).getBookingData(id, bookingType),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child:
                  const CircularProgressIndicator(color: HtpTheme.goldenColor),
            );
          }

          if (snapshot.hasError) {
            return Scaffold(
                appBar: AppBar(
                  leading: AppbarBackButton(),
                ),
                body: Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.15),
                  child: SomethingWrong(),
                ));
          }

          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData &&
              snapshot.data != null) {
            final BookingResponseData snapshotData = snapshot.data!;
            final bookType;
            final type;

            if (bookingType == 'club_entry_booking') {
              bookType = ' - ENTRY BOOKING';
              type = 'club';
            } else if (bookingType == 'event_entry_booking') {
              bookType = '';
              type = 'event';
            } else {
              bookType = ' - TABLE BOOKING';
              type = 'table';
            }

            return Scaffold(
              appBar: AppBar(
                leading: const AppbarBackButton(),
                title: Text(
                  bookingType == 'event_entry_booking'
                      ? "${snapshotData.data.eventName?.toUpperCase()}"
                      : "${snapshotData.data.clubName?.toUpperCase()} $bookType",
                  style: man14White,
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 16),
                    child: (snapshotData.data.bookingStatus == "Cancelled" ||
                            snapshotData.data.bookingStatus == 'Rejected')
                        ? Column(
                            children: [
                              ConfirmationCard(
                                // clubData: clubData,

                                snapData: snapshotData,
                                bookingType: bookingType,
                              ),

                              const SizedBox(height: 24),
                              //--------------------------------
                              Transform.rotate(
                                angle: -math.pi,
                                child: NeedleVertical(
                                  thickness: 1,
                                  height:
                                      MediaQuery.of(context).size.height * 0.25,
                                ),
                              ),

                              const SizedBox(height: 32),
                              FloatingBlackButton(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SupportPage(
                                                  isNotFromHome: true,
                                                )));
                                  },
                                  text: "Contact Support")
                            ],
                          )

                        //------------------------------   Not cancelled or rejected-------------------------------------
                        : Column(
                            children: [
                              Center(
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.68,
                                  child: const Text(
                                    "You’re all set to elevate your nightlife experience",
                                    style: tenor22LightBlue,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 32,
                              ),
                              NeedleVertical(
                                height: ((snapshotData.data.bookingStatus ==
                                                'Approved' ||
                                            snapshotData.data.bookingStatus ==
                                                'Completed') &&
                                        snapshotData.data.invoiceUrl!.isEmpty)
                                    ? 65
                                    : 90,
                                thickness: ((snapshotData.data.bookingStatus ==
                                                'Approved' ||
                                            snapshotData.data.bookingStatus ==
                                                'Completed') &&
                                        snapshotData.data.invoiceUrl!.isEmpty)
                                    ? 1
                                    : 1.5,
                              ),
                              if ((snapshotData.data.bookingStatus ==
                                          'Approved' ||
                                      snapshotData.data.bookingStatus ==
                                          'Completed') &&
                                  snapshotData.data.invoiceUrl!.isEmpty)
                                FloatingBlackButton(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => BillCapture(
                                                    id: id,
                                                    bookingType: bookingType,
                                                  )));
                                    },
                                    text: 'Upload Invoice'),
                              if ((snapshotData.data.bookingStatus ==
                                          'Approved' ||
                                      snapshotData.data.bookingStatus ==
                                          'Completed') &&
                                  snapshotData.data.invoiceUrl!.isEmpty)
                                const SizedBox(
                                  height: 12,
                                ),

                              //------------------------- Details-------------------------------------

                              ConfirmationCard(
                                snapData: snapshotData,
                                bookingType: bookingType,
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              if (snapshotData.data.bookingStatus == "Approved")
                                Center(child: ShareBooking(onPressed: () {
                                  // FirebaseAnalytics.instance
                                  //     .logEvent(name: "share");
                                  FirebaseAnalytics.instance.logShare(
                                      contentType:
                                          "${snapshotData.data.bookingType}",
                                      itemId: "${snapshotData.data.bookingId}",
                                      method: "Booking");
                                  Share.share(
                                      'Exciting news! Your $type booking at ${snapshotData.data.clubName} for ${DateFormat('dd MMMM yyyy').format(snapshotData.data.bookingDate)} has been confirmed through Party One. We look forward to hosting you soon. Download the App: https://party.one/download-app');
                                })),
                              const SizedBox(
                                height: 22,
                              ),
                              FloatingBlackButton(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SupportPage(
                                                  isNotFromHome: true,
                                                )));
                                  },
                                  text: "Modify or Cancel Booking"),
                              const SizedBox(
                                height: 24,
                              ),
                              helpSupport(context),
                              const SizedBox(
                                height: 40,
                              ),
                            ],
                          )),
              ),
            );
          }
          return const SizedBox.shrink();
        });
  }

  Widget helpSupport(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Need help with a booking?   ",
          style: man14LightGrey,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SupportPage(
                          isNotFromHome: true,
                        )));
          },
          child: Row(
            children: [
              Text(
                "My Concierge  ",
                style: man14Gold,
              ),
              SvgPicture.asset(
                "assets/svg/icons/others/concierge_icon.svg",
                width: 12,
                height: 12,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ShareBooking extends StatelessWidget {
  final VoidCallback onPressed;
  const ShareBooking({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Share booking details",
          style: man14LightBlue,
        ),
        IconButton(
          onPressed: onPressed,
          icon: const Icon(
            Icons.share,
            color: HtpTheme.lightBlueColor,
          ),
        )
      ],
    );
  }
}
