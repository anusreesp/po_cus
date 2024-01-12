import 'package:flutter/material.dart';
import 'package:htp_customer/authentication/resetpassword.dart';

import 'package:htp_customer/authentication/theme.dart';
import 'package:htp_customer/authentication/presentation/widgets/background.dart';
import 'package:htp_customer/authentication/presentation/widgets/footer.dart';
import 'package:htp_customer/common/widgets_common/rounded_golden_button.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

class PasswordOtp extends StatefulWidget {
  const PasswordOtp({super.key});

  @override
  State<PasswordOtp> createState() => _PasswordOtpState();
}

class _PasswordOtpState extends State<PasswordOtp> {
  var colorTheme = AuthTheme.colorTheme();
  final _formKeyOtp = GlobalKey();
  OtpFieldController otpController = OtpFieldController();

  Widget buildBody() {
    return Container(
        color: colorTheme.backgroundColor,
        child: Stack(
          children: [
            const DefaultBackground(),
            Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Form(
                      key: _formKeyOtp,
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(bottom: 18),
                            child: Image.asset(
                              "assets/images/icons/htp_logo.png",
                              scale: 2,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 22, horizontal: 24),
                            alignment: Alignment.topLeft,
                            child: Text("Enter OTP",
                                style: Theme.of(context).textTheme.headline2
                              // style: TextStyle(
                              //     fontSize: 26,
                              //     color: colorTheme.primaryColor),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),

                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 185),
                                child: Text(
                                  "Enter your OTP code here",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: colorTheme.primaryColor,
                                      height: 0.4),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(24, 8, 0, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                OTPTextField(
                                    controller: otpController,
                                    length: 4,
                                    otpFieldStyle: OtpFieldStyle(
                                        borderColor: Colors.yellow,
                                        enabledBorderColor: Colors.yellow,
                                        focusBorderColor: Colors.yellow),
                                    width: MediaQuery.of(context).size.width -
                                        190,
                                    textFieldAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    fieldWidth: 40,
                                    fieldStyle: FieldStyle.underline,
                                    outlineBorderRadius: 15,
                                    style: const TextStyle(fontSize: 17),
                                    onChanged: (pin) {},
                                    onCompleted: (pin) {}),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 24.0, top: 12),
                                child: Text(
                                  "50s",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(167, 167, 167, 0.6),
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 8),
                                alignment: Alignment.topLeft,
                                child: MaterialButton(
                                    onPressed: () {},
                                    child: const Text(
                                      "Send New Code",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromRGBO(
                                            255, 245, 157, 0.6),
                                        fontSize: 16,
                                      ),
                                    )),
                              ),
                            ],
                          ),

                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            child: Center(
                              child: RoundedGoldenButton(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ResetPassword(
                                            code:
                                            otpController.toString(),
                                          )));
                                },
                                text: "Continue",
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17,
                                    color: colorTheme.backgroundColor),
                              ),
                            ),
                          ),
                          const SizedBox(height: 140),
                          FooterWidget()
                          //---------------------------------
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: (() {}),
      child: Scaffold(
        body: buildBody(),
      ),
    );
  }
}
