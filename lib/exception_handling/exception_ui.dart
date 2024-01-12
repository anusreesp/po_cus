import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:htp_customer/common/widgets_common/floatingSubmitButton.dart';
import 'package:htp_customer/common/widgets_common/goldborder_button.dart';
import 'package:htp_customer/common/widgets_common/rounded_golden_button.dart';
import '../htp_theme.dart';

class ExceptionUi extends StatelessWidget {
  final String path;
  final String data;
  final VoidCallback onTap;
  final String buttonText;
  const ExceptionUi(
      {super.key,
      required this.data,
      required this.path,
      required this.onTap,
      required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            height: 220,
            width: 220,
            decoration: BoxDecoration(
                // shape: BoxShape.circle,
                borderRadius: BorderRadius.circular(150),
                border: Border.all(
                  color: HtpTheme.whiteColor.withOpacity(0.2),
                )),
            padding: EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    color: HtpTheme.goldenColor.withOpacity(0.4),
                  )),
              padding: EdgeInsets.all(28),
              child: Container(
                decoration: BoxDecoration(
                    // shape: BoxShape.circle,
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      color: HtpTheme.goldenColor.withOpacity(0.4),
                    )),
                // padding: EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: SvgPicture.asset(
                    path,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                data,
                textAlign: TextAlign.center,
              )),
          const SizedBox(
            height: 24,
          ),

          // GoldBorderButton(onTap: onTap, text: buttonText),
          // GestureDetector(
          //   onTap: onTap,
          //   child: Container(
          //       width: 150,
          //       height: 34,
          //       decoration: BoxDecoration(
          //         border:
          //             Border.all(color: HtpTheme.goldenColor.withOpacity(0.6)),
          //         borderRadius: BorderRadius.circular(26),
          //       ),
          //       child: Align(
          //         alignment: Alignment.center,
          //         child: Text(
          //           buttonText,
          //           style: TextStyle(fontSize: 14),
          //         ),
          //       )),
          // )

          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.2),
            child: FloatingSubmitButton(
              onTap: onTap,
              text: buttonText,
              height: 40,
              // textStyle: man12DarkBlue,
            ),
          )
        ],
      ),
    );
  }
}
