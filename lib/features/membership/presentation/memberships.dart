import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/common/widgets_common/app_bar_back_button.dart';
import 'package:htp_customer/common/widgets_common/needles_widget.dart';
import 'package:htp_customer/common/widgets_common/outlined_black_button.dart';
import 'package:htp_customer/features/membership/controller/membership_controller.dart';
import 'package:htp_customer/features/membership/presentation/screens/membership_form_main.dart';
import 'package:htp_customer/features/membership/presentation/screens/membership_renew_page.dart';
import 'package:htp_customer/features/membership/presentation/screens/membership_request_status.dart';
import 'package:htp_customer/features/membership/presentation/screens/membership_upgrade_page.dart';
import 'package:htp_customer/features/membership/presentation/widgets/membership_list_item.dart';
import 'package:htp_customer/features/profile/controller/profile_controller.dart';
import 'package:htp_customer/htp_theme.dart';
import 'package:htp_customer/common/widgets_common/rounded_golden_button.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../common/utils/common_links.dart';
import '../controller/selected_membership_id.dart';
import '../data/model/membership_response.dart';

class MembershipsPage extends ConsumerWidget {
  static const route = '/memberships';
  const MembershipsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(membershipProvider);
    final profileController = ref.watch(profileControllerProvider);

    if (controller is MembershipLoading) {
      return const Center(
        child: const CircularProgressIndicator(color: HtpTheme.goldenColor),
      );
    }

    if (controller is MembershipErrors) {
      return Center(
        child: Text(
          controller.message,
          style: const TextStyle(color: Colors.red),
        ),
      );
    }

    if (controller is MembershipLoaded && profileController is ProfileLoaded) {
      // if (controller is MembershipLoaded) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('MEMBERSHIPS'),
          leading: const AppbarBackButton(),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 12.0, right: 12),
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Container(
                height: 200,
                width: 340,
                decoration: BoxDecoration(
                    border: Border.all(color: HtpTheme.goldenColor),
                    borderRadius: BorderRadius.circular(16)),
              ),
              MembershipPageView(
                membershipData: controller.membershipData,
              )
            ],
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }
}

class MembershipPageView extends StatefulWidget {
  final List<MembershipData> membershipData;
  const MembershipPageView({super.key, required this.membershipData});

  @override
  State<MembershipPageView> createState() => _MembershipPageViewState();
}

class _MembershipPageViewState extends State<MembershipPageView> {
  final pageController = PageController(viewportFraction: 0.86);
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageController,
      itemCount: widget.membershipData.length,
      onPageChanged: (index) {
        setState(() {
          currentPageIndex = index;
        });
      },
      itemBuilder: (context, index) {
        return MembershipItem(
            data: widget.membershipData[index],
            activeView: currentPageIndex == index);
      },
    );
  }
}

