import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:htp_customer/common/controllers/otpverification_common_controller.dart';
import 'package:htp_customer/common/widgets_common/otp_verfication_common_page.dart';
import 'package:htp_customer/features/dashboard/controllers/email_verification_controller.dart';
import 'package:htp_customer/features/profile/data/services/profile_services.dart';
import 'package:htp_customer/features/profile/presentation/screens/otp_verification_screen.dart';

import '../../../../authentication/data/service/firebase_auth_service.dart';
import '../../../../htp_theme.dart';
import '../../../clubs/presentation/widgets/new/floatingButtons.dart';

final verificationLinkSentProvider =
    StateProvider.autoDispose<bool>((ref) => false);

class EmailVerifictionSection extends ConsumerWidget {
  const EmailVerifictionSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fire = ref.watch(firebaseAuthServiceProvider);

    // final user = FirebaseAuth.instance.currentUser!;

    return Container(
      color: HtpTheme.darkGrey4Color,
      height: MediaQuery.of(context).size.height * 0.15,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/svg/icons/others/info.svg",
                width: 15,
              ),
              const SizedBox(
                width: 8,
              ),
              const Text(
                'Your email verification is pending',
                style: man14LightBlue,
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: FloatingBlackButton(
                onTap: () async {
                  // await fire.sentEmailVerificationLink();
                  // ref.read(verificationLinkSentProvider.notifier).state = true;

                  await ref
                      .read(profileServiceProvider)
                      .sendEmailOtp(fire.uid, fire.geCurrentUser()?.email);
                  // Navigator.pushNamed(context, OtpVerificationScreen.route,
                  //     arguments: {
                  //       "type": "email",
                  //       "data": fire.geCurrentUser()?.email
                  //     });

                  final otpController = TextEditingController();

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OtpVerificationCommonPage(
                                otpController: otpController,
                                onContinue: () async {
                                  // await Future.delayed(
                                  //     const Duration(seconds: 2));

                                  final isVerified = await ref
                                      .read(otpVerifyEmailProvider.notifier)
                                      .verifyEnterOtp(otpController.text,
                                          fire.geCurrentUser()!.email!);

                                  if (isVerified == true) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Verification Successful')));
                                  }
                                },
                                onComplete: () {
                                  ref.invalidate(emailVerificationProvider);
                                  Navigator.of(context).pop();
                                },
                                onResend: () async {
                                  await ref
                                      .read(profileServiceProvider)
                                      .sendEmailOtp(fire.uid,
                                          fire.geCurrentUser()?.email);
                                },
                              )));
                },
                text: 'Send Verification Code'),
          )
        ],
      ),
    );
  }
}

// class VerificationLinkSent extends StatelessWidget {
//   const VerificationLinkSent({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: HtpTheme.darkGrey4Color,
//       height: MediaQuery.of(context).size.height * 0.15,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           SvgPicture.asset(
//             'assets/svg/icons/others/emailer_icon.svg',
//             width: 32,
//           ),
//           const SizedBox(
//             height: 16,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SvgPicture.asset(
//                 "assets/svg/icons/booking/other_icons/tick_mark.svg",
//                 width: 17,
//               ),
//               const SizedBox(
//                 width: 8,
//               ),
//               const Text(
//                 'Verification link has been sent!',
//                 style: man16White,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
