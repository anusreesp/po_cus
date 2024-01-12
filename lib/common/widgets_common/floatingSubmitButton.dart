import 'package:flutter/material.dart';
import 'package:htp_customer/htp_theme.dart';

class FloatingSubmitButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  final double? height;
  bool isActive;
  FloatingSubmitButton(
      {super.key,
      required this.onTap,
      this.height,
      required this.text,
      this.isActive = true});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isActive ? onTap : null,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.92,
        height: height ?? 50,
        decoration: BoxDecoration(
          color: HtpTheme.goldColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Center(
                child: Text(text,
                    style: man16DarkBlue
                        .merge(TextStyle(fontWeight: FontWeight.w500))))),
      ),
    );
  }
}
