import 'package:flutter/material.dart';

class AgeConfirmationCheckbox extends StatelessWidget {
  const AgeConfirmationCheckbox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            value: true,
            activeColor: const Color(0xff4a1b3d),
            onChanged: (val) {}),
        SizedBox(
          width: 200,
          child: RichText(
            softWrap: true,
            text: const TextSpan(
                text: "I confirm that my age is 21 & above, and ",
                style: TextStyle(fontSize: 9, color: Colors.grey),
                children: [
                  TextSpan(
                      text: "I agree to the terms and conditions",
                      style: TextStyle(decoration: TextDecoration.underline))
                ]),
          ),
        )
      ],
    );
  }
}
