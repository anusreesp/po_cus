import 'package:change_case/change_case.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:htp_customer/features/event/controllers/eventlist_controller.dart';
import 'package:htp_customer/features/event/controllers/events_filterlist_controller.dart';
import 'package:htp_customer/features/event/presentation/widget/event_image.dart';
import 'package:htp_customer/htp_theme.dart';
import 'package:intl/intl.dart';

import '../../../../exception_handling/event_exceptions.dart';
import '../../../dashboard/presentation/widgets/custom_app_bar.dart';
import '../../data/models/event_list_response.dart';
import '../widget/events_filter.dart';
import 'events_details.dart';

class EventsPage extends StatelessWidget {
  static const route = '/events';
  final GlobalKey<ScaffoldState>? dashBoardScaffoldKey;
  const EventsPage({super.key, this.dashBoardScaffoldKey});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: SearchTitle(
          titleWidget: const Text('EVENTS'),
          dashboardScaffoldKey: dashBoardScaffoldKey,
        ),
      ),
      body: buildBody(
        context,
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Consumer(builder: (context, ref, _) {
            final eventController = ref.watch(eventsListApiProvider);
            final eventFilteredController = ref.watch(eventsFilterListProvider);

            return Column(children: [
              const Row(
                children: [Spacer(), EventsFilter()],
              ),

              // return eventController.when(data: (data) {
              //   if (data.isEmpty) {
              //     return const EventNotFoundExceptions();
              //   }
              //   return Column(children: [
              //     ...data.map(
              //       (val) => listTiles(val, context),
              //     )
              //   ]);
              // }, error: (Object error, _) {
              //   return EventTryAgainExceptions(msg: error.toString());
              // }, loading: () {
              //   return const Center(
              //     child: CircularProgressIndicator(),
              //   );
              // });

              if (eventController is EventsListApiLoaded &&
                  eventController.events.isNotEmpty)
                ...eventFilteredController.map((e) => listTiles(e, context)),
              if ((eventController is EventsListApiLoaded &&
                      eventController.events.isEmpty) ||
                  eventFilteredController.isEmpty ||
                  eventController is EventsListApiError)
                const EventNotFoundExceptions(),

              if (eventController is EventsListApiLoading)
                const CircularProgressIndicator(color: HtpTheme.goldenColor),
              // if (eventController
              //         is EventsListApiError /* ||
              //     eventFilteredController.isEmpty */
              //     )
              //   const EventTryAgainExceptions(
              //     msg: 'No Events Found',
              //   ),

              // listTiles(context),
              SizedBox(
                height: 80,
              )
            ]);
          })),
    );
  }

  Widget listTiles(EventDataApi data, BuildContext context) {
    return GestureDetector(
      onTap: () {
        FirebaseAnalytics.instance.logSelectItem(itemListId: data.id, itemListName: data.name);
        Navigator.pushNamed(context, EventDetails.route, arguments: data.id);
      },
      child: Column(children: [
        Container(
          // padding: const EdgeInsets.only(bottom: 16),
          decoration: const BoxDecoration(
            color: HtpTheme.darkBlue2Color,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.24,
              //   width: MediaQuery.of(context).size.width,
              //   child: data.displayImage != null
              //       ? Image(
              //           fit: BoxFit.cover,
              //           width: MediaQuery.of(context).size.width,
              //           image: NetworkImage(data.displayImage!))
              //       : const Image(
              //           image: AssetImage(
              //               'assets/images/placeholders/placeholder_15.png'),
              //           fit: BoxFit.cover,
              //         ),
              // ),
              EventImage(data: data),

              const SizedBox(
                height: 16,
              ),

              //-----------------Name

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  data.name.toTitleCase() ?? 'Name',
                  overflow: TextOverflow.ellipsis,
                  style: tenor16Gold,
                ),
              ),

              //-----------------Description

              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Text(
                    data.description ?? "Description right here...",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: man14LightBlue,
                  )),

              //-----------------Date and Location

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Row(
                  children: [
                    Text(
                      DateFormat('dd MMM yyyy').format(data.dateAndTime),
                      // "Date",
                      style: man14White,
                    ),
                    if (data.distance != null)
                      Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(
                            Icons.circle,
                            color: HtpTheme.lightBlueColor,
                            size: 6,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SvgPicture.asset(
                            "assets/svg/bottom_nav/location_f.svg",
                            height: 13,
                            color: HtpTheme.lightBlueColor,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            // "${data.distance == null ? '' : '${data.distance} Km'} ",
                            "${data.distance} Km",
                            // '10 Km',
                            style: man14LightBlue,
                          ),
                        ],
                      ),
                    Spacer(),
                    SvgPicture.asset("assets/svg/icons/arrow/arrow.svg"),
                  ],
                ),
              ),

              const SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 24,
        ),
      ]),
    );
  }
}
