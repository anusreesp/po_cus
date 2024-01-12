import 'package:flutter/material.dart';

import '../../../../htp_theme.dart';

class GreyCard extends StatelessWidget {
  final Widget child;
  const GreyCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 34),
        child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: HtpTheme.cardBlackColor),
            child: child));
  }
}
