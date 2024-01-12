import 'package:change_case/change_case.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:htp_customer/common/utils/member_utils.dart';
import 'package:htp_customer/common/widgets_common/app_bar_back_button.dart';
import 'package:htp_customer/common/widgets_common/needles_widget.dart';
import 'package:htp_customer/common/widgets_common/allbottom_sheets.dart';
import 'package:htp_customer/exception_handling/common_exceptions.dart';
import 'package:htp_customer/features/clubs/presentation/widgets/new/image_slideshow.dart';
import 'package:htp_customer/features/event/presentation/pages/event_booking.dart';
import 'package:htp_customer/features/event/presentation/widget/upcoming_events.dart';
import 'package:htp_customer/htp_theme.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../common/widgets_common/floatingSubmitButton.dart';
import '../../../../router.dart';
import '../../../clubs/presentation/widgets/new/floatingButtons.dart';
import '../../../membership/presentation/memberships.dart';
import '../../../profile/controller/profile_controller.dart';
import '../../data/models/event_model.dart';
import '../../data/services/events_services.dart';

final showMoreProvider = StateProvider<bool>((ref) {
  return true;
});

class EventDetails extends ConsumerWidget {
  static const route = '/event-details';
  const EventDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventId = ModalRoute.of(context)?.settings.arguments as String;

    // final favController = ref.watch(favProvider(eventId));

    // String firstHalf;
    // String secondHalf;

    // descriptionShowmore(String description) {
    //   if (description.length > 50) {
    //     firstHalf = description.substring(0, 50);
    //     secondHalf = description.substring(50, description.length);
    //   } else {
    //     firstHalf = description;
    //     secondHalf = "";
    //   }
    // }

    return FutureBuilder(
        future: ref.read(eventServiceProvider).getSingleEvent(eventId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            final EventModel eventData = snapshot.data!;

            final List<String> photos = [
              if (eventData.profileImage != null) eventData.profileImage!,
              ...eventData.photos
            ];

            return Scaffold(
              appBar: AppBar(
                leading: const AppbarBackButton(),
                title: Text(eventData.name.toUpperCase()),
                actions: [
                  IconButton(
                      onPressed: () {
                        FirebaseAnalytics.instance.logShare(
                            contentType: "Event Details",
                            itemId: eventData.id,
                            method: "Event");
                        Share.share('Upgrade your party game with Party One '
                            '- Your access to global nightlife '
                            'in town. \nCheck out - ${eventData.name}  and let the good times roll! Download the App: https://party.one/download-app');
                      },
                      icon: const Icon(Icons.share)),
                ],
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(alignment: Alignment.bottomCenter, children: [
                        (photos.isEmpty || photos.length == 1)
                            ? Padding(
                                padding: const EdgeInsets.only(bottom: 38.0),
                                child: photos.length == 1
                                    ? Image.network(
                                        photos.first,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        fit: BoxFit.cover,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.27,
                                      )
                                    : Image(
                                        image: AssetImage(
                                            'assets/images/placeholders/placeholder_15.png'),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        fit: BoxFit.cover,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.27,
                                      ),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 38.0,
                                ),
                                child:
                                    //  HorizontalScrollWithController(
                                    //   height:
                                    //       MediaQuery.of(context).size.height * 0.27,
                                    //   // arrowTopPosition: 80,
                                    //   scrollWidth:
                                    //       MediaQuery.of(context).size.width,
                                    //   itemCount: photos.length,
                                    //   itemBuilder: (context, index) {
                                    //     return Container(
                                    //       child: ClipRRect(
                                    //           child: Image(
                                    //         image: NetworkImage(photos[index]),
                                    //         width:
                                    //             MediaQuery.of(context).size.width,
                                    //         fit: BoxFit.cover,
                                    //         height:
                                    //             MediaQuery.of(context).size.height *
                                    //                 0.27,
                                    //       )),
                                    //     );
                                    //   },
                                    //   arrowIcon: false,
                                    // ),

                                    SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.40,
                                  child: ImageSlideshow(
                                    indicatorColor: HtpTheme.goldenColor,
                                    autoPlayInterval: 4000,
                                    children: [
                                      ...photos.map((e) => Image(
                                            image: NetworkImage(e),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            fit: BoxFit.fill,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                2,
                                          ))
                                    ],
                                  ),
                                )),
                        eventData.logo == null
                            ? const SizedBox()
                            : Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: CircleAvatar(
                                    radius: 44,
                                    backgroundImage: const AssetImage(
                                        // 'assets/images/profile-back.png'
                                        "assets/images/logoBg.png"),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image(
                                        image:
                                            NetworkImage("${eventData.logo}"),
                                        // AssetImage(
                                        //     'assets/images/temp/profile.png'),
                                        height: 80,
                                        width: 80,
                                        fit: BoxFit.cover,
                                      ),
                                    ))),
                      ]),

