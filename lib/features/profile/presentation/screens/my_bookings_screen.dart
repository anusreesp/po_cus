import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:htp_customer/common/widgets_common/app_bar_back_button.dart';
import 'package:htp_customer/common/widgets_common/needles_widget.dart';
import 'package:htp_customer/common/widgets_common/outlined_black_button.dart';
import 'package:htp_customer/features/booking/presentation/pages/confirmation/entry_confirmation.dart';
import 'package:htp_customer/features/dashboard/controllers/dashboard_controllers.dart';
import 'package:htp_customer/features/profile/controller/my_booking_controller.dart';
import 'package:htp_customer/features/profile/data/models/booking_details.dart';
import 'package:htp_customer/features/profile/data/services/profile_services.dart';
import 'package:htp_customer/features/profile/presentation/widgets/booking_sort.dart';
import 'package:htp_customer/htp_theme.dart';
import 'package:intl/intl.dart';

class MyBookingsScreen extends ConsumerWidget {
  static const route = 'my-bookings';
  MyBookingsScreen({Key? key}) : super(key: key);
  List<BookingData> filteredEvents = [];
  List<BookingData> filteredClubs = [];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(myBookingStatus);
    return Scaffold(
        appBar: AppBar(
            title: const Text(
              "MY BOOKINGS",
            ),
            leading: AppbarBackButton()),
        body: Consumer(
          builder: (context, ref, child) {
            final myBookingController = ref.watch(myBookingProvider);

            if (myBookingController is MyBookingLoaded) {
              final dataList = myBookingController.result;
              return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(children: [
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                ref.read(myBookingStatus.notifier).state =
                                    MyBookingStatus.all;
                              },
                              child: Text("All",
                                  style: status == MyBookingStatus.all
                                      ? man14Gold
                                      : man14LightBlue)),
                          SizedBox(
                            width: 29,
                          ),
                          GestureDetector(
                            onTap: () {
                              ref.read(myBookingStatus.notifier).state =
                                  MyBookingStatus.clubs;
                            },
                            child: Text(
                              "Clubs",
                              style: status == MyBookingStatus.clubs
                                  ? man14Gold
                                  : man14LightBlue,
                            ),
                          ),
                          const SizedBox(
                            width: 29,
                          ),
                          GestureDetector(
                              onTap: () {
                                ref.read(myBookingStatus.notifier).state =
                                    MyBookingStatus.events;
                              },
                              child: Text("Events",
                                  style: status == MyBookingStatus.events
                                      ? man14Gold
                                      : man14LightBlue)),
                          const Spacer(),
                          const Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: BookingSort(),
                          )
                        ],
                      ),
                    ),

                    //----------------------------Listing------------------------------

                    if (status == MyBookingStatus.all)
                      Expanded(
                        child: dataList.length != 0
                            ? ListView.builder(
                                // itemCount: data.length,
                                itemCount: dataList.length,
                                itemBuilder: (context, index) {
                                  return mybookingLists(
                                      context, dataList, index);
                                })
                            : noBooking('all'),
                      ),
                    if (status == MyBookingStatus.clubs)
                      Expanded(
                        child: dataList.length != 0
                            ? ListView.builder(
                                // itemCount: data.length,
                                itemCount: dataList.length,
                                itemBuilder: (context, index) {
                                  return mybookingLists(
                                      context, dataList, index);
                                })
                            : noBooking('clubs'),
                      ),
                    if (status == MyBookingStatus.events)
                      Expanded(
                        child: dataList.length != 0
                            ? ListView.builder(
                                // itemCount: data.length,
                                itemCount: dataList.length,
                                itemBuilder: (context, index) {
                                  return mybookingLists(
                                      context, dataList, index);
                                })
                            : noBooking('events'),
                      )
                  ]));
            } else {
              return const Center(
                child: CircularProgressIndicator(color: HtpTheme.goldenColor),
              );
            }
          },
        ));
  }

  Widget mybookingLists(
      BuildContext context, List<BookingData> datas, int index) {
    return MyBookingTile(
      data: datas[index],
      imgUrl: datas[index].clubImage ?? datas[index].eventImage ?? "",
      location: datas[index].clubLocation ?? '',
      title: datas[index].clubName ?? datas[index].eventName!,
      date: DateFormat('EEE, dd MMM, yyyy').format(datas[index].bookingDate),
      time: datas[index].expectedArrivalTime?.toUpperCase() ??
          DateFormat('hh:mm a').format(datas[index].bookingDate) +
              " " +
              datas[index].countryTimeZone,
      // time: format.,
      // isClub: data[index].bookingType ==
      //         'event_entry_booking'
      //     ? false
      //     : true,
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EntryConfirmation(
                    id: datas[index].id,
                    bookingType: datas[index].bookingType)));
      },
    );
  }

  Widget noBooking(String type) {
    return Consumer(builder: (context, ref, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 32,
            width: MediaQuery.of(context).size.width,
          ),
          Container(
            width: 280,
            child: Text(
              (type == 'clubs')
                  ? "You have not made any bookings yet. Explore top clubs around the world for an unforgettable night!"
                  : (type == 'events')
                      ? "You have not made any bookings yet. Explore exclusive events around the world for an unforgettable night!"
                      : "You have not made any bookings yet. Explore clubs and events for an unforgettable night!",
              style: man14LightBlue,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          OutlinedBlackButton(
              onTap: () {
                Navigator.popUntil(context, (route) => route.isFirst);

                if (type == 'events') {
                  ref
                      .read(dashboardProvider.notifier)
                      .selectTab(TabItem.events);
                } else {
                  ref.read(dashboardProvider.notifier).selectTab(TabItem.clubs);
                }
              },
              child: Center(
                // child: Text("Explore clubs nearby"),
                child: Text(
                    'Explore ${(type == "events") ? type : "clubs"} nearby'),
              )),
        ],
        // )
      );
    });
  }
}

