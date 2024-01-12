import 'package:flutter/material.dart';

class GoldenBorderBox extends StatelessWidget {
  final Widget content;
  const GoldenBorderBox({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          // color: HtpTheme.light().scaffoldBackgroundColor,
          color: Colors.black,
          border:
              Border.all(color: Colors.yellow.withOpacity(0.4), width: 0.7)),
      width: MediaQuery.of(context).size.width,
      child: content,
    );
  }
}