                      const SizedBox(
                        height: 16,
                      ),

                      //------------------------------- Events Details  -----------------------------------------
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              eventData.name.toTitleCase(),
                              style: tenor22Gold,
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Row(
                              children: [
                                Text(
                                  DateFormat('dd MMM yyyy')
                                      .format(eventData.eventData),
                                  // "Date",
                                  style: man14White,
                                ),
                                // if (eventData.club.distance != null)
                                //   Row(
                                //     children: [
                                //       const SizedBox(
                                //         width: 10,
                                //       ),
                                //       const Icon(
                                //         Icons.circle,
                                //         color: HtpTheme.lightBlueColor,
                                //         size: 6,
                                //       ),
                                //       const SizedBox(
                                //         width: 10,
                                //       ),
                                //       SvgPicture.asset(
                                //         "assets/svg/bottom_nav/location_f.svg",
                                //         height: 13,
                                //         color: HtpTheme.lightBlueColor,
                                //       ),
                                //       const SizedBox(
                                //         width: 4,
                                //       ),
                                //       Text(
                                //         // "${data.distance == null ? '' : '${data.distance} Km'} ",
                                //         "${eventData.club.distance} Km",
                                //         // '10 Km',
                                //         style: man14LightBlue,
                                //       ),
                                //     ],
                                //   ),
                              ],
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            Text(
                              eventData.club.address ?? '',
                              style: man14White,
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            const NeedleDoubleSided(),
                            const SizedBox(
                              height: 24,
                            ),

                            //---------------------------------Description----------------------------

                            const Text(
                              'About this Event',
                              style: tenor22LightBlue,
                            ),
                            const SizedBox(
                              height: 16,
                            ),

                            // showmore(eventData.description!),
                            showMorePopUp(eventData.description!),

                            const SizedBox(
                              height: 24,
                            ),
                            const NeedleDoubleSided(),
                            const SizedBox(
                              height: 24,
                            ),

                            //-----------------------------Fee anf Timing---------------------------
                            const Text(
                              'Entry fee & Timing',
                              style: tenor22LightBlue,
                            ),
                            const SizedBox(
                              height: 16,
                            ),

                            Row(
                              children: [
                                blackBox(
                                    'clock_grey.svg',
                                    DateFormat('E, dd MMM yyyy')
                                        .format(eventData.eventData),
                                    DateFormat('h:mm a')
                                        .format(eventData.eventData),
                                    false),
                                const SizedBox(
                                  width: 8,
                                ),
                                blackBox(
                                    'dollar_grey.svg',
                                    "\$ ${eventData.entryPerHead}",
                                    "Per Person",
                                    true)
                              ],
                            ),

                            const SizedBox(
                              height: 24,
                            ),
                            const NeedleDoubleSided(),
                            const SizedBox(
                              height: 24,
                            ),

                            const Text(
                              'Upcoming Events',
                              style: tenor22LightBlue,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                          ],
                        ),
                      ),
//--------------------------------Upcoming Events List-----------------------------
                      FutureBuilder(
                        future: ref
                            .watch(eventServiceProvider)
                            .getUpcomingEvents(eventId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: const CircularProgressIndicator(
                                  color: HtpTheme.goldenColor),
                            );
                          }
                          if (snapshot.hasError) {
                            debugPrint(snapshot.error.toString());
                          }
                          if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              snapshot.hasData) {
                            final events = snapshot.data;

                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  ...events!.map((event) => GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, EventDetails.route,
                                              arguments: event.id);
                                        },
                                        child: HorizontalUpcomingEvents(
                                          imageName: event.profileImage,
                                          logo: event.logo,
                                          eventTitle: event.name.toTitleCase(),
                                          date: event.eventData,
                                          description: event.description,
                                        ),
                                      ))
                                ],
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),

                      const SizedBox(
                        height: 120,
                      ),
                    ],
                  ),
                ),
              ),

              //-------------------------------Floating Buttons---------------------------------------
              floatingActionButton: Consumer(builder: (context, ref, child) {
                final profileController = ref.watch(profileControllerProvider);
                return FloatingSubmitButton(
                  onTap: () {
                    //  if(profileController.activeMembershipData?.id == '5557d9dd-53ff-499d-a037-c8881d9da732'){
                    //                           showDialog(
                    //                               context: context,
                    //                               useRootNavigator: true,
                    //                               builder: (context) {
                    //                                 return const PlanUpgradeDialog();
                    //                               });
                    //                         }else{
                    if (profileController is ProfileLoaded) {
                      final membershipType =
                          profileController.profileData.membershipType;

                      debugPrint(
                          "membership data -------------------------------- ${membershipType.name}");

                      if (membershipType == MembershipType.nonMember) {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: HtpTheme.darkBlue2Color,
                          builder: (context) => _buildMembership(context),
                        );
                      } else {
                        mainNavigatorKey.currentState?.push(MaterialPageRoute(
                            builder: (context) => EventBooking(
                                  data: eventData,
                                )));
                      }
                    }
                  },
                  text: 'Book Entry',
                );
              }),
            );
          }
          if (snapshot.hasError) {
            return Scaffold(
                appBar: AppBar(
                  leading: const AppbarBackButton(),
                ),
                body: Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.15),
                  child: const SomethingWrong(),
                ));
          }
          return const Center(
            child: CircularProgressIndicator(color: HtpTheme.goldenColor),
          );
        });
  }

  showmore(String description) {
    return Consumer(builder: (context, ref, child) {
      final showMoreFlag = ref.watch(showMoreProvider);

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          showMoreFlag
              ? Text(
                  description ?? '',
                  style: man14LightBlue,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                )
              : Text(
                  description ?? '',
                  style: man14LightBlue,
                ),
          if (description.length > 220)
            InkWell(
              onTap: () {
                ref.read(showMoreProvider.notifier).state = !showMoreFlag;
              },
              child: Text(
                showMoreFlag ? "Show more" : "Show less",
                style: man14Gold,
              ),
            ),
        ],
      );
    });
  }

  Widget showMorePopUp(String description) {
    return Consumer(builder: (context, ref, child) {
      // final showMoreFlag = ref.watch(showMoreProvider);

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            description ?? '',
            style: man14LightBlue,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
          if (description.length > 200)
            InkWell(
              onTap: () {
                // ref.read(showMoreProvider.notifier).state = !showMoreFlag;

                showModalBottomSheet(
                    context: context,
                    // isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) {
                      return BottomSheets.showMoreSheet(context, description);
                      // return Container(
                      //   margin: EdgeInsets.all(50),
                      //   height: 100,
                      //   width: 100,
                      //   // color: Colors.amber,
                      //   child: Container(
                      //     height: 100,
                      //     width: 100,
                      //     color: Colors.amber,
                      //   ),
                      // );
                    });
              },
              child: const Text(
                "Show more",
                style: man14Gold,
              ),
            ),
        ],
      );
    });
  }

  Widget blackBox(String path, String value, String type, bool isBig) {
    return Container(
      color: HtpTheme.darkBlue2Color,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12.0, 12.0, 16.0, 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 4,
            ),
            SvgPicture.asset(
              "assets/svg/icons/others/$path",
            ),
            const SizedBox(
              height: 12,
            ),
            // Text(
            //   "$value \n$type",
            //   style: man12White,
            // ),
            Text(
              "$value",
              style: isBig == true ? man13White : man12White,
            ),
            Text(
              "$type",
              style: man12White,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMembership(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0))),
        child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
            height: 24,
          ),
          Center(
            child: Container(
              width: 80,
              height: 3,
              color: HtpTheme.lightGreyColor,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Center(
            child: Image.asset(
              'assets/images/upgrade_to_book.png',
              width: MediaQuery.of(context).size.width * 0.92,
              height: MediaQuery.of(context).size.width * 0.3,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Text(
            'You are not a member yet!',
            style: tenor22White,
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Become a member to continue with the booking!',
            style: man14LightBlue,
          ),
          const SizedBox(
            height: 32,
          ),
          FloatingBlackButton(
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, MembershipsPage.route);
              },
              text: 'Become a Member'),
          const SizedBox(
            height: 48,
          ),
        ])));
  }
}
