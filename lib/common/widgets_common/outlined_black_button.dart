import 'package:flutter/material.dart';

import '../../htp_theme.dart';



class OutlinedBlackButton extends StatelessWidget {
  final Widget? child;
  final VoidCallback onTap;
  final double height;
  final double width;
  final String? text;
  final TextStyle textStyle;
  const OutlinedBlackButton({
    super.key,
    this.child,
    required this.onTap,
    this.height = 50,
    this.width = double.infinity,
    this.text,
    this.textStyle = man16White
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          border: Border.all(color: HtpTheme.goldColor),
          color: HtpTheme.darkBlue2Color.withOpacity(0.75),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: text != null
                ? Center(child: Text(text!, style: textStyle,))
                : child),
      ),
    );
  }
}