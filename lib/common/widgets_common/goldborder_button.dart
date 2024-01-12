import 'package:flutter/material.dart';
import 'package:htp_customer/htp_theme.dart';

class GoldBorderButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final TextStyle textStyle;
  final double? height;
  final bool isActive;
  const GoldBorderButton(
      {Key? key,
      required this.onTap,
      required this.text,
      this.textStyle = const TextStyle(
          fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
      this.height,
      this.isActive = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isActive ? onTap : null,
      child: Container(
        height: height ?? 50,
        decoration: BoxDecoration(
          border: Border.all(color: HtpTheme.goldenColor, width: 1),
          borderRadius: BorderRadius.circular(26),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Center(
              child: Text(
            text,
            style: isActive ? textStyle : textStyle.apply(color: Colors.white),
          )),
        ),
      ),
    );
  }
}
