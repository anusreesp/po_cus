import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/authentication/data/service/firebase_auth_service.dart';
import 'package:htp_customer/common/form_validator.dart';
import 'package:htp_customer/common/widgets_common/app_bar_back_button.dart';
import 'package:htp_customer/common/widgets_common/rounded_golden_button.dart';
import 'package:htp_customer/common/widgets_common/text_field_electra.dart';
import 'package:htp_customer/features/profile/controller/profile_controller.dart';
import 'package:htp_customer/features/profile/data/services/profile_services.dart';
import 'package:htp_customer/features/profile/presentation/screens/otp_verification_screen.dart';
import 'package:htp_customer/htp_theme.dart';

class ChangeEmailScreen extends ConsumerWidget {
  static const route = '/change-mail';
  ChangeEmailScreen({Key? key}) : super(key: key);
  final _formKeyEmailChange = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _currentController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileController = ref.watch(profileControllerProvider);
    if (profileController is ProfileLoaded)
      _currentController.text = profileController.profileData.email;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "CHANGE EMAIL",
          style: man14LightGrey,
        ),
        leading: AppbarBackButton(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Form(
          key: _formKeyEmailChange,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Enter your email to receive a verification code",
                style: man14LightGrey,
              ),
              SizedBox(
                height: 29,
              ),
              // TextFieldElectra(
              //   padding: EdgeInsets.symmetric(vertical: 10),
              //   controller: _currentController,
              //   labelText: "Current Email",
              //   hintText: "",
              //   readOnly: true,
              //   validator: MultiValidator([
              //     RequiredValidator(errorText: "Email required"),
              //     EmailValidator(errorText: "Enter a valid email")
              //   ]),
              // ),
              Text(
                "Current Email",
                textAlign: TextAlign.start,
                style: man12LightBlue,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                _currentController.text,
                style: man16White,
              ),
              SizedBox(
                height: 22,
              ),

              TextFieldElectra(
                controller: _controller,
                labelText: "Enter New Email",
                hintText: "Enter new email address",
                validator: MultiValidator([
                  RequiredValidator(errorText: "Email required"),
                  EmailValidator(errorText: "Enter a valid email address")
                ]),
              ),
              if (profileController is ProfileLoaded)
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RoundedGoldenButton(
                        onTap: () {
                          final auth = ref.read(firebaseAuthServiceProvider);
                          if (_controller.text ==
                              profileController.profileData.email) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "Current email and new email should not be the same.")));
                            return;
                          } else if (_formKeyEmailChange.currentState!
                              .validate()) {
                            ref
                                .read(profileServiceProvider)
                                .sendEmailOtp(auth.uid, _controller.text);
                            Navigator.pushNamed(
                                context, OtpVerificationScreen.route,
                                arguments: {
                                  "type": "email",
                                  "data": _controller.text
                                });
                          }
                        },
                        text: "Send Verification Code")
                  ],
                ))
            ],
          ),
        ),
      ),
    );
  }
}
