import 'package:flutter/material.dart';

import '../../htp_theme.dart';

class InfoBox extends StatelessWidget {
  final String text1;
  // final String text2;
  final bool showGuestInfo;
  const InfoBox(
      {Key? key,
      required this.text1,
      // required this.text2,
      this.showGuestInfo = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text1,
          style: tenor16White,
        ),
        const SizedBox(
          height: 8,
        ),

        if (showGuestInfo)
          Column(
            children: const [
              Text(
                'Fill in the details of guests accompanying you',
                style: man14LightBlue,
              ),
              SizedBox(
                height: 16,
              ),
            ],
          ),
        Row(
          children: [],
        )

        // Row(
        //   children: [
        //     Icon(
        //       Icons.info,
        //       size: 14,
        //       color: Colors.grey.shade500.withOpacity(0.5),
        //     ),
        //     const SizedBox(
        //       width: 6,
        //     ),
        //     Text(
        //       text2,
        //       softWrap: true,
        //       style: TextStyle(
        //           fontSize: 12, color: Colors.grey.shade500.withOpacity(0.6)),
        //     ),
        //   ],
        // ),
      ],
    );
  }
}
