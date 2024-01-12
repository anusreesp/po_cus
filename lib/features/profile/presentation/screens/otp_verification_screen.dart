import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:htp_customer/authentication/controllers/auth_controller.dart';
import 'package:htp_customer/authentication/controllers/country_code_controller.dart';
import 'package:htp_customer/authentication/data/service/auth_service.dart';
import 'package:htp_customer/authentication/data/service/firebase_auth_service.dart';
import 'package:htp_customer/common/form_validator.dart';
import 'package:htp_customer/common/widgets_common/floatingSubmitButton.dart';
import 'package:htp_customer/common/widgets_common/needles_widget.dart';
import 'package:htp_customer/common/widgets_common/time_indicator.dart';
import 'package:htp_customer/features/profile/controller/change_mobile_controller.dart';
import 'package:htp_customer/features/profile/controller/delete_account_controller.dart';
import 'package:htp_customer/features/profile/controller/otp_verify_controller.dart';
import 'package:htp_customer/features/profile/data/services/profile_services.dart';
import 'package:htp_customer/htp_theme.dart';
import 'package:pinput/pinput.dart';

class OtpVerificationScreen extends ConsumerWidget {
  static const route = 'otp-verify-for-change-cred';
  OtpVerificationScreen({Key? key}) : super(key: key);
  final _formKeyOTPVerify = GlobalKey<FormState>();
  final TextEditingController otpvalue = TextEditingController();
  final defaultPinTheme = PinTheme(
    width: 42,
    height: 42,
    textStyle: man14White,
    // decoration: const BoxDecoration(),
  );

  final cursor = Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Container(
        width: 56,
        height: 3,
        // decoration: BoxDecoration(
        //   color: HtpTheme.goldenColor,
        //   borderRadius: BorderRadius.circular(8),
        // ),
      ),

      OTPNeedle()
      // NeedleDoubleSided(
      //   width: 100,
      // ),
    ],
  );

  final preFilledWidget = Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Container(
        width: 56,
        height: 1.5,

        // decoration: BoxDecoration(
        //   color: HtpTheme.goldenColor,
        //   borderRadius: BorderRadius.circular(8),
        // ),
      ),
      OTPNeedle()

      // NeedleDoubleSided(
      //   width: 100,
      // ),
    ],
  );

  final submittedWidget = PinTheme(
    width: 42,
    height: 42,
    textStyle: man12DarkBlue,
    decoration: const BoxDecoration(),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final otpController = ref.watch(otpVerificationProvider);
    final otpTimerProvider = ref.watch(otpTimer);
    final mobileOtpData = ref.watch(changeMobileProvider);
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    final bool emailVerification = arguments['type'] == 'email';
    ref.listen(otpVerificationProvider, (previous, next) {
      if (next is OtpVerifyFailed) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(next.msg)));
      }
    });
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Form(
          key: _formKeyOTPVerify,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 72,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(
                        'assets/svg/icons/support/arrowleft.svg',
                      )),
                  Text(
                    emailVerification
                        ? "Verify your Email ID"
                        : "Verify your phone number",
                    style: tenor22LightBlue,
                  ),
                  SizedBox(
                    width: 10,
                  )
                ],
              ),
              SizedBox(
                height: 22,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Enter your OTP code here",
                  style: tenor16WhiteOpac,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Align(
                alignment: Alignment.center,
                child: Pinput(
                  length: emailVerification ? 4 : 6,
                  showCursor: true,
                  onChanged: (pin) {},
                  validator:
                      RequiredValidator(errorText: "Enter OTP to continue."),
                  defaultPinTheme: defaultPinTheme,
                  cursor: cursor,
                  preFilledWidget: preFilledWidget,
                  controller: otpvalue,
                ),
              ),
              SizedBox(
                height: 32,
              ),
              !otpTimerProvider
                  // ? Align(
                  //   alignment: Alignment.center,
                  //   child: RichText(text: TextSpan(text: "Resend OTP in ",style: man12LightGrey,children: [
                  //     TextSpan(text: otpTimerProvider.toString(),style: man12Gold)
                  //   ]),),
                  // )
                  ? Align(
                      alignment: Alignment.center,
                      child: TimeIndicator(onTimerCompleted: () {
                        ref.read(otpTimer.notifier).state = true;
                      }),
                    )
                  : Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        child: Text(
                          "Resend OTP",
                          style: man12Gold,
                        ),
                        onPressed: () async {
                          ref.read(otpTimer.notifier).state = false;
                          if (emailVerification) {
                            final auth = ref.read(firebaseAuthServiceProvider);
                            ref
                                .read(profileServiceProvider)
                                .sendEmailOtp(auth.uid, arguments['data']);
                            otpvalue.clear();
                          } else {
                            final countryCode = ref.read(countryCodeProvider);
                            await ref
                                .read(authServiceProvider)
                                .sendOtp('$countryCode${arguments['data']}');
                            otpvalue.clear();
                          }
                        },
                      )),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    otpController is OtpVerifyLoading ||
                            mobileOtpData is ChangeMobileControllerLoading
                        ? const Center(child: const CircularProgressIndicator(color: HtpTheme.goldenColor),)
                        : FloatingSubmitButton(
                            onTap: () async {
                              FocusManager.instance.primaryFocus?.unfocus();

                              if (_formKeyOTPVerify.currentState!.validate()) {
                                if (emailVerification) {
                                  final response = await ref
                                      .read(otpVerificationProvider.notifier)
                                      .verifyOtp(
                                          otpvalue.text, arguments['data']);
                                  if (response == true) {
                                    ref.read(authProvider.notifier).logOut();
                                    Navigator.popUntil(
                                        context, (route) => route.isFirst);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "Email changed successfully.")));
                                  }
                                } else if (arguments['type'] == 'delete') {
                                  // print("---------------------------------------?");
                                  final response = await ref
                                      .read(changeMobileProvider.notifier)
                                      .verifyOtp('${arguments['data']}');
                                  await ref
                                      .read(deleteAccountProvider.notifier)
                                      .deleteAccount("");
                                  await ref
                                      .read(authProvider.notifier)
                                      .logOut();
                                  Navigator.popUntil(
                                      context, (route) => route.isFirst);
                                  if (response == true) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "Your account deletion request is accepted..but still you have 7 days to think and to login again")));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "OTP verification failed.")));
                                  }
                                } else {
                                  final countryCode =
                                      ref.read(countryCodeProvider);
                                  final response = await ref
                                      .read(changeMobileProvider.notifier)
                                      .verifyOtp(
                                          '$countryCode${arguments['data']}');
                                  if (response == true && context.mounted) {
                                    Navigator.of(context)
                                    ..pop()
                                    ..pop()
                                    ..pop();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "Phone number changed successfully.")));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "OTP verification failed.")));
                                  }
                                  // if(mobileOtpData is MobileVerificationSuccess){

                                  // } else {
                                  // }
                                  // ref.read(authServiceProvider).verifyOtp('$countryCode${arguments['data']}', otpvalue.text!);
                                }
                              }
                            },
                            text: "Continue"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
