import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:htp_customer/authentication/data/service/firebase_auth_service.dart';
import 'package:htp_customer/authentication/presentation/widgets/background.dart';
import 'package:htp_customer/authentication/theme.dart';
import 'package:htp_customer/authentication/validation.dart';
import 'package:htp_customer/authentication/presentation/widgets/footer.dart';
import 'package:htp_customer/common/widgets_common/rounded_golden_button.dart';

class ResetPassword extends StatefulWidget {
  final String code;
  const ResetPassword({super.key, required this.code});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  var colorTheme = AuthTheme.colorTheme();
  final _formKeyReset = GlobalKey();

  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final _newPassword = FocusNode();
  final _confirmPassword = FocusNode();

  Widget buildBody() {
    return Container(
      color: colorTheme.backgroundColor,
      child: Stack(children: [
        const DefaultBackground(),
        Center(
          child: SingleChildScrollView(
              child: Column(
            children: [
              Form(
                  key: _formKeyReset,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: 17),
                        child: Image.asset(
                          "assets/images/icons/htp_logo.png",
                          scale: 1.8,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 22, horizontal: 24),
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Reset Password",
                          style: TextStyle(
                            fontSize: 23,
                            color: colorTheme.primaryColor,
                            // fontFamily: 'OpenSans',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 18.0),
                        child: TextFormField(
                            style: TextStyle(color: colorTheme.primaryColor),
                            controller: _newPasswordController,
                            focusNode: _newPassword,
                            validator: (value) => Validator.validatePassword(
                                  password: value,
                                ),
                            decoration: inputDecorations("New password")),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 18.0),
                        child: TextFormField(
                            style: TextStyle(color: colorTheme.primaryColor),
                            controller: _confirmPasswordController,
                            focusNode: _confirmPassword,
                            validator: (value) => Validator.validatePassword(
                                  password: value,
                                ),
                            decoration:
                                inputDecorations("Confirm new password")),
                      ),

                      //------------------------------
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 22, horizontal: 12),
                        child: Center(
                          child: RoundedGoldenButton(
                            onTap: () async {
                              User? user =
                                  await FirebaseAuthenticate.forgetPassword(
                                      code: widget.code,
                                      newPassword: _newPasswordController.text);
                            },
                            text: 'Reset Password',
                            textStyle: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 17,
                                color: colorTheme.backgroundColor
                                    .withOpacity(0.6)),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 120,
                      ),

                      FooterWidget(),
                      //---------------------
                    ],
                  ))
            ],
          )),
        )
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {}),
      child: Scaffold(
        body: buildBody(),
      ),
    );
  }

  TextStyle textStyling = const TextStyle(
      height: 0.4,
      // fontFamily: 'OpenSans',
      fontSize: 13,
      color: Color.fromRGBO(255, 255, 255, 0.96));

  InputDecoration inputDecorations(String? hintText) {
    return InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 0.6,
            //  color: Colors.yellow
            color: colorTheme.primaryColor,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: colorTheme.primaryColor)),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        hintText: hintText,
        hintStyle: textStyling.apply(color: Color.fromRGBO(255, 255, 255, 0.40))
        //  TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 12),

        );
  }
}
