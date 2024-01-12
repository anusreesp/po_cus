import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/authentication/controllers/signup_controller.dart';
import 'package:htp_customer/authentication/presentation/screens/new/signup.dart';
import 'package:htp_customer/common/widgets_common/text_field_electra.dart';
import 'package:htp_customer/htp_theme.dart';

import '../../../common/form_validator.dart';
import '../../../common/widgets_common/country_code_picker_dialog.dart';
import '../../../common/widgets_common/rounded_golden_button.dart';
import '../../controllers/country_code_controller.dart';
import '../../controllers/mobile_verification_controller.dart';

class MobileField extends StatelessWidget {
  final bool isSocialReg;
  final String? name;
  final String? email;
  final TextEditingController textController;
  MobileField({
    Key? key,
    required this.textController,
    this.isSocialReg = false,
    this.email,
    this.name,
  }) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 440,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Padding(
            //   padding: const EdgeInsets.only(top: 22),
            //   child: Text(
            //     "Enter your phone number",
            //     style: tenor22White,
            //   ),
            // ),
            Consumer(builder: (context, ref, _) {
              final codeController = ref.watch(countryCodeProvider);

              return Padding(
                  padding: const EdgeInsets.only(top: 22),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            TextFieldElectra(
                              maxLength: 11,
                              keyboardType: TextInputType.number,
                              hintText: 'Phone',
                              controller: textController,
                              padding: const EdgeInsets.only(bottom: 0),
                              prefixWidget: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 4, right: 6),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CountryCodePickerDialog(
                                          selectedCountryCode: ref
                                              .read(mobileVerificationProvider
                                                  .notifier)
                                              .selectedCountryCode,
                                          onValuePicked: (value) {
                                            ref
                                                .read(countryCodeProvider
                                                    .notifier)
                                                .state = "+${value.phoneCode}";
                                            ref
                                                    .read(
                                                        mobileVerificationProvider
                                                            .notifier)
                                                    .selectedCountryCode =
                                                value.isoCode;
                                            ref
                                                    .read(
                                                        mobileVerificationProvider
                                                            .notifier)
                                                    .selectedMobileCode =
                                                "+${value.phoneCode}";
                                          }),
                                      Text(
                                        codeController,
                                      )
                                    ],
                                  )),
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: 'This field is mandatory'),
                                MaxLengthValidator(11,
                                    errorText:
                                        'Please enter a valid phone number')
                              ]),
                            ),
                            Consumer(builder: (context, ref, _) {
                              final controller =
                                  ref.watch(whatsAppToggleValueProvider);

                              return Row(
                                children: [
                                  const Text(
                                    'This is my WhatsApp number',
                                    style: man12LightBlue,
                                  ),
                                  const Spacer(),
                                  Switch.adaptive(
                                      value: controller,
                                      // activeColor: HtpTheme.goldenColor,
                                      onChanged: (val) {
                                        ref
                                            .read(whatsAppToggleValueProvider
                                                .notifier)
                                            .state = val;
                                        ref
                                            .read(mobileVerificationProvider
                                                .notifier)
                                            .isWhatsAppNumber = val;
                                      })
                                ],
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ));
            }),

            const SizedBox(height: 20),
            const Spacer(),
            Consumer(builder: (context, ref, _) {
              final isWhatsApp = ref.watch(whatsAppToggleValueProvider);
              final mobileController = ref.watch(mobileVerificationProvider);
              if (mobileController is MobileVerificationLoading) {
                return const Center(child: const CircularProgressIndicator(color: HtpTheme.goldenColor),);
              }
              return Center(
                child: RoundedGoldenButton(
                  onTap: () async {
                    // await FirebaseAuthenticate.signIn(
                    //     otp, widget.verificationId);
                    // await _submitOTP();
                    if (_formKey.currentState?.validate() ?? false) {
                      FocusManager.instance.primaryFocus?.unfocus();
                      final countryCode = ref.read(countryCodeProvider);
                      // ref
                      //     .read(mobileVerificationProvider.notifier)
                      //     .sendOtp('$countryCode${textController.text}');
                      final mobile = '$countryCode${textController.text}';

                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpPage(
                                    mobile: mobile,
                                    isSocialReg: isSocialReg,
                                    name: name,
                                    email: email,
                                    // isWhatsAppNumber: ref
                                    //     .read(mobileVerificationProvider.notifier)
                                    //     .isWhatsAppNumber

                                    isWhatsAppNumber: isWhatsApp,
                                  )));
                    }
                  },
                  text: "Continue",
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
