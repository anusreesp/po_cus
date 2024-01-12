import 'package:flutter/material.dart';
import 'package:htp_customer/common/form_validator.dart';
import 'package:htp_customer/common/widgets_common/app_bar_back_button.dart';
import 'package:htp_customer/common/widgets_common/floatingSubmitButton.dart';
import 'package:htp_customer/common/widgets_common/needles_widget.dart';
import 'package:htp_customer/common/widgets_common/time_indicator.dart';
import 'package:htp_customer/htp_theme.dart';
import 'package:pinput/pinput.dart';

class OtpVerificationCommonPage extends StatefulWidget {
  static const route = '/otp-verify-common-page';
  final String titleText;
  final Future Function() onContinue;
  final VoidCallback onComplete;
  final Future Function() onResend;
  final String errorText;
  final TextEditingController otpController;
  const OtpVerificationCommonPage(
      {Key? key,
      this.titleText = 'Verify your Email ID',
      required this.onContinue,
      required this.onComplete,
      required this.onResend,
      this.errorText = 'Validation failed',
      required this.otpController})
      : super(key: key);

  @override
  State<OtpVerificationCommonPage> createState() =>
      _OtpVerificationCommonPageState();
}

class _OtpVerificationCommonPageState extends State<OtpVerificationCommonPage> {
  final _formKeyOTPVerify = GlobalKey<FormState>();

  final defaultPinTheme = const PinTheme(
    width: 42,
    height: 42,
    textStyle: man14White,
    // decoration: const BoxDecoration(),
  );

  final cursor = const Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      SizedBox(
        width: 56,
        height: 3,
      ),
      OTPNeedle()
    ],
  );

  final preFilledWidget = const Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      SizedBox(
        width: 56,
        height: 1.5,
      ),
      OTPNeedle()
    ],
  );

  bool showLoader = false;
  changeLoaderVisibility(bool visible) {
    setState(() {
      showLoader = visible;
    });
  }

  bool otpTimerVisible = false;

  otpTimerVisibility(bool visible) {
    setState(() {
      otpTimerVisible = visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.titleText,
          style: tenor22LightBlue,
        ),
        leading: const AppbarBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Form(
          key: _formKeyOTPVerify,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 22,
              ),
              Text(
                "Enter your OTP code here",
                style: tenor16WhiteOpac,
              ),
              const SizedBox(
                height: 40,
              ),
              Align(
                alignment: Alignment.center,
                child: Pinput(
                  length: 4,
                  showCursor: true,
                  onChanged: (pin) {},
                  validator:
                      RequiredValidator(errorText: "Enter OTP to continue."),
                  defaultPinTheme: defaultPinTheme,
                  cursor: cursor,
                  preFilledWidget: preFilledWidget,
                  controller: widget.otpController,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              !otpTimerVisible
                  ? Align(
                      alignment: Alignment.center,
                      child: TimeIndicator(onTimerCompleted: () {
                        otpTimerVisibility(true);
                      }),
                    )
                  : Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        child: const Text(
                          "Resend OTP",
                          style: man12Gold,
                        ),
                        onPressed: () async {
                          try {
                            changeLoaderVisibility(true);
                            await widget.onResend();
                            changeLoaderVisibility(false);
                            otpTimerVisibility(false);
                          } catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(widget.errorText)));
                              changeLoaderVisibility(false);
                            }
                          }
                        },
                      )),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    showLoader
                        ? const Center(
                            child: const CircularProgressIndicator(
                                color: HtpTheme.goldenColor),
                          )
                        : FloatingSubmitButton(
                            onTap: () async {
                              FocusManager.instance.primaryFocus?.unfocus();
                              try {
                                changeLoaderVisibility(true);
                                await widget.onContinue();
                                changeLoaderVisibility(false);
                                widget.onComplete();
                              } catch (e) {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(widget.errorText)));
                                  changeLoaderVisibility(false);
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
