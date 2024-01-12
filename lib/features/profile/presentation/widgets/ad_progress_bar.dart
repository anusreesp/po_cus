import 'package:flutter/material.dart';
import 'package:htp_customer/htp_theme.dart';

class ProgressBarIndicator extends StatelessWidget {
  const ProgressBarIndicator({
    Key? key,
    required this.progress,
  }) : super(key: key);

  final double progress;

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      minHeight: 1,
      value: progress,
      valueColor: const AlwaysStoppedAnimation<Color>(
        HtpTheme.goldenColor,
      ),
      backgroundColor: Colors.grey,
    );
  }
}