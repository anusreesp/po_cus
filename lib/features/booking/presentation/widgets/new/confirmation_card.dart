import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:htp_customer/common/widgets_common/map_display.dart';
import 'package:htp_customer/features/booking/data/models/booking_details.dart';
import 'package:htp_customer/features/clubs/presentation/widgets/new/bottom_sheet.dart';
import 'package:htp_customer/features/booking/presentation/widgets/new/confirmation_steps.dart';
import 'package:htp_customer/features/profile/controller/profile_controller.dart';
import 'package:htp_customer/htp_theme.dart';
import 'package:intl/intl.dart';

import '../../../../../common/widgets_common/needles_widget.dart';

class ConfirmationCard extends ConsumerWidget {
  final BookingResponseData snapData;
  final String bookingType;
  const ConfirmationCard(
      {super.key, required this.snapData, required this.bookingType});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileController = ref.watch(profileControllerProvider);

    final formattedDate = snapData.data.bookingDate.toLocal();

    return Container(
      color: HtpTheme.darkBlue2Color,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                  radius: 30.5,
                  backgroundImage: const AssetImage('assets/images/logoBg.png'),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: bookingType == "event_entry_booking" &&
                              snapData.data.eventImage != null
                          ? Image(
                              image:
                                  NetworkImage("${snapData.data.eventImage}"),

                              // AssetImage(
                              //     'assets/images/temp/profile.png'),
                              height: 56,
                              width: 56,
                              fit: BoxFit.cover,
                            )
                          : snapData.data.clubImage != null
                              ? Image(
                                  image: NetworkImage(
                                      "${snapData.data.clubImage}"),
                                  height: 56,
                                  width: 56,
                                  fit: BoxFit.cover,
                                )
                              : const Image(
                                  height: 56,
                                  width: 56,
                                  image: AssetImage(
                                      'assets/images/placeholders/placeholder_11.png')))),

              const SizedBox(
                width: 12,
              ),

              //-------------------------------Details here ----------------------

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bookingType != "event_entry_booking"
                          ? "${snapData.data.clubName}"
                          : "${snapData.data.eventName}",
                      style: tenor22White,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          // clubData.runtimeType == EventModel
                          //     ? "${clubData.club.cityName}   |    "
                          //     : "${clubData.cityName}   |   ",
                          snapData.data.clubLocation != null
                              ? "${snapData.data.clubLocation}    |    "
                              : "",
                          style: man14LightBlue,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MapDisplay(
                                        lat: snapData.data.latitude ?? 0,
                                        lng: snapData.data.longitude ?? 0,
                                        title: "${snapData.data.clubName}")));
                          },
                          child: Row(children: [
                            SvgPicture.asset("assets/svg/icons/others/map.svg"),
                            const SizedBox(
                              width: 4,
                            ),
                            const Text(
                              "Map",
                              style: man14Gold,
                            )
                          ]),
                        )
                      ],
                    ),
                    const SizedBox(height: 16),

                    // bookingType == "club_entry_booking"
                    // ?
                    snapData.data.expectedArrival != null
                        ? Row(
                            children: [
                              Text(
                                DateFormat('E, d MMM, yyyy')
                                    .format(formattedDate),
                                style: man14White,
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              const Icon(
                                Icons.circle,
                                color: HtpTheme.whiteColor,
                                size: 6,
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              Text(
                                "${snapData.data.expectedArrival}",
                                style: man14White,
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              Text(
                                DateFormat('E, d MMM, yyyy')
                                    .format(formattedDate),
                                style: man14White,
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              const Icon(
                                Icons.circle,
                                color: HtpTheme.whiteColor,
                                size: 6,
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              Text(
                                // "${DateFormat('hh:mm a').format(formattedDate)} ${formattedDate.timeZoneName}",
                                "${DateFormat('hh:mm a').format(formattedDate)} ${snapData.data.countryTimeZone}",
                                style: man14White,
                              )
                            ],
                          ),
                    // : Text(
                    //     "$formattedDate  . ${DateFormat('h:mm a').format(snapData.data.bookingDate)}"),
                    const SizedBox(height: 16),
                    Text(
                      snapData.data.bookingType == "club_entry_booking"
                          ? "ENTRY BOOKING"
                          : snapData.data.bookingType == "event_entry_booking"
                              ? "EVENT BOOKING"
                              : "TABLE BOOKING",
                      style: man14White,
                    ),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Total Guests",
                          style: man14LightBlue,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "${snapData.data.attendeeCount + 1}",
                          style: man14Gold,
                        )
                      ],
                    ),

                    //------------------------------ Booking Details Bottom Sheet---------------------------
                    const SizedBox(height: 16),
                    ViewBottomSheet(
                      snapData: snapData,
                      bookingType: bookingType,
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 24),
          const NeedleDoubleSided(),
          const SizedBox(height: 24),

          //---------------------  Booking status   ------------------------
          (snapData.data.bookingStatus == "Cancelled" ||
                  snapData.data.bookingStatus == "Rejected")
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapData.data.bookingStatus == "Cancelled"
                                ? "Booking cancelled"
                                : "Booking rejected",
                            style: man16White,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: const Text(
                              "Due to one or more reasons your booking has been declined, please contact support for further assistance",
                              style: man12LightBlue,
                            ),
                          )
                        ],
                      ),
                      const Spacer(),
                      Image.asset("assets/images/icons/red_cross.png")
                    ],
                  ),
                )
              : ConfirmationSteps(
                  confirmationStatus: snapData.data.bookingStatus,
                  // confirmationStatus: "Approved",
                  snapData: snapData,
                ),
          const SizedBox(height: 22),
        ],
      ),
    );
  }
}
