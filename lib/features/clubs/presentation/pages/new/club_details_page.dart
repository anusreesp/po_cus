import 'package:change_case/change_case.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:htp_customer/common/utils/member_utils.dart';
import 'package:htp_customer/exception_handling/common_exceptions.dart';
import 'package:htp_customer/features/booking/presentation/pages/confirmation/entry_confirmation.dart';
import 'package:url_launcher/src/types.dart';
import 'package:htp_customer/common/utils/common_links.dart';
import 'package:htp_customer/common/widgets_common/app_bar_back_button.dart';
import 'package:htp_customer/common/widgets_common/needles_widget.dart';
import 'package:htp_customer/features/clubs/data/models/fire_club_details.dart';
import 'package:htp_customer/features/clubs/presentation/widgets/new/floatingButtons.dart';
import 'package:htp_customer/features/clubs/presentation/widgets/new/image_slideshow.dart';
import 'package:htp_customer/htp_theme.dart';
import 'package:htp_customer/features/profile/controller/profile_controller.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../../common/utils/time_converter.dart';
import '../../../../../common/widgets_common/map_display.dart';
import '../../../../booking/presentation/pages/entry_booking.dart';
import '../../../../booking/presentation/pages/table_booking.dart';
import '../../../../membership/presentation/memberships.dart';
import '../../../controllers/club_details_controller.dart';
import '../../../controllers/club_misc_data_controller.dart';
import '../../../data/services/club_services.dart';

import 'package:url_launcher/url_launcher.dart' as urlLauncher;

class ClubDetailsPage extends ConsumerWidget {
  static const route = '/clubdetails';

  const ClubDetailsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = ModalRoute.of(context)?.settings.arguments as String;

    // final profileController = ref.watch(profileControllerProvider);

