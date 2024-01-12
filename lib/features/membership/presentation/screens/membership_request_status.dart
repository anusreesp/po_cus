import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:htp_customer/common/widgets_common/rounded_golden_button.dart';
import 'package:htp_customer/features/dashboard/controllers/dashboard_controllers.dart';
import 'package:htp_customer/features/membership/data/model/membership_requested_data_model.dart';
import 'package:htp_customer/features/membership/data/model/membership_response.dart';
import 'package:htp_customer/features/membership/data/services/membership_services.dart';
import 'package:htp_customer/features/membership/presentation/screens/docs_display_screen.dart';
import 'package:htp_customer/features/profile/controller/profile_controller.dart';
import 'package:htp_customer/htp_theme.dart';

import '../../../../common/widgets_common/app_bar_back_button.dart';
import '../../controller/membership_controller.dart';

enum VerificationStatus { pending, approved, rejected, expired }

class MembershipRequestStatus extends ConsumerWidget {
  static const route = '/membership-request-status';
  const MembershipRequestStatus({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String? requestId =
        ModalRoute.of(context)?.settings.arguments as String?;

    final controller = ref.watch(membershipProvider);
    final profileDate = ref.watch(profileControllerProvider);
    final size = MediaQuery.of(context).size;
    if (controller is MembershipLoading) {
      return const Center(
        child: CircularProgressIndicator(color: HtpTheme.goldenColor),
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

    if (controller is MembershipLoaded) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: const AppbarBackButton(),
          title: const Text('GET MEMBERSHIP'),
        ),
        body: FutureBuilder<MembershipRequestedDataModel?>(
          ///If request id is passed through named route it shows that particular request status
          future: ref
              .read(membershipServiceProvider)
              .getMembershipRequestById(requestId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: const CircularProgressIndicator(
                    color: HtpTheme.goldenColor),
              );
            }

            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }

            if (snapshot.connectionState == ConnectionState.done) {
              ///Future returns nullable membership request data, if we get data, display those
              ///else display the data returns from controller (imply request id is null from name route)
              final membershipRequestDataById = snapshot.data;
              final membershipData = controller
                  .getMembershipDataWithRequestData(membershipRequestDataById);

              final MembershipData requestData =
                  membershipData ?? controller.oldRequestData!;
              final verificationStatus = membershipRequestDataById != null
                  ? _status(membershipRequestDataById.status)
                  : _status(controller.oldRequest!.status);

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    const SizedBox(
                      width: double.infinity,
                      height: 18,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              ///Place for membership card
                              if(profileDate is ProfileLoaded)
                              Stack(
                                children: [
                                  Image.asset(
                                    ref.read(membershipProvider.notifier).showCardImage(requestData.name),
                                    fit: BoxFit.fitWidth,
                                  ),
                                  Positioned(
                                    top: size.height * 0.025,
                                      left: size.width * 0.073,
                                      child: Text(profileDate.profileData.name,style: textstyleDetermine(requestData.name)[0]))
                                ],
                              ),
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 12.0, bottom: 44),
                                    child: Text(
                                      "${requestData.name} Membership",
                                      style: tenor22Gold,
                                    ),
                                  )),

                              ///Status icon and description
                              _statusDisplay(verificationStatus),

                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const DocsDisplayScreen()));
                                  },
                                  child: const Text(
                                    'View ID',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: manrope,
                                        decoration: TextDecoration.underline,
                                        color: HtpTheme.goldenColor,
                                        decorationThickness: 2),
                                  )),

                              // const SizedBox(height: 22,),
                              // Row(
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   children: [
                              //     const Icon(Icons.check_circle, size: 18, color: HtpTheme.lightBlueColor,),
                              //     const SizedBox(width: 6,),
                              //     Expanded(child: Text('ID/Selfie not clear, Please retake '*4,
                              //       softWrap: true, style: man14LightGrey,))
                              //   ],
                              // )
                            ],
                          ),
                        ),
                      ),
                    ),
                    verificationStatus == VerificationStatus.approved
                        ? RoundedGoldenButton(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            text: 'Done')
                        : RoundedGoldenButton(
                            onTap: () {
                              ref
                                  .read(dashboardProvider.notifier)
                                  .selectTab(TabItem.support);
                              Navigator.popUntil(
                                  context, (route) => route.isFirst);
                            },
                            text: 'Contact Support'),
                    const SizedBox(
                      height: 22,
                    )
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      );
    }

    return const SizedBox.shrink();
  }

  VerificationStatus _status(String status) {
    switch (status) {
      case 'Pending':
        return VerificationStatus.pending;

      case 'Rejected':
        return VerificationStatus.rejected;

      case 'Approved':
        return VerificationStatus.approved;

      case 'Cancelled':
        return VerificationStatus.rejected;

      case 'Expired':
        return VerificationStatus.expired;

      default:
        return VerificationStatus.pending;
    }
  }

  textstyleDetermine(String? membership) {
    switch (membership) {
      case 'Gold':
        return [
          tenor22Black.merge(const TextStyle(letterSpacing: 1.4)),
          man15Black,
          tenor22Black,
          tenor10Black
        ];
      case 'Solitaire':
        return [
          tenor22White.merge(const TextStyle(letterSpacing: 1.4)),
          man15LightBlue,
          tenor22White,
          tenor10White,
        ];
      case 'Silver':
        return [
          tenor22Black.merge(const TextStyle(letterSpacing: 1.4)),
          man15Black,
          tenor22Black,
          tenor10Black
        ];
      case 'Platinum':
        return [
          tenor22White.merge(const TextStyle(letterSpacing: 1.4)),
          man15White,
          tenor22White,
          tenor10White
        ];
      case 'Amethyst':
        return [
          tenor22Gold.merge(const TextStyle(letterSpacing: 1.4)),
          man15Gold,
          tenor22Gold,
          tenor10Gold
        ];
    }
  }

  Widget _statusDisplay(VerificationStatus status) {
    switch (status) {
      case VerificationStatus.pending:
        return _statusPlaceholder(
            'pending', 'Pending', "Your previous request is still ‘Pending’ ");

      case VerificationStatus.rejected:
        return _statusPlaceholder('failed', 'Rejected',
            'Your ID verification has failed due to one or more reasons. Kindly contact the support team.');

      case VerificationStatus.approved:
        return _statusPlaceholder('verified', 'Verified',
            'Congratulations! You will be receiving your membership card within a span of 14 days');

      case VerificationStatus.expired:
        return _statusPlaceholder('failed', 'Expired',
            'Your membership request has expired. Please put in a new request.');
    }
  }

  _statusPlaceholder(String svgImage, String title, String description) {
    return Column(
      children: [
        SvgPicture.asset('assets/svg/icons/membership/$svgImage.svg'),
        Padding(
          padding: const EdgeInsets.only(top: 18.0, bottom: 8),
          child: Text(
            title,
            style: tenor22White,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Text(
            description,
            style: man14LightGrey,
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
