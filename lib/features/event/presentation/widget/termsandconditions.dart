// ignore: file_names
import 'package:flutter/material.dart';
import 'package:htp_customer/htp_theme.dart';

import '../../../booking/presentation/widgets/age_confirmation_checkbox.dart';

class TermsConditions extends StatefulWidget {
  const TermsConditions({super.key});

  @override
  State<TermsConditions> createState() => _TermsConditionsState();
}

class _TermsConditionsState extends State<TermsConditions> {
  bool _agreeTandC = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Checkbox(
            value: _agreeTandC,
            onChanged: ((value) {
              setState(() {
                _agreeTandC = value ?? false;
              });
              // if (value == true) {
              //   showDialog(
              //       context: context,
              //       builder: (context) {
              //         return DialogBox.signupDialog();
              //       });
              // }
            }),
            // activeColor: HtpTheme.light().scaffoldBackgroundColor,
            checkColor: HtpTheme.goldenColor,
            // checkColor: Colors.white,
            side: BorderSide(
                // color: HtpTheme.light().scaffoldBackgroundColor,
                width: 1.6),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 6.0, right: 50),
              child: RichText(
                  text: TextSpan(
                      text: 'I confirm that my age is 21 years & above ',
                      style: TextStyle(
                        fontSize: 10,
                        // color: Colors.black87
                        color: Colors.white.withOpacity(0.5),
                      ),
                      children: const [
                    TextSpan(
                        text: 'I agree to the terms and conditions',
                        style: TextStyle(decoration: TextDecoration.underline))
                  ])),
            ),
          ),
        ],
      ),
    );
  }
}
