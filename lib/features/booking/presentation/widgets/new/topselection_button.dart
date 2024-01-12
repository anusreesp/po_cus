import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:htp_customer/htp_theme.dart';

class TopSelectionButtonWidget extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;
  final dynamic activeImage;
  final dynamic inActiveImage;
  final dynamic finished;
  final String data;
  const TopSelectionButtonWidget(
      {super.key,
      required this.isSelected,
      required this.onTap,
      required this.activeImage,
      required this.data,
      required this.inActiveImage,
      required this.finished});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Stack(
        children: [
          Container(
            // width: 80,
            height: 80,
            decoration: BoxDecoration(
                color: isSelected == true
                    ? HtpTheme.goldColor
                    : HtpTheme.darkBlue2Color),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  isSelected == true
                      ? SvgPicture.asset(
                          'assets/svg/icons/booking/new/$activeImage',
                          width: 23,
                        )
                      : SvgPicture.asset(
                          'assets/svg/icons/booking/new/$inActiveImage',
                          width: 23,
                        ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(data,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style:
                          isSelected == true ? man12DarkBlue : man12LightBlue)
                ],
              ),
            ),
          ),
          Positioned(
            // alignment: Alignment.topRight,
            right: 1,
            child: finished == true
                ? SvgPicture.asset(
                    "assets/svg/icons/booking/other_icons/tick_mark.svg",
                    height: 22,
                    width: 22,
                  )
                : Container(),
          )
        ],
      ),
    );
  }
}
