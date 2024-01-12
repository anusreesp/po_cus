import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:htp_customer/htp_theme.dart';

class OptionWidget extends StatelessWidget {
  final String hint;
  final VoidCallback onclick;
  const OptionWidget({super.key, required this.hint, required this.onclick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onclick,
      child: Container(
        color: Colors.black12.withOpacity(0.01),
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  Text(
                    hint,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    // child: SvgPicture.asset(
                    //   "assets/svg/icons/booking/other_icons/icons/golden_arrow.svg",
                    //   height: 16,
                    //   width: 16,
                    // ),
                    child: Icon(Icons.keyboard_arrow_down, color: HtpTheme.goldenColor,),
                  )
                ],
              ),
            ),
            const Divider(
              color: HtpTheme.whiteColor,
              thickness: 0.7,
            ),
          ],
        ),
      ),
    );
  }
}
