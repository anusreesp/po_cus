import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:htp_customer/common/utils/images_path.dart';

import '../../../htp_theme.dart';

class LoadingSplash extends StatelessWidget {
  const LoadingSplash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 200,
              width: double.infinity,
            ),
            SvgPicture.asset(
              logo,
              height: 155,
              width: 200,
            ),
            const SizedBox(
              height: 12,
            ),
            const CircularProgressIndicator(color: HtpTheme.goldenColor),

            const Spacer(),
            // SizedBox(
            //   height: 200,
            // ),
            // const Padding(padding: EdgeInsets.only(top: 80.0)),
             Column(
                mainAxisSize: MainAxisSize.min,
                children: [
              Text(
                'Your Access To',
                style: tenor16White,
              ),
              Text(
                'Global Nightlife',
                style: tenor37Gold,
              ),
            ]),

            const SizedBox(
              height: 50,
            ),
          ],
        ));
  }
}
