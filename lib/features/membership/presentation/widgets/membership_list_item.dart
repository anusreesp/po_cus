import 'package:flutter/material.dart';
import 'package:htp_customer/features/membership/data/model/membership_response.dart';

import '../../../../htp_theme.dart';

class MembershipListItem extends StatelessWidget {
  final Benefit benefit;
  final EdgeInsets padding;
  const MembershipListItem(
      {super.key,
      required this.benefit,
      this.padding = const EdgeInsets.fromLTRB(0, 0, 8, 22)});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.check_circle,
            color: HtpTheme.goldenColor,
            size: 18,
          ),
          const SizedBox(
            width: 6,
          ),
          Expanded(
            child: RichText(
                text: TextSpan(
                    style: man14Gold,
                    text: '${benefit.title}: ',
                    children: [
                  TextSpan(style: man14LightBlue, text: benefit.description)
                ])),
          )
        ],
      ),
    );
  }
}
