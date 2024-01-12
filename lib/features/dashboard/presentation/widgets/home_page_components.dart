import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:htp_customer/features/clubs/data/models/club_list_api_response.dart';
import 'package:htp_customer/features/clubs/presentation/pages/new/club_details_page.dart';
import 'package:htp_customer/features/dashboard/spacing_values.dart';
import 'package:htp_customer/features/event/data/models/event_list_response.dart';
import 'package:htp_customer/features/profile/presentation/screens/loyalty_points.dart';
import 'package:intl/intl.dart';

import '../../../../common/utils/member_utils.dart';
import '../../../../common/widgets_common/needles_widget.dart';
import '../../../../htp_theme.dart';
// import '../../../clubs/presentation/pages/club_details_old.dart';
import '../../../event/presentation/pages/events_details.dart';
import '../../../profile/controller/profile_controller.dart';

class PictureButton extends StatelessWidget {
  final String imagePath;
  final VoidCallback onTap;
  final String title;
  const PictureButton(
      {super.key,
      required this.imagePath,
      required this.onTap,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: leftDashboardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  // borderRadius: BorderRadius.circular(6),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8)),
                  child: Image.asset(
                    imagePath,
                    height: 135,
                    width: 170,
                    fit: BoxFit.cover,
                  ),
                ),
                const Positioned(
                    bottom: 0,
                    child: Padding(
                      padding: EdgeInsets.only(left: 1.0),
                      child: NeedleHorizontal(
                        thickness: 1.5,
                        width: 170,
                      ),
                    ))
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title),
                // const SizedBox(
                //   width: 6,
                // ),
                // SvgPicture.asset(
                //   'assets/svg/arrow_splashscreen.svg',
                //   color: HtpTheme.goldColor,
                // )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CampaignCardSpock extends StatelessWidget {
  final String title;
  final String description;
  final Widget bottomWidget;
  final String? backgroundImage;
  const CampaignCardSpock(
      {super.key,
      required this.title,
      required this.description,
      required this.bottomWidget,
      this.backgroundImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 310,
      width: 310,
      padding: const EdgeInsets.all(22),
      margin: const EdgeInsets.symmetric(horizontal: leftDashboardPadding - 7),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(6),
        image: backgroundImage != null
            ? DecorationImage(
                image: AssetImage(backgroundImage!), fit: BoxFit.fill)
            : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: tenor22Gold,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 22.0),
            child: Text(
              description,
              style: man16White,
            ),
          ),
          bottomWidget
        ],
      ),
    );
  }
}

