import 'package:change_case/change_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:htp_customer/features/booking/presentation/pages/confirmation/confirm_ticket.dart';
import 'package:htp_customer/features/profile/data/services/profile_services.dart';
import 'package:htp_customer/htp_theme.dart';
import 'package:intl/intl.dart';

import '../../../../../../../authentication/theme.dart';
import '../../../../booking/presentation/pages/confirmation/entry_confirmation.dart';
import '../../../../dashboard/presentation/widgets/custom_app_bar.dart';
import '../../../data/models/booking_details.dart';

class NewBooking extends ConsumerWidget {
  static const route = '/new-booking';
  NewBooking({super.key});

  var colorTheme = AuthTheme.colorTheme();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
          appBar: const CustomAppBar(
            height: 20,
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    opacity: 0.3,
                    alignment: Alignment.bottomLeft,
                    image: AssetImage(
                      "assets/images/mask_group.png",
                    ))),
            child: DefaultTabController(
              length: 2,
              initialIndex: 0,
              child: Column(
                children: [
                  const TabBar(
                    indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(width: 10.0)),
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: HtpTheme.whiteColor,
                    tabs: [
                      Tab(
                        child: Text(
                          "Active Bookings",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            // fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Past Bookings",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            // fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                    ],
                  ),

                  //---------------- Booking list --------------
                  Expanded(
                    child: TabBarView(children: [
                      SingleChildScrollView(
                        child: FutureBuilder(
                          future:
                              ref.read(profileServiceProvider).getMyBookings(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.done &&
                                snapshot.hasData) {
                              final List<BookingData> bookings = snapshot.data!;
                              final today = DateTime.now();
                              final filtered = bookings.where((element) =>
                                  (element.bookingDate.month == today.month &&
                                      element.bookingDate.year == today.year &&
                                      element.bookingDate.day == today.day) ||
                                  element.bookingDate.isAfter(today));
                              return Column(
                                children: [
                                  if (filtered.isEmpty)
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 32.0, horizontal: 18),
                                      child: Text(
                                          'Nothing on the calendar ? Time to party ! Let\'s book you a night you\'ll never forget !',
                                          textAlign: TextAlign.center),
                                    ),

                                  ...filtered.map(
                                    (data) => UpcomingBookingCard(
                                        bookingType: data.bookingType,
                                        imageName:
                                            data.clubImage ?? data.eventImage,
                                        eventTitle:
                                            "${data.bookingType == 'event_entry_booking' ? data.eventName : data.clubName}",
                                        date: DateFormat('dd-MMMM-yyyy')
                                            .format(data.createdAt),
                                        status: data.status ?? '',
                                        onTap: () {
                                          // Navigator.pushNamed(
                                          //     context, ConfirmTicket.route,
                                          //     arguments: TicketValue(
                                          //         data.id, data.bookingType));
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EntryConfirmation(
                                                          id: data.id,
                                                          bookingType: data
                                                              .bookingType)));
                                        },
                                        eventDate: DateFormat('dd-MMMM-yyyy')
                                            .format(data.bookingDateOnly),
                                        place: data.clubLocation ?? ''),
                                  ),

                                  const SizedBox(
                                    height: 120,
                                  )

                                  // UpcomingEvents(
                                  //     imageName: "party-crowd.jpg",
                                  //     eventTitle: "Ice-bar",
                                  //     date: "01 Mar 2022",
                                  //     onTap: () {
                                  //       // Navigator.pushNamed(context, NewDetails.route);
                                  //       Navigator.pushReplacement(
                                  //           context,
                                  //           MaterialPageRoute(
                                  //               builder: (context) => NewBookDetails()));
                                  //     },
                                  //     eventDate: "12 Apr 2022",
                                  //     place: "Singapore"),
                                  //
                                  // Padding(
                                  //   padding: const EdgeInsets.symmetric(horizontal:40),
                                  //   child: const Divider(
                                  //     thickness: 0.2,
                                  //     height: 1.2,
                                  //     color: HtpTheme.whiteColor,
                                  //   ),
                                  // ),
                                  //
                                  // UpcomingEvents(
                                  //     imageName: "party-nopath.jpg",
                                  //     eventTitle: "Sanctum club",
                                  //     date: "18 Mar 2022",
                                  //     onTap: () {
                                  //       Navigator.pushNamed(context, NewPartDetails.route);
                                  //     },
                                  //     eventDate: "06 May 2022",
                                  //     place: "Miami"),
                                ],
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ),

                      // ------------------  Past Bookings -------------

                      FutureBuilder(
                          future:
                              ref.read(profileServiceProvider).getMyBookings(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.done &&
                                snapshot.hasData) {
                              final List<BookingData> bookings = snapshot.data!;
                              final today = DateTime.now();
                              final filtered = bookings.where((element) =>
                                  element.bookingDate.isBefore(DateTime(
                                      today.year, today.month, today.day)));
                              return SingleChildScrollView(
                                child: Column(
                                  children: [
                                    if (filtered.isEmpty)
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 32.0, horizontal: 18),
                                        child: Text(
                                          'No past bookings to look back on ? Let\'s help you find the perfect nightlife spots.',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),

                                    // ...filtered.map((data) => OldBookings(
                                    //     imageName: data.clubImage ?? data.eventImage,
                                    //     eventTitle: "${data.clubName ?? data.eventName}",
                                    //     date: DateFormat('dd-MMMM-yyyy').format(data.bookingDate),
                                    //     onTap: () {
                                    //       // Navigator.pushNamed(context, OldBookingDetails.route);
                                    //     },
                                    //     place: data.clubLocation ?? ''),),

                                    ...filtered.map(
                                      (data) => UpcomingBookingCard(
                                          bookingType: data.bookingType,
                                          imageName:
                                              data.clubImage ?? data.eventImage,
                                          eventTitle:
                                              "${data.bookingType == 'event_entry_booking' ? data.eventName : data.clubName}",
                                          date: DateFormat('dd-MMMM-yyyy')
                                              .format(data.createdAt),
                                          status: data.status ?? '',
                                          onTap: () {
                                            // Navigator.pushNamed(
                                            //     context, ConfirmTicket.route,
                                            //     arguments: TicketValue(
                                            //         data.id, data.bookingType));

                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EntryConfirmation(
                                                            id: data.id,
                                                            bookingType: data
                                                                .bookingType)));
                                          },
                                          eventDate: DateFormat('dd-MMMM-yyyy')
                                              .format(data.bookingDateOnly),
                                          place: data.clubLocation ?? ''),
                                    ),

                                    const SizedBox(
                                      height: 120,
                                    )

                                    // const Padding(
                                    //   padding: const EdgeInsets.symmetric(horizontal:40),
                                    //   child: const Divider(
                                    //     thickness: 0.2,
                                    //     height: 1.2,
                                    //     color: HtpTheme.whiteColor,
                                    //   ),
                                    // ),
                                    // OldBookings(
                                    //     imageName: "party-nopath.jpg",
                                    //     eventTitle: "Sanctum club",
                                    //     date: "18 Mar 2023",
                                    //     onTap: () {
                                    //       Navigator.pushNamed(context, OldBookingDetails.route);
                                    //     },
                                    //     place: "Miami")
                                  ],
                                ),
                              );
                            }

                            return const SizedBox.shrink();
                          })
                    ]),
                  )
                ],
              ),
            ),
          )),
    );
  }
}

