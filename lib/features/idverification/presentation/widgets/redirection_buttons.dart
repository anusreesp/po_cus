import 'package:flutter/material.dart';
import 'package:htp_customer/htp_theme.dart';
import 'package:htp_customer/common/widgets_common/rounded_golden_button.dart';

class ButtonRow extends StatelessWidget {
  final String backButtonVal;
  final String submitButtonVal;
  final VoidCallback onSubmit;
  const ButtonRow(
      {super.key,
      required this.backButtonVal,
      required this.submitButtonVal,
      required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        back(backButtonVal, () {}),
        const SizedBox(
          width: 12,
        ),
        submitButton(submitButtonVal, onSubmit),
        const SizedBox(
          width: 12,
        ),
      ],
    );
  }

  Widget back(String value, ontap) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: 125,
        child: Text(
          value,
          style: HtpTheme.capText,
        ),
      ),
    );
  }

  Widget submitButton(String submitValue, onTap) {
    return Container(
        width: 150,
        child: RoundedGoldenButton(
          onTap: onTap,
          text: submitValue,
          height: 40,
          textStyle: HtpTheme.capText.apply(color: Colors.black),
        ));
  }
}
