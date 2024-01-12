import 'package:flutter/material.dart';
import 'package:htp_customer/htp_theme.dart';

class TitleAndDesc extends StatelessWidget {
  final String title, desc;
  final double horiPadding;
  const TitleAndDesc({
    super.key,
    required this.title,
    required this.desc,
    this.horiPadding = 48.0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
              // fontFamily: "Montserrat",
              fontSize: 20,
              color: HtpTheme.goldenColor,
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 12,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: horiPadding),
          child: Text(
            desc,
            style: HtpTheme.newTitleTextStyle.apply(fontSizeFactor: 0.70),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 24,
        ),
      ],
    );
  }
}
