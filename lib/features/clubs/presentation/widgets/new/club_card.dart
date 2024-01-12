import 'package:change_case/change_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:htp_customer/features/clubs/data/models/club_list_api_response.dart';
import 'package:htp_customer/features/clubs/presentation/widgets/new/club_image.dart';
import 'package:htp_customer/features/clubs/presentation/widgets/new/ratings.dart';

import '../../../../../htp_theme.dart';

class NewClubCard extends StatelessWidget {
  final VoidCallback? onTap;
  final ClubDataNew data;
  NewClubCard({super.key, this.onTap, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            ClubImage(
              featured: data.featured,
              displayImage: data.displayImage,
              logo: data.logo,
            ),

            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Text(
                      data.name.toTitleCase(),
                      overflow: TextOverflow.ellipsis,
                      // softWrap: true,
                      style: tenor22LightBlue,
                    ),
                  ),
                ),
                // const SizedBox(
                //   width: 6,
                // ),
                // const Spacer(),

                Padding(
                  padding: const EdgeInsets.only(right: 10.0, top: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset("assets/svg/icons/arrow/arrow.svg"),
                      // Icon(
                      //   Icons.arrow_forward,
                      //   size: 20,
                      // ),
                      SizedBox(height: 4, width: 2),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),

            //--------------------Distance and rating----------------------------
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                width: 8,
              ),
              Row(
                children: [
                  if(data.distance != null)
                  SvgPicture.asset(
                    "assets/svg/bottom_nav/location_f.svg",
                    height: 13,
                    color: HtpTheme.lightBlueColor,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  data.distance != null
                      ? Text(
                          " ${data.distance} Km",
                          style: man14LightBlue,
                        )
                      : const SizedBox.shrink()
                ],
              ),
              // const SizedBox(
              //   width: 8,
              // ),
              // Ratings(
              //   whiteText: true,
              //   value: data.rating != null ? "${data.rating}" : "0",
              // ),
              const Spacer(),
            ]),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }
}
