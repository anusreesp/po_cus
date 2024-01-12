import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:htp_customer/features/booking/presentation/widgets/selection_dialog_box_container.dart';
import 'package:htp_customer/features/clubs/data/models/fire_club_details.dart';

import '../../../../common/utils/time_converter.dart';
import '../../../../htp_theme.dart';
import '../../../clubs/presentation/widgets/rating_box.dart';

class ClubDetails extends StatelessWidget {
  final ClubDataModel data;
  const ClubDetails({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data.name,
          style: const TextStyle(
              fontSize: 14,
              color: HtpTheme.goldenColor,
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 4,
        ),
        Row(
          children: [
            Padding(
                padding: const EdgeInsets.only(right: 6),
                child: SvgPicture.asset(
                  "assets/svg/bottom_nav/location_f.svg",
                  width: 18,
                )),
            // Icon(Icons.location_on_sharp, size: 16, color: HtpTheme.goldenColor,),
            Text(
              data.cityName,
              style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 6.0),
              child: Icon(
                Icons.access_time_filled_sharp,
                size: 16,
                color: HtpTheme.goldenColor,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Saturday - Sunday",
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w600)),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return SelectionDialogBoxContainer(
                              height: 240,
                              titleText: 'Business Hours',
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // const Text('Opening Hours', style: HtpTheme.detailTitleText,),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  for (final day in daysOfWeek.entries)
                                    _slotRow(data.schedule, day.value, context),
                                ],
                              ));
                          return Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            elevation: 16,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Opening Hours',
                                    style: HtpTheme.detailTitleText,
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  for (final day in daysOfWeek.entries)
                                    _slotRow(data.schedule, day.value, context),
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  child: Row(
                    children: [
                      Text(
                        '${timeConverter(data.schedule['Saturday']?['from_time'], context)} - ${timeConverter(data.schedule['Saturday']?['to_time'], context)}',
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white54,
                            fontWeight: FontWeight.w600),
                      ),
                      const Icon(Icons.arrow_drop_down)
                    ],
                  ),
                )
              ],
            )
          ],
        ),
        // const SizedBox(height: 4,),
        SizedBox(
            width: 48,
            child: RatingBox(
              value: "${data.rating ?? 0.0}",
              whiteText: true,
            ))
      ],
    );
  }

  Widget _slotRow(
      Map<String, dynamic>? schedule, String day, BuildContext context) {
    if (schedule?[day] == null) {
      return const SizedBox.shrink();
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 90,
          margin: const EdgeInsets.only(bottom: 4),
          child: Text(
            day,
            style: const TextStyle(fontSize: 12),
          ),
        ),
        Text(
          '${timeConverter(schedule![day]?['from_time'], context)} - ${timeConverter(schedule[day]?['to_time'], context)}',
          style: const TextStyle(fontSize: 12),
        )
      ],
    );
  }
}