class UpcomingBookingCard extends StatelessWidget {
  final String? imageName;
  final String eventTitle;
  final String date;
  final String status;
  final String place;
  final VoidCallback onTap;
  final String eventDate;
  final String bookingType;

  const UpcomingBookingCard(
      {super.key,
      required this.imageName,
      required this.eventTitle,
      required this.date,
      required this.place,
      required this.status,
      required this.onTap,
      required this.eventDate,
      required this.bookingType});

  String getBookingType(String type) {
    switch (type) {
      case 'event_entry_booking':
        return 'Event Booking';

      case 'table_booking':
        return 'Table Booking';

      default:
        return 'Club Entry Booking';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        color: Colors.black12,
        height: 150,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: imageName == null
                  ? const Image(
                      fit: BoxFit.cover,
                      height: 140,
                      width: 100,
                      image: AssetImage(
                          'assets/images/placeholders/placeholder_15.png'),
                    )
                  : Image.network(
                      imageName!,
                      height: 150,
                      width: 110,
                      fit: BoxFit.cover,
                    ),
            ),

            //Description
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Expanded(
                    //       child: Text(
                    //         eventTitle,
                    //         overflow: TextOverflow.ellipsis,
                    //         style: const TextStyle(
                    //           color: Color(0xffe8d48a), fontSize: 14,
                    //         ),
                    //       ),
                    //     ),
                    //     // const Spacer(),
                    //     _EventDate(data: eventDate)
                    //   ],
                    // ),

                    Text(
                      eventTitle,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                        color: Color(0xffe8d48a),
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(
                      height: 2,
                    ),
                    Row(
                      children: [
                        // const Icon(
                        //   Icons.location_on_sharp,
                        //   size: 17,
                        //   color: HtpTheme.goldenColor,
                        // ),
                        SvgPicture.asset(
                          'assets/svg/bottom_nav/location_f.svg',
                          height: 12,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          place,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    // const SizedBox(
                    //   height: 6.5,
                    // ),
                    const Spacer(),
                    Wrap(
                      runSpacing: 6,
                      spacing: 6,
                      children: [
                        _EventDate(data: eventDate),
                        _EventDate(data: getBookingType(bookingType)),
                        _EventDate(
                            data: "Booking ${bookingStatusString(status)}"
                                .toTitleCase()),
                      ],
                    ),

                    // Text(
                    //   "Booking status : ${bookingStatusString(status)}",
                    //   style: const TextStyle(
                    //     color: Color.fromARGB(255, 196, 196, 196),
                    //     fontSize: 12,
                    //
                    //   ),
                    // ),

                    // const SizedBox(
                    //   height: 2,
                    // ),
                    const Spacer(),
                    Text(
                      "Booked on : $date",
                      style: const TextStyle(
                        color: Color.fromARGB(255, 196, 196, 196),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Align(
            //   alignment: Alignment.topCenter,
            //   child: EventDate(eventDate),
            // )
          ],
        ),
      ),
    );
  }

  String bookingStatusString(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return 'Approved';

      case 'rejected':
        return 'Rejected';

      default:
        return 'Pending';
    }
  }
}

class UpcomingEvents extends StatelessWidget {
  final String? imageName;
  final String eventTitle;
  final String date;
  final String place;
  final VoidCallback onTap;
  final String eventDate;

  const UpcomingEvents(
      {super.key,
      required this.imageName,
      required this.eventTitle,
      required this.date,
      required this.place,
      required this.onTap,
      required this.eventDate});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 10),
        height: 100,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: imageName == null
                  ? const Image(
                      fit: BoxFit.cover,
                      height: 97,
                      width: 117,
                      image: AssetImage(
                          'assets/images/placeholders/placeholder_15.png'),
                    )
                  : Image.network(
                      imageName!,
                      height: 97,
                      width: 117,
                      fit: BoxFit.cover,
                    ),
            ),

            //Description
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            eventTitle,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Color(0xffe8d48a),
                              fontSize: 14,
                            ),
                          ),
                        ),
                        // const Spacer(),
                        _EventDate(data: eventDate)
                      ],
                    ),
                    const SizedBox(
                      height: 19,
                    ),
                    Row(
                      children: [
                        // const Icon(
                        //   Icons.location_on_sharp,
                        //   size: 17,
                        //   color: HtpTheme.goldenColor,
                        // ),
                        SvgPicture.asset(
                          'assets/svg/bottom_nav/location_f.svg',
                          height: 12,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          place,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 6.5,
                    ),
                    Text(
                      "Booked on : $date",
                      style: const TextStyle(
                        color: Color.fromARGB(255, 196, 196, 196),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Align(
            //   alignment: Alignment.topCenter,
            //   child: EventDate(eventDate),
            // )
          ],
        ),
      ),
    );
  }
}

