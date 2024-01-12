import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:htp_customer/common/widgets_common/app_bar_back_button.dart';
import 'package:htp_customer/common/widgets_common/needles_widget.dart';
import 'package:htp_customer/common/widgets_common/rounded_golden_button.dart';
import 'package:htp_customer/features/membership/controller/membership_application_controller.dart';
import 'package:htp_customer/features/membership/presentation/screens/confirmation_display_page.dart';
import 'package:htp_customer/features/membership/presentation/widgets/membership_list_item.dart';
import 'package:htp_customer/features/membership/presentation/widgets/selection_card.dart';
import 'package:htp_customer/features/profile/controller/profile_controller.dart';
import 'package:htp_customer/htp_theme.dart';

import '../../../../common/widgets_common/outlined_black_button.dart';
import '../../controller/membership_controller.dart';
import '../../controller/selected_membership_id.dart';
import '../../data/model/membership_response.dart';
import '../widgets/plan_selection_dialog.dart';
import 'cabin_crew_docs_upload.dart';

class MembershipUpgradePage extends ConsumerWidget {
  const MembershipUpgradePage({super.key});

  final leftPadding = 16.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectionController = ref.watch(selectedMembershipId);
    final controller = ref.watch(membershipProvider);

    ref.listen(membershipApplicationProvider, (previous, next) {
      if (next is MAErrorState) {
        if (next.msg == "Your last request is pending yet") {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                  "Your previous membership upgrade request is still ‘Pending’")));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(next.msg)));
        }
      }

      if (next is MASubmitState) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => const ConfirmationDisplayPage(
                      appBarTitle: 'UPGRADE MEMBERSHIP',
                      title: 'Upgrade request sent ',
                      description:
                          'Your request for a membership upgrade has been successfully sent to team Party One',
                    )),
            (route) => route.isFirst);
        // Navigator.pushNamedAndRemoveUntil(context, 'newRouteName', (route) => route.isFirst);
      }
    });

    if (controller is MembershipLoading) {
      return const Center(child: const CircularProgressIndicator(color: HtpTheme.goldenColor),);
    }

    if (controller is MembershipErrors) {
      return Center(
        child: Text(
          controller.message,
          style: const TextStyle(color: Colors.red),
        ),
      );
    }

    if (controller is MembershipLoaded) {
      final List<MembershipData> data = controller.membershipData;
      MembershipData? selectedMembershipData;
      int cardIndex = 0;
      try {
        selectedMembershipData =
            data.firstWhere((element) => element.id == selectionController);
        cardIndex = data.indexOf(selectedMembershipData);
      } catch (_) {
        debugPrint('Selection issue');
      }
      return Scaffold(
        appBar: AppBar(
          title: const Text('UPGRADE MEMBERSHIP'),
          automaticallyImplyLeading: false,
          leading: const AppbarBackButton(),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 18,
            ),
            SizedBox(
              height: 118,
              child: ListView.builder(
                  itemCount: data.length,
                  controller:
                      ScrollController(initialScrollOffset: cardIndex * 170),
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemBuilder: (context, index) {
                    return SelectionCard(
                        onTap: () {
                          ref.read(selectedMembershipId.notifier).state =
                              data[index].id;
                        },
                        selected: selectionController == data[index].id,
                        cardUrl: data[index].flatImage);
                  }),
            ),
            Expanded(
                child: _membershipData(selectedMembershipData, () {
              showModalBottomSheet(
                  context: context,
                  showDragHandle: true,
                  isScrollControlled: true,
                  useSafeArea: true,
                  builder: (context) {
                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (selectedMembershipData != null)
                              ...selectedMembershipData.benefits
                                  .map((e) => MembershipListItem(benefit: e)),
                          ],
                        ),
                      ),
                    );
                  });
            }))
          ],
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.only(
              bottom: 24, left: leftPadding, right: leftPadding),
          child: Consumer(
            builder: (context, ref, _) {
              final requestController =
                  ref.watch(membershipApplicationProvider);
              final profileController = ref.watch(profileControllerProvider);

              if (requestController is MALoadingState) {
                return const SizedBox(
                    width: 60,
                    height: 60,
                    child: Center(child: const CircularProgressIndicator(color: HtpTheme.goldenColor),));
              }

              if ((profileController is ProfileLoaded) &&
                  profileController.profileData.activeMembershipId ==
                      selectedMembershipData?.id) {
                return OutlinedBlackButton(
                  onTap: () {},
                  text: 'Currently active',
                );
              }

              if (selectedMembershipData?.id ==
                  '91e5aae1-6edd-4394-a648-5908084db3e7') {
                return RoundedGoldenButton(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CabinCrewDocsUpload(
                                    data: selectedMembershipData!,
                                  )));
                    },
                    text: 'Upload Cabin Crew ID');
              }

              return RoundedGoldenButton(
                onTap: () {
                  if (selectedMembershipData == null) {
                    return;
                  }

                  ///Shows dialog for plan if there is multiple plans available
                  if (selectedMembershipData.planList.length > 1) {
                    showModalBottomSheet(
                        context: context,
                        showDragHandle: true,
                        builder: (context) {
                          return PlanSelectionDialog(
                            plans: selectedMembershipData!.planList,
                            onPlanConfirmation: (selectedPlan) {
                              ref
                                  .read(membershipApplicationProvider.notifier)
                                  .submitMembershipRequest(
                                      selectedMembershipData!,
                                      selectedPlan: selectedPlan)
                                  .then((_) {
                                ref
                                    .read(profileControllerProvider.notifier)
                                    .getProfile();
                                ref
                                    .read(membershipProvider.notifier)
                                    .getMembership();
                              });
                            },
                          );
                        });
                  } else {
                    ref
                        .read(membershipApplicationProvider.notifier)
                        .submitMembershipRequest(selectedMembershipData)
                        .then((_) {
                      ref.read(profileControllerProvider.notifier).getProfile();
                      ref.read(membershipProvider.notifier).getMembership();
                    });
                  }
                },
                text: 'Request',
              );
            },
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _membershipData(
      MembershipData? membershipData, VoidCallback seeBenefitsTap) {
    if (membershipData != null) {
      return Padding(
        padding: EdgeInsets.only(left: leftPadding, top: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${membershipData.name} Membership", style: tenor22Gold),
            const Text(
              'Currently Selected',
              style: man16LightBlue,
            ),
            const SizedBox(
              height: 8,
            ),

            GestureDetector(
                onTap: seeBenefitsTap,
                child: const Text(
                  'See benefits',
                  style: TextStyle(
                      fontFamily: manrope,
                      fontSize: 14,
                      color: HtpTheme.goldColor,
                      decorationThickness: 2,
                      decoration: TextDecoration.underline),
                )),

            const SizedBox(
              height: 80,
            ),
            const NeedleDoubleSided(),
            const SizedBox(
              height: 34,
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/svg/icons/membership/upgrade.svg'),
                const Padding(
                  padding: EdgeInsets.only(top: 28.0, bottom: 4),
                  child: Text(
                    'Upgrade Request',
                    style: tenor22White,
                  ),
                ),
                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: Text(
                      'Request a membership upgrade to gain more benefits',
                      style: man14LightGrey,
                      textAlign: TextAlign.center,
                      softWrap: true,
                    ))
              ],
            ),

            // Expanded(
            //     child: SingleChildScrollView(
            //       child: Column(
            //         children: [
            //           ...membershipData.benefits.map((e) => MembershipListItem(
            //             padding: const EdgeInsets.only(bottom: 20, right: 26),
            //             benefit: Benefit(
            //                 title: e.title, description: e.description
            //             ),)),
            //
            //           const SizedBox(height: 100,)
            //         ],
            //       ),
            //     ))
          ],
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
