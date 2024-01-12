import 'package:change_case/change_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/src/types.dart';

import '../../../../../common/utils/common_links.dart';
import '../../../../../common/widgets_common/map_display.dart';
import '../../../../../common/widgets_common/needles_widget.dart';
import '../../../../../htp_theme.dart';
import '../../../../booking/data/models/booking_details.dart';
import '../../../../profile/controller/profile_controller.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;

class ViewBottomSheet extends StatelessWidget {
  // final ClubDataModel clubData;
  final String bookingType;

  final BookingResponseData snapData;
  const ViewBottomSheet(
      {super.key, required this.snapData, required this.bookingType});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        showModalBottomSheet(
          showDragHandle: true,
          context: context,
          isScrollControlled: true,
          // useSafeArea: true,
          backgroundColor: HtpTheme.darkBlue2Color,
          builder: (context) => _buildBottomSheet(context),
        );
      },
      child: Row(
        children: [
          Text(
            "View all booking details",
            style: man14Gold.merge(const TextStyle(
              decoration: TextDecoration.underline,
            )),
          ),
          const Spacer(),
          Transform.scale(
              // angle: 180 * pi / 180,
              scaleX: -1,
              child: SvgPicture.asset("assets/svg/icons/arrow/sidearrow.svg")),
          const SizedBox(
            width: 12,
          )
        ],
      ),
    );
  }

  Widget _buildBottomSheet(
    BuildContext context,
    //  ScrollController, double bottomSheetOffset
  ) {
    final bookingDoneTime = snapData.data.createdAt.toLocal();
    int i = 0;

    final formattedDate = snapData.data.bookingDate.toLocal();

    String bookingStatus = "";

    if (snapData.data.bookingStatus == 'Booking request pending' ||
        snapData.data.bookingStatus == 'Pending') {
      bookingStatus = 'Booking requested';
    } else if (snapData.data.bookingStatus ==
            "Waiting for payment verification" ||
        snapData.data.bookingStatus == "Waiting for approval") {
      bookingStatus = 'Payment verification';
    } else if (snapData.data.bookingStatus == 'Rejected') {
      bookingStatus = "Booking rejected";
    } else if (snapData.data.bookingStatus == 'Completed') {
      bookingStatus = "Booking completed";
    } else {
      bookingStatus = "Booking confirmed";
    }

    return Container(
        height: MediaQuery.of(context).size.height * 0.80,
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0))),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                  "${snapData.data.clubLocation}   |   ",
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
            // Text(
            //   snapData.data.address,
            //   style: man14White,
            // ),

            const SizedBox(height: 28),
            const NeedleDoubleSided(),
            const SizedBox(height: 28),

            //---------------------------Booking Details-------------------------------
            const Text(
              "Booking date",
              style: man14LightBlue,
            ),

            const SizedBox(height: 8),
            snapData.data.expectedArrival != null
                ? Row(
                    children: [
                      Text(
                        DateFormat('E, d MMM, yyyy')
                            .format(snapData.data.bookingDate),
                        style: man14White,
                      ),
                      const SizedBox(width: 6),
                      const Icon(
                        Icons.circle,
                        color: HtpTheme.whiteColor,
                        size: 6,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "${snapData.data.expectedArrival}",
                        style: man14White,
                      )
                    ],
                  )
                : Row(
                    children: [
                      Text(
                        DateFormat('E, d MMM, yyyy')
                            .format(snapData.data.bookingDate),
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

            const SizedBox(height: 16),

            const Text(
              "Booking requested on",
              style: man14LightBlue,
            ),

            const SizedBox(height: 8),

            Row(
              children: [
                Text(
                  DateFormat('E, d MMM, yyyy').format(bookingDoneTime),
                  style: man14White,
                ),
                const SizedBox(width: 6),
                const Icon(
                  Icons.circle,
                  color: HtpTheme.whiteColor,
                  size: 6,
                ),
                const SizedBox(width: 6),
                Text(
                  "${DateFormat('hh:mm a').format(bookingDoneTime)} ${bookingDoneTime.timeZoneName}",
                  style: man14White,
                )
              ],
            ),

            const SizedBox(height: 16),

            const Text(
              "Booking status",
              style: man14LightBlue,
            ),

            const SizedBox(height: 6),

            Text(
              bookingStatus,
              style: man14White,
            ),

            const SizedBox(height: 8),

            const SizedBox(height: 28),
            const NeedleDoubleSided(),
            const SizedBox(height: 28),

            //------------------------------------------ Guest Details ---------------------------------------------
            const Text(
              "Guest list",
              style: man14LightBlue,
            ),

            const SizedBox(height: 12),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Consumer(builder: (context, ref, _) {
                  final profileController =
                      ref.watch(profileControllerProvider);

                  if (profileController is ProfileLoaded) {
                    final gender;
                    if (profileController.profileData.gender == 'Female' ||
                        profileController.profileData.gender == 'female') {
                      gender = 'F';
                    } else if (profileController.profileData.gender == 'Male' ||
                        profileController.profileData.gender == 'male') {
                      gender = 'M';
                    } else if (profileController.profileData.gender ==
                            'Non-Binary' ||
                        profileController.profileData.gender == 'non-binary' ||
                        profileController.profileData.gender == 'Others' ||
                        profileController.profileData.gender == 'Other') {
                      gender = '-';
                    } else {
                      gender = '-';
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              profileController.profileData.name.toTitleCase(),
                              style: man14White,
                            ),
                            const Text(
                              " (Host)",
                              style: man14LightBlue,
                            )
                          ],
                        ),
                        profileController.profileData.dob != null
                            ? SizedBox(
                                width: 60,
                                child: Text(
                                  "${calculateAge(profileController.profileData.dob!)} | $gender",
                                  style: man14White,
                                ),
                              )
                            : Text(
                                '- | $gender',
                                style: man14White,
                              ),
                      ],
                    );
                  }

                  return const SizedBox.shrink();
                }),

                const SizedBox(height: 6),

                ...snapData.data.people.map((e) {
                  final String gender;

                  if (e['gender'] == 'Female' || e['gender'] == 'female') {
                    gender = 'F';
                  } else if (e['gender'] == 'Male' || e['gender'] == 'male') {
                    gender = 'M';
                  } else {
                    gender = '-';
                  }

                  if (e['name'] == "-") {
                    i++;
                  } else {
                    i++;
                  }

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          e['name'] == "-"
                              ? "Guest $i"
                              : e['name'].toString().toTitleCase(),
                          style: man14White,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        width: 60,
                        child: Text(
                          '${e['age']} | $gender',
                          style: man14White,
                        ),
                      )
                    ],
                  );
                }),

                //-------------------------------Terms & Conditions----------------------------------
                // GestureDetector(
                //   onTap: () {
                //     urlLauncher.launchUrl(
                //         Uri.parse(
                //           "${supportLink}terms-and-conditions/",
                //         ),
                //         mode: LaunchMode.externalNonBrowserApplication);
                //   },
                //   child:

                // GestureDetector(
                //   child: Text(
                //     "Chick Here",
                //     style: man14Gold,
                //   ),
                // ),

                // const SizedBox(height: 28),
              ],
            ),

            const SizedBox(height: 28),
            const NeedleDoubleSided(),
            const SizedBox(height: 28),
            Text(
              'Terms & Conditions',
              style: tenor22White.apply(
                decoration: TextDecoration.underline,
              ),
              // ),
            ),
            const SizedBox(
              height: 6,
            ),
            GestureDetector(
              onTap: () {
                urlLauncher.launchUrl(Uri.parse(
                  "${supportLink}terms-and-conditions/",
                ));
              },
              child: Row(
                children: [
                  Text(
                    'Party One - Legal Terms',
                    style: man14LightBlue.apply(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SvgPicture.asset(
                    'assets/svg/icons/external_link.svg',
                    color: HtpTheme.goldenColor,
                    height: 13,
                    width: 13,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Club Terms and Conditions',
                  style: man14White,
                ),
                const SizedBox(
                  height: 12,
                ),
                Markdown(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                    data: snapData.data.termsAndConditions)
              ],
            )
          ]),
        ));
  }

  String calculateAge(String birthDate) {
    DateTime currentDate = DateTime.now();
    var birthDateSplit = birthDate.split("-");
    int date = int.parse(birthDateSplit[0]);
    int month = int.parse(birthDateSplit[1]);
    int year = int.parse(birthDateSplit[2]);

    // int age = currentDate.year - birthDate.year;
    int age = currentDate.year - year;
    int month1 = currentDate.month;
    // int month2 = birthDate.month;
    if (month > month1) {
      age--;
    } else if (month1 == month) {
      int day1 = currentDate.day;
      // int day2 = birthDate.date;
      if (date > day1) {
        age--;
      }
    }
    return age.toString();
    // return birthDateSplit[0];
  }
}
