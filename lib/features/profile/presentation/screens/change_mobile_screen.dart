import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/common/widgets_common/app_bar_back_button.dart';
import 'package:htp_customer/common/widgets_common/rounded_golden_button.dart';
import 'package:htp_customer/features/profile/controller/change_mobile_controller.dart';
import 'package:htp_customer/features/profile/presentation/screens/otp_verification_screen.dart';
import 'package:htp_customer/htp_theme.dart';
import 'package:htp_customer/router.dart';
import '../../../../authentication/controllers/country_code_controller.dart';
import '../../../../common/form_validator.dart';
import '../../../../common/widgets_common/country_code_picker_dialog.dart';
import '../../../../common/widgets_common/text_field_electra.dart';

class ChangeMobileScreen extends ConsumerWidget {
  static const route = 'change-mobile';
  ChangeMobileScreen({Key? key}) : super(key: key);
  final _formKeyMobChange = GlobalKey<FormState>();
  final TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "CHANGE PHONE NUMBER",
            style: man14LightGrey,
          ),
          leading: AppbarBackButton()),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Form(
          key: _formKeyMobChange,
          child: Consumer(builder: (context, ref, _) {
            final codeController = ref.watch(countryCodeProvider);
            final selectedCountry = ref.watch(selectedCountryCodeProvider);
            return Column(
              children: [
                const Text(
                  "Enter your new phone number.",
                  style: man14LightGrey,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFieldElectra(
                  keyboardType: TextInputType.number,
                  hintText: 'Phone',
                  controller: textController,
                  padding: const EdgeInsets.only(bottom: 12),
                  prefixWidget: Padding(
                      padding: const EdgeInsets.only(bottom: 4, right: 6),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CountryCodePickerDialog(
                              selectedCountryCode: ref
                                  .read(selectedCountryCodeProvider.notifier)
                                  .state,
                              onValuePicked: (value) {
                                ref.read(countryCodeProvider.notifier).state =
                                    "+${value.phoneCode}";
                                ref
                                    .read(selectedCountryCodeProvider.notifier)
                                    .state = value.isoCode;
                                // ref
                                //     .read(
                                //     selectedCountryCodeProvider
                                //         .notifier)
                                //     .selectedMobileCode =
                                // "+${value.phoneCode}";
                              }),
                          Text(
                            codeController,
                          )
                        ],
                      )),
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'This field is mandatory'),
                    MaxLengthValidator(11,
                        errorText: 'Please enter a valid phone number')
                    // PhoneValidator(errorText: "Invalid Mobile format")
                  ]),
                ),
                Consumer(builder: (context, ref, _) {
                  final controller = ref.watch(changeMobileProvider);

                  ref.listen(changeMobileProvider, (previous, next) {
                    if (next is ChangeMobileControllerLoaded) {
                      if (context.mounted) {
                        mainNavigatorKey.currentState!
                            .pushNamed(OtpVerificationScreen.route, arguments: {
                          "type": "mobile",
                          "data": textController.text
                        });
                      }
                    }

                    if (next is ChangeMobileControllerError) {
                      if (next.msg == "Invalid Mobile format") {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Invalid Format')));
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(next.msg)));
                      }
                    }
                  });

                  return Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      controller is ChangeMobileControllerLoading
                          ? const CircularProgressIndicator(
                              color: HtpTheme.goldenColor)
                          : RoundedGoldenButton(
                              onTap: () async {
                                final countryCode =
                                    ref.read(countryCodeProvider);
                                if (_formKeyMobChange.currentState
                                        ?.validate() ??
                                    false) {
                                  ref
                                          .read(selectedMobileProvider.notifier)
                                          .state =
                                      '$countryCode${textController.text}';

                                  final response = await ref
                                      .read(changeMobileProvider.notifier)
                                      .verifyOtp(
                                          '$countryCode${textController.text}');
                                  print(
                                      ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>$response");
                                  if (response == true && context.mounted) {
                                    Navigator.of(context)
                                      ..pop()
                                      ..pop()
                                      ..pop();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "Phone number changed successfully.")));
                                  }

                                  // ref
                                  //     .read(changeMobileProvider.notifier)
                                  //     .sendMobileOtp(
                                  //         '$countryCode${textController.text}');

                                  // await ref
                                  //     .read(authServiceProvider)
                                  //     .sendOtp('$countryCode${textController.text}');

                                  // mainNavigatorKey.currentState!.pushNamed(
                                  //     OtpVerificationScreen.route,
                                  //     arguments: {
                                  //       "type": "mobile",
                                  //       "data": textController.text
                                  //     });
                                }
                              },
                              text: "Confirm")
                    ],
                  ));
                })
              ],
            );
          }),
        ),
      ),
    );
  }
}
