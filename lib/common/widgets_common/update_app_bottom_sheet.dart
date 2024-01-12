import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:htp_customer/common/widgets_common/needles_widget.dart';
import 'package:htp_customer/common/widgets_common/outlined_black_button.dart';
import 'package:htp_customer/common/widgets_common/rounded_golden_button.dart';
import 'package:htp_customer/htp_theme.dart';

class UpdateAppComponent extends StatelessWidget {
  final String image;
  final GestureTapCallback onTapClose;
  final GestureTapCallback onConfirm;
  const UpdateAppComponent(
      {Key? key,
      required this.image,
      required this.onTapClose,
      required this.onConfirm})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2 + 30,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: HtpTheme.darkBlue2Color,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16),
            topLeft: Radius.circular(16),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 16,
          ),
          Container(
            width: 75,
            height: 3,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: HtpTheme.whiteColor),
          ),
          SizedBox(
            height: 32,
          ),
          SvgPicture.asset(image),
          SizedBox(
            height: 28,
          ),
          Text(
            "Update Party One",
            style: tenor22White,
          ),
          SizedBox(
            height: 20,
          ),
          NeedleDoubleSided(
            width: MediaQuery.of(context).size.width - 62,
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
              width: 300,
              child: Text(
                "Party.One recommends that you update to the latest version. You can keep using this app while downloading the app.",
                style: man14White,
                textAlign: TextAlign.center,
              )),
          SizedBox(
            height: 52,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedBlackButton(
                  onTap: onTapClose,
                  width: MediaQuery.of(context).size.width / 2.2,
                  child: Center(
                    child: Text(
                      "Do it later",
                      style: man16White,
                    ),
                  )),
              RoundedGoldenButton(
                onTap: onConfirm,
                text: "Update",
                childPadding: EdgeInsets.symmetric(horizontal: 62),
              )
            ],
          ),
          SizedBox(
            height: 22,
          ),
        ],
      ),
    );
  }
}
