import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:htp_customer/htp_theme.dart';

class RedeemTile extends StatelessWidget {
  final String imgUrl;
  final String title;
  final String date;
  final double? points;
  const RedeemTile(
      {Key? key,
      required this.imgUrl,
      required this.title,
      required this.date,
      required this.points})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 18),
      height: 105,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: HtpTheme.blackColor, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 12,
                ),
                CircleAvatar(
                    radius: 22,
                    backgroundImage:
                        const AssetImage("assets/images/logoBg.png"),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: imgUrl != ""
                          ? Image(
                              image: NetworkImage(imgUrl),
                              height: 63,
                              width: 63,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              "assets/images/placeholders/placeholder_11.png"),
                    )),
                SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 180,
                      child: Text(
                        title,
                        style: tenor16White,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      date,
                      style: man14LightGrey,
                    ),
                    // Row(
                    //   children: [
                    //     SvgPicture.asset(
                    //         'assets/svg/icons/profile/redeem_icon.svg'),
                    //     SizedBox(
                    //       width: 8,
                    //     ),
                    //     // Text("Reward",style: man15green,),
                    //   ],
                    // ),
                  ],
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 32),
              child: Row(
                children: [
                  SvgPicture.asset('assets/svg/icons/profile/coin_icon.svg'),
                  SizedBox(width: 8),
                  Text(
                    points.toString(),
                    style: tenor22White,
                  ),
                  SizedBox(width: 16)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