class EventCardSpock extends StatelessWidget {
  final EventDataApi data;
  const EventCardSpock({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, EventDetails.route, arguments: data.id);
      },
      child: Container(
        width: 240,
        height: 290,
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(6)),
        margin: const EdgeInsets.only(left: 12,right: 5),
        child: Column(
          children: [
            data.displayImage != null
                ? ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(6),
                        topLeft: Radius.circular(6)),
                    child: Image.network(
                      data.displayImage!,
                      height: 200,
                      width: 240,
                      fit: BoxFit.fill,
                    ),
                  )
                : Image.asset(
                    'assets/images/placeholders/placeholder_15.png',
                    height: 200,
                    fit: BoxFit.cover,
                  ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    Text(
                      data.name,
                      style: tenor16Gold,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          DateFormat('d MMM yyyy').format(data.dateAndTime),
                          style: man14White,
                        ),
                        const Spacer(),
                        if (data.distance != null)
                          SvgPicture.asset(
                            'assets/svg/icons/dashboard/location.svg',
                            height: 14,
                          ),
                        const SizedBox(
                          width: 4,
                        ),
                        if (data.distance != null)
                          Text(
                            '${data.distance} Km',
                            style: man14LightBlue,
                          )
                      ],
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ClubCardSpock extends StatelessWidget {
  final ClubDataNew data;
  const ClubCardSpock({super.key, required this.data});

  final _cardImageHeight = 300.0;
  final _cardWidth = 276.0;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  const EdgeInsets.only(right: 4),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, ClubDetailsPage.route,
              arguments: /* "Arguments from HOME: 12334" */ data.id);
        },
        // child: Padding(
        //   padding: const EdgeInsets.only(left: leftDashboardPadding),
        child: ClipRRect(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: _cardWidth,
                    height: _cardImageHeight,
                    child: data.displayImage != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              data.displayImage!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Image.asset(
                            'assets/images/placeholders/placeholder_15.png'),
                  ),
                  if (data.featured == true)
                    Positioned(
                      right: 0,
                      child: Container(
                        height: 24,
                        width: 80,
                        color: HtpTheme.goldColor,
                        child: const Center(
                            child: Text(
                          'FEATURED',
                          style: man10DarkBlue,
                        )),
                      ),
                    ),
                  if (data.logo != null)
                    Positioned(
                      bottom: 22,
                      left: 18,
                      child: Container(
                        height: 54,
                        width: 54,
                        padding: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: HtpTheme.goldColor),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            data.logo!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  Positioned(
                      bottom: 0,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 6.0),
                        child: NeedleHorizontal(
                          thickness: 1.5,
                          width: _cardWidth,
                        ),
                      ))
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0, left: 12),
                child: SizedBox(
                    width: _cardWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.name,
                              style: tenor22LightBlue,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (data.distance != null)
                                  SvgPicture.asset(
                                    "assets/svg/icons/dashboard/location.svg",
                                    height: 12,
                                  ),
                                const SizedBox(
                                  width: 4,
                                ),
                                if (data.distance != null)
                                  Text(
                                    '${data.distance} Km',
                                    style: man14LightGrey,
                                  ),
                              ],
                            )
                          ],
                        ),
                      ],
                    )),
              )
            ],
          ),
        ),
        // ),
      ),
    );
  }
}

class HorizontalTextButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final EdgeInsets padding;
  final String? ctaText;

  const HorizontalTextButton(
      {super.key,
      required this.title,
      this.onTap,
      this.padding = const EdgeInsets.fromLTRB(leftDashboardPadding, 34, 8, 12),
      this.ctaText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SizedBox(
        height: 40,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: tenor22LightBlue,
            ),
            const SizedBox(
              width: 8,
            ),
            const Expanded(
                child: NeedleHorizontal(
              width: double.infinity,
              thickness: 1,
            )),
            if (onTap != null)
              TextButton(
                  onPressed: onTap,
                  child: Text(
                    ctaText ?? 'Explore all',
                    style: man14Gold,
                  ))
          ],
        ),
      ),
    );
  }
}

class LoyaltySection extends ConsumerWidget {
  const LoyaltySection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileController = ref.watch(profileControllerProvider);

    if (profileController is ProfileLoaded) {
      final pData = profileController.profileData;
      if (pData.membershipType != MembershipType.nonMember &&
          pData.loyaltyPoints > 0) {
        final membershipCircle = MemberUtils.getMembershipCircle(
            profileController.profileData.membershipType);
        return Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 60, 16, 10),
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, LoyaltyPointsScreen.route);
            },
            child: Column(
              ///Column only for text
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Loyalty Points',
                  style: tenor22LightBlue,
                ),
                SizedBox(
                  height: 118,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                              text: TextSpan(
                                  style: man22White.apply(
                                      color: HtpTheme.goldColor),
                                  text: pData.loyaltyPoints.toString(),
                                  children: const [
                                TextSpan(
                                    text: ' Available',
                                    style: TextStyle(fontSize: 12))
                              ])),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Member Since ${pData.membershipStartDate?.year}',
                            style: tenor16WhiteOpac,
                          )
                        ],
                      ),
                      const Spacer(),
                      Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          if (membershipCircle != null)
                            SizedBox(
                                width: 140,
                                child: Center(
                                    child: Image.asset(
                                  membershipCircle,
                                  height: 100,
                                  fit: BoxFit.fill,
                                ))),
                          const Positioned(
                            right: 0,
                            child: CircleAvatar(
                              backgroundColor: Colors.black,
                              radius: 44,
                            ),
                          ),
                          const NeedleHorizontal(
                            thickness: 1,
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }
    }

    return const SizedBox.shrink();
  }
}
