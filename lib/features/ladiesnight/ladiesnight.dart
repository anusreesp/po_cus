import 'package:change_case/change_case.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:htp_customer/features/clubs/presentation/pages/new/club_details_page.dart';
import 'package:htp_customer/features/ladiesnight/controllers/ladiesnightclub.dart';
import 'package:htp_customer/features/ladiesnight/widget/weekdays.dart';
import 'package:htp_customer/htp_theme.dart';
import '../../common/widgets_common/app_bar_back_button.dart';
import '../../exception_handling/club_exceptions.dart';
import '../clubs/presentation/widgets/new/club_image.dart';
import 'controllers/ladiesnight_controller.dart';
import 'data/models/ladiesclub_response.dart';

class LadiesNight extends ConsumerWidget {
  static const route = '/ladiednight';
  const LadiesNight({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(ladiesNightProvider);

    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   onPressed: () => Navigator.pop(context),
        //   icon: SvgPicture.asset(
        //     "assets/svg/icons/arrow/sidearrow.svg",
        //     height: 12,
        //     width: 12,
        //   ),
        // ),
        leading: const AppbarBackButton(),
        title: Text(
          'Select a day for Ladies Night',
          style: tenor22White.merge(TextStyle(
              color: HtpTheme.whiteColor.withOpacity(0.7), wordSpacing: -4)),
        ),
      ),
      body: buildBody(
        context,
        controller,
      ),
    );
  }

  Widget buildBody(
    BuildContext context,
    LadiesNightStates controller,
    // List<LadiesNightData> ladiesNightClubs
  ) {
    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(children: [
              const SizedBox(
                height: 12,
              ),
              WeekDays(),
              const SizedBox(
                height: 48,
              ),

              /*  if (controller is LadiesNightLoaded &&
                  controller.ladiesNight.isNotEmpty)
                // ...controller.ladiesNight.map((e) => LadiesNightCard(data: e)
                // ),
              
              if (controller is LadiesNightLoaded &&
                  controller.ladiesNight.isEmpty)
                const ClubNotFoundExceptions(),
              if (controller is LadiesNightLoading)
                Center(child: const CircularProgressIndicator()),
              if (controller is LadiesNightError)
                const ClubTryAgainExceptions(), */

              Consumer(
                builder: (context, ref, _) {
                  final clubController = ref.watch(ladiesNightClubProvider);

                  return clubController.when(data: (data) {
                    return Column(
                      children: [
                        ...data.map((e) => LadiesNightCard(
                              data: e,
                              onTap: () {
                                FirebaseAnalytics.instance.logSelectItem(
                                    itemListId: e.id, itemListName: e.name);
                                Navigator.pushNamed(
                                    context, ClubDetailsPage.route,
                                    arguments: e.id);
                              },
                            ))
                      ],
                    );
                  }, error: (error, _) {
                    return const ClubTryAgainExceptions();
                  }, loading: () {
                    return const Center(
                      child: const CircularProgressIndicator(color: HtpTheme.goldenColor),
                    );
                  });
                },
              ),
            ])));
  }
}

class LadiesNightCard extends StatelessWidget {
  final VoidCallback? onTap;
  final LadiesNightData data;
  LadiesNightCard({super.key, this.onTap, required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Column(
          children: [
            ClubImage(
              featured: data.featured,
              displayImage: data.displayImage,
              logo: data.logo,
            ),

            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Text(
                      data.name.toTitleCase(),
                      overflow: TextOverflow.ellipsis,
                      // softWrap: true,
                      style: tenor22LightBlue,
                    ),
                  ),
                ),
                // const SizedBox(
                //   width: 6,
                // ),
                // const Spacer(),

                Padding(
                  padding: const EdgeInsets.only(right: 10.0, top: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset("assets/svg/icons/arrow/arrow.svg"),
                      // Icon(
                      //   Icons.arrow_forward,
                      //   size: 20,
                      // ),
                      SizedBox(height: 4, width: 2),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),

            //--------------------Distance and rating----------------------------
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                width: 8,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/svg/bottom_nav/location_f.svg",
                    height: 13,
                    color: HtpTheme.lightBlueColor,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  data.distance != null
                      ? Text(
                          " ${data.distance} Km",
                          style: man14LightBlue,
                        )
                      : const Text(
                          " 0 Km",
                          style: man14LightBlue,
                        )
                ],
              ),
              // const SizedBox(
              //   width: 8,
              // ),
              // Ratings(
              //   whiteText: true,
              //   value: data.rating != null ? "${data.rating}" : "0",
              // ),
              const Spacer(),
            ]),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }
}
