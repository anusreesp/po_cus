import 'package:flutter/material.dart';
import 'package:htp_customer/htp_theme.dart';

class BottomSheets {
  static showMoreSheet(BuildContext context, String description) {
    return Container(
      // margin: EdgeInsets.symmetric(vertical: 100, horizontal: 24),
      decoration: const BoxDecoration(
          color: HtpTheme.darkBlue2Color,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5.0), topRight: Radius.circular(5.0))),

      // width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 18,
            ),
            // Row(
            //   children: [
            //     const SizedBox(
            //       width: 8,
            //     ),
            //     GestureDetector(
            //       onTap: () {
            //         Navigator.of(context).pop();
            //       },
            //       child:
            //           SvgPicture.asset('assets/svg/icons/others/closeicon.svg'),
            //     ),
            //     SizedBox(
            //       width: MediaQuery.of(context).size.width * 0.25,
            //     ),
            Center(
              child: Container(
                width: 65,
                height: 3,
                color: HtpTheme.lightGreyColor,
              ),
            ),
            //   ],
            // ),
            const SizedBox(
              height: 45,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'About this Event',
                    style: tenor22White,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    description,
                    style: man14White,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
