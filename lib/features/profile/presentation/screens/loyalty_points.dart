import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/common/widgets_common/app_bar_back_button.dart';
import 'package:htp_customer/common/widgets_common/outlined_black_button.dart';
import 'package:htp_customer/features/profile/controller/profile_controller.dart';
import 'package:htp_customer/features/profile/presentation/widgets/redeem_tile.dart';
import 'package:htp_customer/htp_theme.dart';
import 'package:htp_customer/shimmers/base_shimmer.dart';
import 'package:intl/intl.dart';

import '../../../dashboard/controllers/dashboard_controllers.dart';
import '../../controller/loyalty_points_controller.dart';

class LoyaltyPointsScreen extends ConsumerWidget {
  static const route = 'loyalty-points-screen';
  const LoyaltyPointsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pointStatusController = ref.watch(pointStatusProvider);
    final profileController = ref.read(profileControllerProvider);
    final loyaltyData = ref.watch(loyaltyPointsProvider);

    return Scaffold(
      appBar: AppBar(
        leading: const AppbarBackButton(),
        title: const Text("LOYALTY POINTS SUMMARY"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 25,
            ),
            if (profileController is ProfileLoaded &&
                profileController.activeMembershipData?.id == null)
              Stack(
                children: [
                  Image.asset(
                      'assets/images/placeholders/loyalty_points/loyalty_non-member.png'),
                  Positioned(
                      left: 50,
                      top: 40,
                      child: Text(
                        profileController.profileData.loyaltyPoints.toString(),
                        style: man22White,
                      )),
                ],
              ),
            if (profileController is ProfileLoaded &&
                loyaltyData is LoyaltyPointSuccess)
              Stack(
                children: [
                  // profileController.activeMembershipData.
                  Visibility(
                    visible: profileController.activeMembershipData?.id != null,
                    child: Image.asset(ref
                        .read(loyaltyPointsProvider.notifier)
                        .loyaltyCard(
                            profileController.activeMembershipData?.id ?? "")),
                  ),
                  Positioned(
                      left: 50,
                      top: 40,
                      child: Text(
                        loyaltyData.point.toString(),
                        style: man22White,
                      )),
                ],
              ),
            const SizedBox(
              height: 25,
            ),
            if (loyaltyData is LoyaltyPointSuccess)
              Visibility(
                visible: loyaltyData.data.isNotEmpty,
                child: Container(
                  width: MediaQuery.of(context).size.width / 2.5,
                  margin: const EdgeInsets.only(left: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // GestureDetector(
                      //     onTap: () {
                      //       ref.read(pointStatusProvider.notifier).state =
                      //           pointStatus.redeemed;
                      //     },
                      //     child: Text(
                      //       "Redeemed",
                      //       style: pointStatusController == pointStatus.redeemed
                      //           ? man14Gold
                      //           : man14LightGrey,
                      //     )),
                      GestureDetector(
                          onTap: () {
                            ref.read(pointStatusProvider.notifier).state =
                                pointStatus.received;
                          },
                          child: Text(
                            "Received",
                            style: pointStatusController == pointStatus.received
                                ? man14Gold
                                : man14LightGrey,
                          )),
                    ],
                  ),
                ),
              ),
            const SizedBox(
              height: 25,
            ),
            // if (pointStatusController == pointStatus.redeemed && loyaltyData is LoyaltyPointSuccess)
            //   Expanded(
            //     child: ListView.builder(
            //       itemCount:loyaltyData.data.length,
            //       itemBuilder: (context, index) {
            //           final format = DateFormat('EEE, dd MMM, yyyy');
            //           var date = format.format(
            //               loyaltyData.data[index].createdAt!);
            //           return RedeemTile(
            //             title: loyaltyData.data[index].clubName ?? "",
            //             imgUrl: 'https://www.burns-360.com/wp-content/uploads/2018/09/Sample-Icon.png',
            //             date: date,
            //             points: loyaltyData.data[index].loyaltyPoints,
            //           );
            //       },
            //     ),
            //   ),
            if (pointStatusController == pointStatus.received &&
                loyaltyData is LoyaltyPointLoading)
              Expanded(
                  child: Column(
                children: [
                  BaseShimmer(
                    child: ShimmerBoxCornered(
                      height: 105,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  BaseShimmer(
                    child: ShimmerBoxCornered(
                      height: 105,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  BaseShimmer(
                    child: ShimmerBoxCornered(
                      height: 105,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                ],
              )),
            if (pointStatusController == pointStatus.received &&
                loyaltyData is LoyaltyPointSuccess &&
                profileController is ProfileLoaded)
              Expanded(
                  child: loyaltyData.data.isNotEmpty
                      ? ListView.builder(
                          itemCount: loyaltyData.data.length,
                          itemBuilder: (context, index) {
                            num value = loyaltyData.data.fold(
                                0,
                                (previousValue, element) =>
                                    previousValue + element.loyaltyPoints!);
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              ref.read(totalPoints.notifier).state =
                                  value.toString();
                            });
                            final format = DateFormat('EEE, dd MMM, yyyy');
                            var date = format
                                .format(loyaltyData.data[index].createdAt!);
                            return RedeemTile(
                              title: loyaltyData.data[index].clubName ?? "",
                              imgUrl: loyaltyData.data[index].clubLogo ?? "",
                              date: date,
                              points: loyaltyData.data[index].loyaltyPoints,
                            );
                          })
                      : profileController.profileData.loyaltyPoints == 0
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 32,
                                  width: MediaQuery.of(context).size.width,
                                ),
                                Container(
                                  width: 280,
                                  child: const Text(
                                    "You have not collected any loyalty points yet. Reserve your spot at the top clubs and events around the world & earn loyalty points now!",
                                    style: man14LightBlue,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(
                                  height: 32,
                                ),
                                OutlinedBlackButton(
                                    onTap: () {
                                      Navigator.popUntil(
                                          context, (route) => route.isFirst);
                                      ref
                                          .read(dashboardProvider.notifier)
                                          .selectTab(TabItem.clubs);
                                    },
                                    child: const Center(
                                      child: Text("Explore clubs nearby"),
                                    )),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 32,
                                  width: MediaQuery.of(context).size.width,
                                ),
                                Container(
                                  width: 280,
                                  child: const Text(
                                    "Earn more loyalty points by exploring top clubs and events around the world now !",
                                    style: man14LightBlue,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(
                                  height: 32,
                                ),
                                OutlinedBlackButton(
                                    onTap: () {
                                      Navigator.popUntil(
                                          context, (route) => route.isFirst);
                                      ref
                                          .read(dashboardProvider.notifier)
                                          .selectTab(TabItem.clubs);
                                    },
                                    child: const Center(
                                      child: Text("Explore clubs nearby"),
                                    )),
                              ],
                            )),
          ],
        ),
      ),
    );
  }
}