class _EventDate extends StatelessWidget {
  final String data;
  const _EventDate({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 70,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      height: 20,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: HtpTheme.goldenColor)),
      child: Text(
        data,
        style: const TextStyle(fontSize: 10, color: Colors.white),
      ),
    );
  }
}

class OldBookings extends StatelessWidget {
  final String? imageName;
  final String eventTitle;
  final String date;
  final String place;
  final VoidCallback onTap;

  const OldBookings(
      {super.key,
      required this.imageName,
      required this.eventTitle,
      required this.date,
      required this.place,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 10),
        height: 97,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: imageName == null
                  ? const Image(
                      fit: BoxFit.cover,
                      height: 97,
                      width: 117,
                      image: AssetImage(
                        'assets/images/placeholders/placeholder_15.png',
                      ),
                    )
                  : Image.network(
                      imageName!,
                      height: 97,
                      width: 117,
                      fit: BoxFit.cover,
                    ),
            ),
            // SizedBox(
            //   height: 22,
            // ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            eventTitle,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Color(0xffe8d48a),
                              fontSize: 14,
                              // fontFamily: 'Montserrat'
                            ),
                          ),
                        ),
                        _EventDate(data: date)
                      ],
                    ),
                    // const SizedBox(
                    //   height: 19.5,
                    // ),
                    // Text(
                    //   date,
                    //   style: const TextStyle(color: Colors.white, fontSize: 13),
                    // ),
                    Expanded(
                      child: Row(
                        children: [
                          // const Icon(
                          //   Icons.location_on_sharp,
                          //   size: 17,
                          //   color: HtpTheme.goldenColor,
                          // ),
                          SvgPicture.asset(
                            'assets/svg/bottom_nav/location_f.svg',
                            height: 12,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            place,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              // fontFamily: 'Montserrat'
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Spacer(),
            // Align(
            //   alignment: Alignment.topCenter,
            //   child: Container(
            //     width: 70,
            //     height: 20,
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(5),
            //         border: Border.all(color: Color.fromARGB(255, 204, 188, 46))),
            //     child: Container(
            //       alignment: Alignment.center,
            //       child: Text(
            //         "12 Apr 2012",
            //         style: TextStyle(fontSize: 10, color: Colors.white),
            //       ),
            //     ),
            //   ),
            // ),
            const SizedBox(
              width: 5,
            ),
          ],
        ),
      ),
    );
  }
}
