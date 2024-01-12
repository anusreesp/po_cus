import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/common/widgets_common/needles_widget.dart';
import 'package:pinput/pinput.dart';

import '../../../common/widgets_common/time_indicator.dart';
import '../../../htp_theme.dart';
import '../../../common/widgets_common/rounded_golden_button.dart';
import '../../controllers/country_code_controller.dart';
import '../../controllers/mobile_verification_controller.dart';

final optNumberProvider = StateProvider.autoDispose<String?>((ref) => null);
final resendOtpProvider = StateProvider.autoDispose<bool>((ref) => false);

class OTPSection extends ConsumerWidget {
  final String mobile;
  OTPSection({Key? key, required this.mobile}) : super(key: key);

  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const defaultPinTheme = PinTheme(
      width: 42,
      height: 42,
      textStyle: TextStyle(fontSize: 18),
      decoration: BoxDecoration(),
    );

    const cursor = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Container(
        //   width: 56,
        //   height: 3,
        //   decoration: BoxDecoration(
        //     color: HtpTheme.goldenColor,
        //     borderRadius: BorderRadius.circular(8),
        //   ),
        // ),
        OTPNeedle()
      ],
    );
    const preFilledWidget = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          '0',
          style: man14DarkGrey2,
        ),
        SizedBox(
          height: 8,
        ),
        OTPNeedle()
        // Container(
        //   width: 56,
        //   height: 1.5,
        //   decoration: BoxDecoration(
        //     color: HtpTheme.goldenColor,
        //     borderRadius: BorderRadius.circular(8),
        //   ),
        // ),
      ],
    );

    return SizedBox(
      // height: 460,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 34,
          ),

          Text(
            'Enter your verification code here',
            style: tenor16WhiteOpac,
          ),

          const SizedBox(
            height: 40,
          ),

          // Row(
          //   children: [
          // Text(
          //   "Code is sent to $mobile",
          // ),
          //     IconButton(
          //         onPressed: () {
          //           ref.read(mobileVerificationProvider.notifier).editMobile();
          //           if (ref
          //                   .read(mobileVerificationProvider.notifier)
          //                   .selectedMobileCode !=
          //               null) {
          //             ref.read(countryCodeProvider.notifier).state = ref
          //                 .read(mobileVerificationProvider.notifier)
          //                 .selectedMobileCode!;
          //           }
          //         },
          //         icon: const Icon(
          //           Icons.edit,
          //           color: HtpTheme.goldenColor,
          //         ))
          //   ],
          // ),

          Pinput(
            length: 6,
            showCursor: true,
            controller: otpController,
            onChanged: (pin) {
              ref.read(optNumberProvider.notifier).state = pin;
            },
            defaultPinTheme: defaultPinTheme,
            cursor: cursor,
            preFilledWidget: preFilledWidget,
          ),

          const SizedBox(
            height: 40,
          ),

          Consumer(builder: (context, ref, _) {
            final resendOtp = ref.watch(resendOtpProvider);
            if (!resendOtp) {
              return TimeIndicator(
                onTimerCompleted: () {
                  ref.read(resendOtpProvider.notifier).state = true;
                },
              );
            } else {
              return GestureDetector(
                  onTap: () {
                    ref
                        .read(mobileVerificationProvider.notifier)
                        .sendOtp(mobile);
                    ref.read(resendOtpProvider.notifier).state = false;
                    // ref.read(optNumberProvider.notifier).dispose();
                    // debugPrint(ref.read(optNumberProvider));
                    otpController.clear();
                  },
                  child: const Text(
                    "Resend OTP",
                    style: TextStyle(
                      fontSize: 12,
                      color: HtpTheme.goldColor,
                      decoration: TextDecoration.underline,
                      decorationThickness: 3,
                    ),
                  ));
            }
          }),

          // Padding(
          //   padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     children: [
          //
          //
          //       OTPTextField(
          //           controller: otpController,
          //           length: 6,
          //           otpFieldStyle: OtpFieldStyle(
          //               borderColor: HtpTheme.goldenColor,
          //               enabledBorderColor: HtpTheme.goldenColor,
          //               focusBorderColor: HtpTheme.goldenColor),
          //           width: MediaQuery.of(context).size.width -
          //               100,
          //           textFieldAlignment:
          //           MainAxisAlignment.spaceBetween,
          //           fieldWidth: 42,
          //           fieldStyle: FieldStyle.underline,
          //           outlineBorderRadius: 15,
          //           style: const TextStyle(fontSize: 17),
          //           onChanged: (pin) {
          //             ref.read(optNumberProvider.notifier).state = pin;
          //           },
          //           onCompleted: (pin) {
          //
          //           }),
          //     ],
          //   ),
          // ),

          // const SizedBox(
          //   height: 12,
          // ),

          // const SizedBox(height: 140),
          const Spacer(),

          Consumer(builder: (context, ref, _) {
            final mobileController = ref.watch(mobileVerificationProvider);
            final otpNumber = ref.watch(optNumberProvider);
            if (mobileController is MobileVerificationLoading) {
              return const Center(child: const CircularProgressIndicator(color: HtpTheme.goldenColor),);
            }
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              child: Center(
                child: RoundedGoldenButton(
                  isActive: otpNumber?.length == 6,
                  onTap: () async {
                    if (otpNumber?.length == 6) {
                      ref
                          .read(mobileVerificationProvider.notifier)
                          .verifyOtp(mobile, otpNumber!);
                    }
                  },
                  text: "Continue",
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}