class MyBookingTile extends StatelessWidget {
  final BookingData data;
  final String title;
  final String location;
  final String date;
  final String time;
  // final bool isClub;
  final String imgUrl;
  final GestureTapCallback onTap;
  const MyBookingTile({
    Key? key,
    required this.data,
    required this.title,
    // required this.isClub,
    required this.date,
    required this.time,
    required this.imgUrl,
    required this.location,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todayTemp = DateTime.now();
    final today = DateTime(todayTemp.year, todayTemp.month, todayTemp.day);

    bool isPastDate = data.bookingDateOnly.isBefore(today);

    final statusData = isPastDate
        ? bookingStatusIcon('Completed')
        : bookingStatusIcon(data.status);

    bool isClub = data.bookingType != 'event_entry_booking';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 160,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(
              height: 27,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            const AssetImage("assets/images/logoBg.png"),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: imgUrl != ""
                              ? Image(
                                  image: NetworkImage(imgUrl),
                                  height: 57,
                                  width: 57,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'assets/images/placeholders/placeholder_11.png'),
                        ))),
                SizedBox(
                  width: 18,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: Text(
                        title,
                        style: tenor16White,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    RichText(
                        text: TextSpan(
                            text: isClub ? "CLUB" : "EVENT",
                            style: man14LightGrey,
                            children: [
                          TextSpan(text: "  |  ", style: man14LightGrey),
                          TextSpan(text: location, style: man14LightGrey),
                        ])),
                    SizedBox(
                      height: 6,
                    ),
                    Row(
                      children: [
                        Text(date, style: man14White),
                        SizedBox(
                          width: 8,
                        ),
                        Container(
                          height: 6,
                          width: 6,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: HtpTheme.lightBlueColor),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(time, style: man14White),
                      ],
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(statusData[0]),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(statusData[1], style: man14White),
                      ],
                    ),
                    const SizedBox(
                      height: 27,
                    ),
                  ],
                )
              ],
            ),
            NeedleDoubleSided()
          ],
        ),
      ),
    );
  }

  bookingStatusIcon(String? status) {
    switch (status) {
      case "Approved":
        return ["assets/svg/icons/my_bookings/upcoming_icon.svg", "Upcoming"];
      case "Payment success":
        return ["assets/svg/icons/my_bookings/upcoming_icon.svg", "Upcoming"];
      case "Completed":
        return ["assets/svg/icons/my_bookings/past_icon.svg", "Past"];
      case "Payment link sent":
        return [
          "assets/svg/icons/my_bookings/underreview_icon.svg",
          "Under Review"
        ];
      case "Booking request pending":
        return [
          "assets/svg/icons/my_bookings/underreview_icon.svg",
          "Under Review"
        ];
      case "Pending":
        return [
          "assets/svg/icons/my_bookings/underreview_icon.svg",
          "Under Review"
        ];
      case "Waiting for approval":
        return [
          "assets/svg/icons/my_bookings/underreview_icon.svg",
          "Under Review"
        ];
      case "Waiting for payment verification":
        return [
          "assets/svg/icons/my_bookings/underreview_icon.svg",
          "Under Review"
        ];
      case "Rejected":
        return [
          "assets/svg/icons/my_bookings/failed_icon.svg",
          "Booking Failed"
        ];
      case "Cancelled":
        return [
          "assets/svg/icons/my_bookings/failed_icon.svg",
          "Booking Failed"
        ];
      default:
        return [
          "assets/svg/icons/my_bookings/underreview_icon.svg",
          "Under Review"
        ];
    }
  }
}
