import 'package:change_case/change_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:htp_customer/common/widgets_common/needles_widget.dart';
import 'package:htp_customer/htp_theme.dart';

import '../../../../../common/utils/time_converter.dart';
import '../../../../clubs/data/models/fire_club_details.dart';

class ClubBasicData extends StatelessWidget {
  final ClubDataModel data;

  ClubBasicData({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      width: MediaQuery.of(context).size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.31,
            height: MediaQuery.of(context).size.width * 0.32,
            child: data.displayImage == null
                ? const Image(
                    fit: BoxFit.fill,
                    image: AssetImage(
                      'assets/images/placeholders/placeholder_15.png',
                    ))
                : Image.network(
                    data.displayImage!,
                    fit: BoxFit.cover,
                  ),
          ),
          const SizedBox(
            width: 12,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.57,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        data.name,
                        style: tenor22White,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Expanded(
                      child: NeedleHorizontal(
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 2, right: 9),
                      child: SvgPicture.asset(
                        "assets/svg/icons/location/location_gold.svg",
                        width: 13.3,
                      ),
                    ),
                    Text(
                      data.cityName.toTitleCase(),
                      style: man14LightBlue,
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding:
                            const EdgeInsets.only(right: 4, left: 2, top: 4),
                        child: SvgPicture.asset(
                          "assets/svg/icons/others/time.svg",
                          width: 15,
                        )),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTapDown: (details) {
                        _showPopupMenu(details.globalPosition, context);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Sunday - Saturday ",
                                  style: man14LightBlue,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 6.0,
                                  ),
                                  child: Image(
                                    image: AssetImage(
                                        'assets/images/icons/arrow-down.png'),
                                    height: 9,
                                    width: 9,
                                  ),
                                ),
                              ]),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            "${timeConverter(data.schedule["Sunday"]['from_time'], context).toLowerCase()} - ${timeConverter(data.schedule["Sunday"]['to_time'], context).toLowerCase()}",
                            style: man14LightBlue,
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  _showPopupMenu(Offset offset, BuildContext context) async {
    double left = offset.dx;
    double top = offset.dy;

    Map<String, dynamic>? schedule = data.schedule;
    await showMenu(
      context: context,
      color: HtpTheme.darkBlue2Color,
      position: RelativeRect.fromDirectional(
          textDirection: Directionality.of(context),
          start: left,
          top: top,
          end: left + 2,
          bottom: top + 2),
      items: [
        for (final days in daysOfWeek.entries)
          PopupMenuItem(
              child: Column(
            children: [
              Text(
                days.value,
                style: man14LightBlue,
              ),
              Text(
                  '${timeConverter(schedule[days.value]?['from_time'], context)} - ${timeConverter(schedule[days.value]?['to_time'], context)}',
                  style: man14White)
            ],
          )),
      ],
      elevation: 8.0,
    ).then((value) {
      value?.onTap.call();
    });
  }
}
