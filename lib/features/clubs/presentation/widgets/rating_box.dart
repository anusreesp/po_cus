import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../htp_theme.dart';

class RatingBox extends StatelessWidget {
  final bool whiteText;
  final String value;
  const RatingBox({Key? key, this.whiteText = false, this.value = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: HtpTheme.goldenColor),
          borderRadius: BorderRadius.circular(4)),
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: [
          // Icon(Icons.star, size: 12, color: HtpTheme.goldenColor,),
          SvgPicture.asset("assets/svg/icons/star/star-inside-rating-box.svg"),
          const SizedBox(
            width: 4,
          ),
          Text(
            value != "" ? value : "4.7",
            style: TextStyle(
                fontSize: 12, color: whiteText ? Colors.white : Colors.black87),
          )
        ],
      ),
    );
  }
}