    return FutureBuilder<FireClubDetails>(
      future: ref.read(clubServiceProvider).clubDetails(id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          final FireClubDetails snapData = snapshot.data!;

          List<String> sliderPhotos = [];
          List<String> photosList = [];
          for (final data in snapData.data.photos) {
            if (data is Map) {
              if (data['featured'] == true && data['status'] == 'Active') {
                sliderPhotos.add(data['url']);
              }
              //Show photo at bottom, change filter condition here
              photosList.add(data['url']);
            }
          }

          return Scaffold(
            appBar: AppBar(
              leading: const AppbarBackButton(),
              title: Text(snapData.data.name.toUpperCase()),
              actions: [
                IconButton(
                    onPressed: () {
                      FirebaseAnalytics.instance.logShare(
                          contentType: "Club Details",
                          itemId: snapData.data.id,
                          method: "Club");
                      Share.share('Upgrade your party game with Party One '
                          '- Your access to global nightlife '
                          'in town. \nCheck out - ${snapData.data.name} at ${snapData.data.address} and let the good times roll! Download the App: https://party.one/download-app');
                    },
                    icon: Icon(Icons.share)),

                //----------------- Favourite ---------------------
                Consumer(builder: (context, ref, _) {
                  final favController = ref.watch(favProvider(id));

                  return MaterialButton(
                    onPressed: () async {
                      if (favController == FavStates.fav) {
                        ref
                            .read(favProvider(snapData.data.id).notifier)
                            .deleteFav();
                      } else {
                        await ref
                            .read(favProvider(snapData.data.id).notifier)
                            .markFav(snapData.data);
                      }
                    },
                    child: favController != FavStates.fav
                        ? const Image(
                            image: AssetImage(
                                "assets/images/icons/heart_icon.png"),
                            height: 18,
                          )
                        : const Image(
                            image: AssetImage("assets/images/icons/heart.png"),
                            height: 18,
                          ),
                  );
                }),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //----------------------Image and Logo---------------------------
                      Container(
                        // width: MediaQuery.of(context).size.width,
                        child:
                            Stack(alignment: Alignment.bottomCenter, children: [
                          // if (sliderPhotos.isEmpty || sliderPhotos.length == 1)
                          // if (snapData.data.displayImage != null)
                          (sliderPhotos.isEmpty || sliderPhotos.length == 1)
                              ? Padding(
                                  padding: const EdgeInsets.only(bottom: 38.0),
                                  // child: Image(
                                  //     width: MediaQuery.of(context).size.width,
                                  //     fit: BoxFit.fitWidth,
                                  //     height: MediaQuery.of(context).size.height *
                                  //         0.27,
                                  // image: NetworkImage(
                                  //     snapData.data.displayImage!)
                                  // ),
                                  child: sliderPhotos.length == 1
                                      ? Image.network(
                                          sliderPhotos.first,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          fit: BoxFit.fitWidth,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.27,
                                        )
                                      : Image(
                                          image: const AssetImage(
                                              'assets/images/placeholders/placeholder_15.png'),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          fit: BoxFit.fitWidth,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.27,
                                        ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 38.0,
                                  ),
                                  child: ImageSlideshow(
                                    indicatorColor: HtpTheme.goldenColor,
                                    // featured: snapData.data.featured,
                                    autoPlayInterval: 4000,
                                    children: [
                                      ...sliderPhotos.map((e) {
                                        return Image(
                                          image: NetworkImage(e),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          fit: BoxFit.fill,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.27,
                                        );
                                      })
                                    ],
                                  )

                                  /* HorizontalScrollWithController(
                                    
                                    height: MediaQuery.of(context).size.height *
                                        0.27,
                                    // arrowTopPosition: 80,
                                    scrollWidth:
                                        MediaQuery.of(context).size.width,
                                    itemCount: sliderPhotos.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        child: ClipRRect(
                                            child: Image(
                                          image:
                                              NetworkImage(sliderPhotos[index]),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          fit: BoxFit.fitWidth,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.27,
                                        )),
                                      );
                                    },
                                    arrowIcon: false,
                                  ), */
                                  ),

                          if (snapData.data.featured ?? false)
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                height: 24,
                                width: 77,
                                decoration: const BoxDecoration(
                                    color: HtpTheme.goldColor),
                                child: Center(
                                    child: Text(
                                  "FEATURED",
                                  style:
                                      man10DarkBlue.apply(fontWeightDelta: 1),
                                )),
                              ),
                            ),

                          // Row(
                          //   children: [
                          // Padding(
                          //     padding: EdgeInsets.only(top: 12),
                          //     child: NeedleHorizontal(
                          //       thickness: 1,
                          //       width: MediaQuery.of(context).size.width *
                          //           0.65,
                          //     )),

                          //---------------------------------Club Logo ---------------------------------------------
                          Positioned(
                              bottom: 38,
                              left: 0,
                              child: NeedleHorizontal(
                                thickness: 1.2,
                                width: MediaQuery.of(context).size.width * 0.65,
                              )),

                          snapData.data.logo == null
                              ? SizedBox()
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
                                          image: NetworkImage(
                                              "${snapData.data.logo}"),
                                          // AssetImage(
                                          //     'assets/images/temp/profile.png'),
                                          height: 80,
                                          width: 80,
                                          fit: BoxFit.cover,
                                        ),
                                      ))),

                          //   ],
                          // ),
                        ]),
                      ),

                      const SizedBox(
                        height: 16,
                      ),

                      //----------------------------- CLUB details ------------------------------------
                      Text(
                        snapData.data.name.toTitleCase(),
                        style: tenor22White,
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      /* Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                // SvgPicture.asset(
                                //   "assets/svg/bottom_nav/location_f.svg",
                                //   height: 13,
                                //   color: HtpTheme.lightBlueColor,
                                // ),
                                // const SizedBox(
                                //   width: 4,
                                // ),
                                // snapData.data.distance != null
                                //     ? Text(
                                //         " ${snapData.data.distance} Km",
                                //         style: man14LightBlue,
                                //       )
                                //     : const Text(
                                //         " 0 Km",
                                //         style: man14LightBlue,
                                //       )
                              ],
                            ),
                            // const SizedBox(
                            //   width: 8,
                            // ),
                            // Ratings(
                            //   whiteText: true,
                            //   value: snapData.data.rating != null
                            //       ? "${snapData.data.rating}"
                            //       : "0",
                            // ),
                            const Spacer(),
                          ]), */

                      if (snapData.data.description != null ||
                          snapData.data.description.isNotEmpty)
                        Text(
                          // snapData.data.address ?? " ",
                          snapData.data.description,

                          style: man14White,
                        ),
                      SizedBox(
                        height: snapData.data.description != "" ? 30 : 0,
                      ),

                      // upcomingBooking(context, DateTime.now()),
                      // const SizedBox(
                      //   height: 10,
                      // ),

                      //------------------------Timing------------------------
                      FutureBuilder(
                          future: ref
                              .read(clubServiceProvider)
                              .getUpcomingBooking(snapData.data.id),
                          builder: (context, asyncSnapshot) {
                            if (asyncSnapshot.connectionState ==
                                    ConnectionState.done &&
                                asyncSnapshot.hasData) {
                              final List newBookingData = asyncSnapshot.data!;

                              debugPrint("${newBookingData.length}");

                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ...newBookingData.map((e) {
                                      debugPrint(
                                          "-----------------------------------eeeeeeeeeeeeeeeeeeeeeeeeee$e");
                                      final date = e['booking_date'].toDate();

                                      return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EntryConfirmation(
                                                            id: e['id'],
                                                            bookingType: e[
                                                                'booking_type'])));
                                          },
                                          child:
                                              upcomingBooking(context, date));
                                    })
                                  ],
                                ),
                              );
                            }
                            if (asyncSnapshot.hasError) {
                              return Center(
                                  child: Text(asyncSnapshot.error.toString()));
                            }

                            if (asyncSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(
                                    color: HtpTheme.goldenColor),
                              );
                            }

                            return const SizedBox.shrink();
                          }),

                      const SizedBox(
                        height: 16,
                      ),

                      labelWidget("assets/svg/icons/others/time.svg",
                          "We are open on", 160, 0),

                      const SizedBox(
                        height: 10,
                      ),

                      // FutureBuilder(
                      //     future: ref
                      //         .read(clubServiceProvider)
                      //         .ladiesClubList(snapData.data.id),
                      //     builder: (context, asyncSnapshot) {
                      //       if (snapshot.connectionState ==
                      //           ConnectionState.waiting) {
                      //         return const Center(
                      //           child: CircularProgressIndicator(),
                      //         );
                      //       }
                      //       if (snapshot.hasError) {
                      //         debugPrint(snapshot.error.toString());
                      //       }
                      //       if (snapshot.connectionState ==
                      //               ConnectionState.done &&
                      //           snapshot.hasData) {
                      //         final ladiesnight = asyncSnapshot.data;

                      //         List<String> daysList = [];

                      //         if (ladiesnight == null) {
                      //           daysList = [];
                      //         } else {
                      //           List<dynamic> days = ladiesnight['days'];

                      //           daysList = days.cast<String>();
                      //         }

                      //         return GridView.count(
                      //           physics: const NeverScrollableScrollPhysics(),
                      //           shrinkWrap: true,
                      //           crossAxisCount: 2,
                      //           childAspectRatio: 2.4,
                      //           children: [
                      //             for (final day in daysOfaWeek.entries)
                      //               slotDetails(context, snapData.data.schedule,
                      //                   day.value,
                      //                   // specialDays: snapData.data.ladiesNight
                      //                   specialDays: daysList),
                      //           ],
                      //         );
                      //       }
                      //       return const SizedBox.shrink();
                      //     }),

                      GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        childAspectRatio: 2.4,
                        children: [
                          for (final day in daysOfaWeek.entries)
                            slotDetails(
                                context, snapData.data.schedule, day.value,
                                // specialDays: snapData.data.ladiesNight
                                ladiesNightDays: snapData.data.ladiesNight),
                        ],
                      ),

                      Consumer(builder: (context, ref, child) {
                        final miscDataController =
                            ref.watch(clubMiscDataProvider(snapData.data.id));

                        if (miscDataController is ClubMisLoaded) {
                          if (miscDataController.closedDates.isEmpty) {
                            return const SizedBox.shrink();
                          } else {
                            return InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    builder: (context) =>
                                        bottomSheet(miscDataController)
                                    // NonWorkingDays(data: snapData.data)
                                    );
                              },
                              child: Column(
                                children: [
                                  Text(
                                    "See non-working days",
                                    style: man14Gold.merge(const TextStyle(
                                      decoration: TextDecoration.underline,
                                    )),
                                  ),
                                  const SizedBox(
                                    height: 32,
                                  ),
                                ],
                              ),
                            );
                          }
                        }
                        return const SizedBox.shrink();
                      }),

                      labelWidget("assets/svg/icons/others/tshirt.svg",
                          "Dress code", 200, 0),

                      const SizedBox(
                        height: 10,
                      ),

                      Row(
                        children: [
                          const SizedBox(
                            width: 32,
                          ),
                          // Text(
                          //   snapData.data.dress?.toTitleCase() ??
                          //       'Smart Casual and Closed Footwear',
                          //   style: man14White,
                          // ),

                          Expanded(
                            child: MarkdownBody(
                              // shrinkWrap: true,
                              // physics: const NeverScrollableScrollPhysics(),
                              data: snapData.data.dress?.toTitleCase() ??
                                  'Smart Casual and Closed Footwear',
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 16,
                      ),
                      labelWidget("assets/svg/icons/location/location_gold.svg",
                          " We are at", 215, 21),

                      const SizedBox(
                        height: 10,
                      ),

                      Row(
                        children: [
                          const SizedBox(
                            width: 32,
                          ),
                          Expanded(
                            child: Text(
                              snapData.data.address,
                              style: man14White,
                            ),
                          ),
                        ],
                      ),

                      //-------------------------Map------------------------
                      Container(
                          height: 320,
                          padding: const EdgeInsets.only(
                              bottom: 18, top: 28, right: 4),
                          child: MapDisplay(
                              lat: snapData.data.latitude ?? 0,
                              lng: snapData.data.longitude ?? 0,
                              title: snapData.data.name)),

                      const SizedBox(
                        height: 32,
                      ),

                      const Text(
                        'Terms and Conditions',
                        style: tenor22White,
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

                      const SizedBox(
                        height: 12,
                      ),

                      ///------------------------------------Terms of service content here------------------------------------------

                      const Text(
                        'Club Terms and Conditions',
                        style: man14White,
                      ),
                      const SizedBox(
                        height: 12,
                      ),

                      // Text(
                      //   snapData.data.termsAndConditions,
                      //   style: man14LightBlue,
                      // ),

                      Markdown(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                          data: snapData.data.termsAndConditions),
                      const SizedBox(
                        height: 90,
                      ),
                    ]),
              ),
            ),
            floatingActionButton: Consumer(builder: (context, ref, child) {
              final profileController = ref.watch(profileControllerProvider);
              return FloatingButtons(
                blackButtonFunc: () {
                  // if (profileController.activeMembershipData.id ==
                  //     '5557d9dd-53ff-499d-a037-c8881d9da732') {
                  //   showDialog(
                  //       context: context,
                  //       useRootNavigator: true,
                  //       builder: (context) {
                  //         return const PlanUpgradeDialog();
                  //       });
                  // } else {
                  //   Navigator.pushNamed(context, EntryBooking.route,
                  //       arguments: data);
                  // mainNavigatorKey.currentState?.push(MaterialPageRoute(builder: (context) => EntryBooking(data: data.data,)));
                  // }

                  //   ----- Check the membership type is not null
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EntryBooking(
                                    // snapData: snapData,
                                    data: snapData.data,
                                  )));
                    }
                  }
                },
                blackButtonText: 'Book Entry',
                goldenButtonFunc: () {
                  //Check if plan is silver
                  /*  if (profileController.activeMembershipData?.id ==
                        '5557d9dd-53ff-499d-a037-c8881d9da732') {
                      showDialog(
                          context: context,
                          useRootNavigator: true,
                          builder: (context) {
                            return const PlanUpgradeDialog();
                          });
                    } else { */

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
                      Navigator.pushNamed(context, TableBookingPage.route,
                          arguments: snapData.data);
                      // mainNavigatorKey.currentState?.push(MaterialPageRoute(builder: (context) => TableBookingPage(data: data.data,)));
                      // }

                      // Navigator.pushNamed(context,
                      //     TableBookingPage.route, arguments: data.single);
                    }
                  }
                },
                goldenButtonText: 'Book a Table',
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

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: const CircularProgressIndicator(color: HtpTheme.goldenColor),
          );
        }
        return const SizedBox.shrink();
      },
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

  Widget labelWidget(String iconPath, String label, double width, double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SvgPicture.asset(
          iconPath,
          height: size == 0 ? 18 : size,
          width: size == 0 ? 18 : size,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          label,
          style: tenor22LightBlue,
        ),
        const SizedBox(
          width: 8,
        ),
        NeedleHorizontal(
          width: width,
        ),
      ],
    );
  }

  Widget slotDetails(
      BuildContext context, Map<String, dynamic>? schedule, String day,
      {List<String>? ladiesNightDays}) {
    if (schedule?[day] == null) {
      return const SizedBox.shrink();
    }

    for (var i = 0; i < ladiesNightDays!.length; i++) {}

    bool isSpecial = ladiesNightDays.contains(day);

    return Container(
        height: 50,
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  day,
                  style: man14LightBlue,
                ),
                Text(
                  '${timeConverter(schedule![day]?['from_time'], context)} - ${timeConverter(schedule[day]?['to_time'], context)}',
                  style: man14White,
                ),

                //------------------------------  Special night  --------------------------------

                if (schedule[day]?['title'] != null &&
                    schedule[day]?['title'] != "")
                  Container(
                    width: 160,
                    child: Text(
                      schedule[day]!['title'].toString().toTitleCase(),
                      overflow: TextOverflow.ellipsis,
                      style: man12Gold,
                    ),
                  ),

                Text(
                  isSpecial ? 'Ladies Night' : '',
                  style: man12Gold,
                ),
                if (schedule[day]?['title'] != null && isSpecial == true)
                  SizedBox(
                    height: 6,
                  )
              ],
            ),
          ],
        ));
  }

  Widget upcomingBooking(BuildContext context, DateTime date) {
    final formattedDate = DateFormat('d MMM, yyyy').format(date);

    return Row(
      children: [
        Container(
          color: HtpTheme.darkBlue2Color,
          width: MediaQuery.of(context).size.width * 0.77,
          height: 70,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "You have an upcoming booking",
                      style: man12LightBlue,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      formattedDate,
                      style: man14White,
                    )
                  ],
                ),
                const Spacer(),
                SvgPicture.asset("assets/svg/icons/arrow/arrow_grey.svg")
              ],
            ),
          ),
        ),
        SizedBox(
          width: 20,
        )
      ],
    );
  }

  bottomSheet(ClubMisLoaded data) {
    // return Consumer(builder: (context, ref, _) {
    //   final miscDataController = ref.watch(clubMiscDataProvider(data.id));

    Map<String, List<DateTime>> holidayMap = {};

    //   if (miscDataController is ClubMisLoaded) {
    //     List<DateTime> holidays = miscDataController.closedDates;

    List<DateTime> holidays = data.closedDates;

    final today = DateTime.now();

    for (final data in holidays) {
      final monthName = DateFormat('MMM').format(data);
      if (holidayMap.containsKey(monthName)) {
        holidayMap[monthName] = [...holidayMap[monthName]!, data];
      } else {
        holidayMap[monthName] = [data];
      }
    }
    int count = holidayMap.length;

    return Container(
      decoration: const BoxDecoration(
          color: HtpTheme.darkBlue2Color,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0))),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SingleChildScrollView(
        child: Column(
          children: [
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
            Row(
              children: [
                Text(
                  "Non-working days",
                  style: tenor22White.merge(
                      const TextStyle(wordSpacing: -2, letterSpacing: -1.7)),
                ),
                Spacer(),
              ],
            ),

            const SizedBox(
              height: 30,
            ),
            // ...holidays.map((e) => Column(

            // holidayMap.map((key, value) {
            //   return Container();
            // }),

            ...holidayMap.values.map((List<DateTime> val) {
              final month = val.first;

              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('MMM').format(month),
                        style: man14LightBlue,
                      ),
                      const Spacer(),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            ...val.map((date) => Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 8.0,
                                ),
                                child: Text(
                                    DateFormat('E, d MMM, yyyy').format(date))))
                          ]),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: NeedleDoubleSided(),
                  )
                ],
              );
            }),
          ],
        ),
      ),
    );
    //   }
    //   return const SizedBox.shrink();
    // });
  }
}
