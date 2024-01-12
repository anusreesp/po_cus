import 'package:flutter/material.dart';
import 'package:htp_customer/common/widgets_common/outlined_black_button.dart';

import '../../../../../common/widgets_common/floatingSubmitButton.dart';
import '../../../../../htp_theme.dart';

class FloatingButtons extends StatelessWidget {
  final VoidCallback blackButtonFunc;
  final String blackButtonText;
  final String goldenButtonText;
  final VoidCallback goldenButtonFunc;
  const FloatingButtons(
      {super.key,
      required this.blackButtonFunc,
      required this.goldenButtonFunc,
      required this.blackButtonText,
      required this.goldenButtonText});

  @override
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 20,
          ),
          Flexible(
            flex: 1,
            child: FloatingBlackButton(
              onTap: blackButtonFunc,
              text: blackButtonText,
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Flexible(
              flex: 1,
              child: FloatingSubmitButton(
                onTap: goldenButtonFunc,
                text: goldenButtonText,
              ))
        ],
      ),
    );
  }
}

class FloatingBlackButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final double? height;
  const FloatingBlackButton(
      {super.key, required this.onTap, this.height, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.92,
        height: height ?? 50,
        decoration: BoxDecoration(
          border: Border.all(color: HtpTheme.goldColor),
          color: HtpTheme.darkBlue2Color.withOpacity(0.75),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Center(
                child: Text(text,
                    style: man16White
                        .merge(TextStyle(fontWeight: FontWeight.w500))))),
      ),
    );
  }
}
