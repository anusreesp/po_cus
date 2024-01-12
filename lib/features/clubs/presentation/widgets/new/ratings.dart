import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:htp_customer/htp_theme.dart';

class Ratings extends StatelessWidget {
  final bool whiteText;
  final String value;
  const Ratings({Key? key, this.whiteText = false, this.value = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: [
          // Icon(Icons.star, size: 12, color: HtpTheme.goldenColor,),
          SvgPicture.asset(
            "assets/svg/icons/star/star-inside-rating-box.svg",
            height: 13,
          ),
          const SizedBox(
            width: 4,
          ),
          Text(value != "" ? value : "4.7",
              style: whiteText ? man14LightBlue : man14Gold)
        ],
      ),
    );
  }
}