class MembershipItem extends ConsumerWidget {
  final MembershipData data;
  final bool activeView;
  const MembershipItem({super.key, required this.data, this.activeView = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Opacity(
      opacity: activeView ? 1 : 0.2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 180,
                width: 325,
                // color: Colors.grey,
                margin: const EdgeInsets.only(top: 10),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      data.flatImage,
                      fit: BoxFit.cover,
                    )),
              ),
            ),

            const SizedBox(
              height: 38,
            ),

            Row(
              children: [
                Text(
                  data.tagline.title,
                  style: tenor16White,
                ),
                const SizedBox(
                  width: 8,
                ),
                const Expanded(child: NeedleHorizontal())
              ],
            ),

            Text(
              '${data.name} Membership',
              style: tenor22Gold,
            ),

            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 22),
              child: Text(
                data.tagline.taglines.first,
                style: tenor12LightBlue,
              ),
            ),

            // Text('USD \$1,499 / Year', style: tenor16WhiteOpac,)
            ///Membership plans & price section
            // Wrap(
            //   children: [
            //     ...data.planList.map((e) => Text(e.price.toString()))
            //   ],
            // ),

            if (data.name.toLowerCase() == 'amethyst')
              Text(
                'USD \$ ${data.planList.first.formattedPrice} / ${data.planList.first.durationText} (or) \$${data.planList.last.formattedPrice} / ${data.planList.last.durationText}',
                style: tenor16WhiteOpac,
              ),

            if (data.name.toLowerCase() != 'amethyst')
              data.planList.first.price == 0
                  ? Text(
                      'Free membership',
                      style: tenor16WhiteOpac,
                    )
                  : Text(
                      'USD \$ ${data.planList.first.formattedPrice} / ${data.planList.first.durationText}',
                      style: tenor16WhiteOpac,
                    ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 28.0),
              child: MembershipDynamicButton(
                data: data,
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ...data.benefits.map((benefit) => MembershipListItem(
                          benefit: benefit,
                        )),
                    const Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Terms and Conditions',
                          style: tenor22White,
                        )),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: TextButton(
                          onPressed: () {
                            final uri = Uri.parse(
                              "$supportLink/terms-and-conditions/",
                            );
                            launchUrl(uri);
                          },
                          child: Text(
                            'Legal Terms',
                            style: man14LightBlue.apply(
                              decoration: TextDecoration.underline,
                            ),
                          )),
                    ),
                    const SizedBox(
                      height: 120,
                    )
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

class MembershipDynamicButton extends ConsumerWidget {
  final MembershipData data;
  const MembershipDynamicButton({super.key, required this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(membershipProvider);
    final profileController = ref.watch(profileControllerProvider);

    if (controller is MembershipLoaded && profileController is ProfileLoaded) {
      //Currently active, Get membership, Upgrade membership, (Renew, Upgrade) on expired

      if (profileController.profileData.membershipExpired &&
          profileController.profileData.lastMembershipId == data.id) {
        // if(true){
        return Row(
          children: [
            Expanded(
                child: OutlinedBlackButton(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MembershipRenewPage()));
                ref.read(selectedMembershipId.notifier).state = data.id;
              },
              text: 'Renew',
            )),
            if (data.id != '38c2cd71-8dbd-4911-a1c0-f24869ebb02f')
              const SizedBox(
                width: 18,
              ),
            if (data.id !=
                '38c2cd71-8dbd-4911-a1c0-f24869ebb02f') //Upgrade button if solitaire
              Expanded(
                  child: RoundedGoldenButton(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MembershipUpgradePage()));
                  ref.read(selectedMembershipId.notifier).state = data.id;
                },
                text: 'Upgrade',
              ))
          ],
        );
      }

      if (data.id == profileController.profileData.activeMembershipId) {
        return OutlinedBlackButton(
          onTap: () {},
          text: 'Currently active',
        );
      }

      if (data.id == controller.oldRequest?.membershipId &&
          (controller.oldRequest?.status == 'Pending' ||
              controller.oldRequest?.status ==
                  'waiting for payment confirmation')) {
        return RoundedGoldenButton(
            onTap: () {
              Navigator.pushNamed(context, MembershipRequestStatus.route);
            },
            text: 'View status');
      }

      if (profileController.profileData.hasActiveMembership &&
          (data.level > 0 &&
              data.level > profileController.activeMembershipData!.level)) {
        return RoundedGoldenButton(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MembershipUpgradePage()));
              ref.read(selectedMembershipId.notifier).state = data.id;
            },
            text: 'Upgrade Membership');
      }

      if (profileController.profileData.hasActiveMembership &&
          (data.level < profileController.activeMembershipData!.level &&
              data.level != -1)) {
        return RoundedGoldenButton(
            isActive: false, onTap: () {}, text: 'Get Membership');
      }

      return RoundedGoldenButton(
          onTap: () {
            Navigator.pushNamed(context, MembershipFormMain.route);
            ref.read(selectedMembershipId.notifier).state = data.id;
            FirebaseAnalytics.instance
                .logSelectItem(itemListId: data.id, itemListName: data.name);
          },
          text: 'Get Membership');
    } else {
      return const SizedBox(
        height: 50,
      );
    }
  }
}
