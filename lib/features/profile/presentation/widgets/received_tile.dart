import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:htp_customer/htp_theme.dart';

class ReceivedTile extends StatelessWidget {
  final String imgUrl;
  final String title;
  final String date;
  final String coins;
  const ReceivedTile({Key? key, required this.imgUrl, required this.title, required this.date, required this.coins}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 22),
      height: 92,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(width: 12,),
              CircleAvatar(
                  radius: 22,
                  backgroundImage:
                  const AssetImage("assets/images/logoBg.png"),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image(
                      image: NetworkImage(imgUrl),
                      height: 63,
                      width: 63,
                      fit: BoxFit.cover,
                    ),
                  )),
              SizedBox(width: 16,),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,style: tenor16White,),
                  Text(date,style: man14LightBlue,),
                ],
              ),
            ],
          ),
          Row(
            children: [
              SvgPicture.asset('assets/svg/icons/profile/coin_icon.svg'),
              SizedBox(width: 8,),
              Text(coins,style: tenor22White,),
              SizedBox(width: 12,),
            ],
          )
        ],
      ),
    );
  }
}
