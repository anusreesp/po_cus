import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:htp_customer/authentication/data/service/firebase_auth_service.dart';
import 'package:htp_customer/common/widgets_common/app_bar_back_button.dart';
import 'package:htp_customer/common/widgets_common/otp_verfication_common_page.dart';
import 'package:htp_customer/common/widgets_common/rounded_golden_button.dart';
import 'package:htp_customer/features/profile/data/services/profile_services.dart';
import 'package:htp_customer/htp_theme.dart';

import '../../../dashboard/controllers/email_verification_controller.dart';

class ConfirmationDisplayPage extends StatelessWidget {
  final String appBarTitle;
  final String title;
  final String description;
  final bool justPop;
  final bool inVoice;
  final bool emailVerify;
  final VoidCallback? onTap;
  const ConfirmationDisplayPage(
      {super.key,
      this.appBarTitle = 'REQUEST SENT',
      this.title = 'Membership request sent ',
      this.description =
          'Your request for a membership has been successfully sent to team Party One',
      this.justPop = true,
      this.emailVerify = true,
      this.inVoice = false,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: inVoice == true
            ? AppbarBackButton(
                onTap: onTap,
              )
            : const AppbarBackButton(),
        title: Text(appBarTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const Spacer(),
            SvgPicture.asset('assets/svg/icons/membership/request.svg'),
            const SizedBox(
              height: 56,
            ),
            Text(
              title,
              style: tenor22White,
            ),
            const SizedBox(
              height: 6,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              child: Text(
                description,
                style: man14LightGrey,
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(),
            if (emailVerify == true)
              Consumer(builder: (context, ref, _) {
                final verificationController =
                    ref.watch(emailVerificationProvider);

                if (verificationController is EmailVerificationLoaded &&
                    verificationController.isVerifed == false) {
                  return InkWell(
                    onTap: (){
                      final otpController = TextEditingController();
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>
                          OtpVerificationCommonPage(
                              onContinue: ()async{
                                final verified = await ref.read(profileServiceProvider).verifyEmailOtp(otpController.text, verificationController.email);
                                if(verified){
                                  await ref.read(profileServiceProvider).afterVerifyEmailUsingOtp(verificationController.email);
                                }
                              },
                              onComplete: (){
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Email verified successfully')));
                              },
                              onResend: ()async{
                                await ref.read(profileServiceProvider)
                                    .sendEmailOtp(ref.read(firebaseAuthServiceProvider).uid, verificationController.email);
                              },
                              otpController: otpController,
                          ),
                      ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: HtpTheme.blackColor,
                            border: Border.all(
                                color: HtpTheme.whiteColor, width: 0.8)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                  'assets/svg/icons/others/emailer_icon.svg'),
                              const SizedBox(
                                width: 12,
                              ),
                              Text(
                                'Please verify your Email ID >',
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.7)),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }

                return const SizedBox.shrink();
              }),
            const SizedBox(
              height: 24,
            ),

            RoundedGoldenButton(
                onTap: () {
                  if (justPop) {
                    Navigator.pop(context);
                  } else {
                    onTap!();
                  }
                },
                text: 'Done'),
            const SizedBox(
              height: 22,
              width: double.infinity,
            )
          ],
        ),
      ),
    );
  }
}
