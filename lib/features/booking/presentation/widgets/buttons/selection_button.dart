import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:htp_customer/htp_theme.dart';

class TopSelectionButton extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;
  final dynamic activeImage;
  final dynamic inActiveImage;
  final dynamic finished;
  final String data;
  const TopSelectionButton(
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
            width: 75,
            height: 80,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: isSelected == true
                    // ? const Color.fromARGB(255, 255, 241, 114)
                    // : const Color.fromARGB(255, 87, 33, 72),
                    ? HtpTheme.goldenColor
                    : HtpTheme.addButtonColor.withOpacity(0.09)),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  isSelected == true
                      ? SvgPicture.asset(
                          'assets/svg/icons/booking/active/$activeImage',
                          width: 23,
                        )
                      : SvgPicture.asset(
                          'assets/svg/icons/booking/inactive/$inActiveImage',
                          width: 23,
                        ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    data,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 12,
                        color: isSelected == true
                            ? Colors.black
                            : Colors.white.withOpacity(0.5)),
                  )
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
