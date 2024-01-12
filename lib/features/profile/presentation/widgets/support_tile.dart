
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:htp_customer/htp_theme.dart';

class SupportTile extends StatelessWidget {
  final String imgPath;
  final String text;
  final GestureTapCallback onTap;
  const SupportTile({Key? key, required this.imgPath, required this.text, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 156,
        width: 162,
        decoration: BoxDecoration(
          border: Border.all(width: 1,color: HtpTheme.lightBlueColor.withOpacity(0.7))
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset(imgPath,),
            Container(
                width: size.width/3,
                child: Text(text,style: man14LightBlue,textAlign: TextAlign.center,))
          ],
        ),
      ),
    );
  }
}
