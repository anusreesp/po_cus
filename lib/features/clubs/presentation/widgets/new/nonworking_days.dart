import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../common/widgets_common/needles_widget.dart';
import '../../../../../htp_theme.dart';
import '../../../controllers/club_misc_data_controller.dart';
import '../../../data/models/fire_club_details.dart';

class NonWorkingDays extends ConsumerWidget {
  final ClubDataModel data;
  const NonWorkingDays({super.key, required this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final miscDataController = ref.watch(clubMiscDataProvider(data.id));

    if (miscDataController is ClubMisLoaded) {
      List<DateTime> holidays = miscDataController.closedDates;

      final today = DateTime.now();

      List<DateTime> test = [
        today,
        today.add(Duration(days: 1)),
        today.add(Duration(days: 5)),
        today.add(
          Duration(days: 15),
        ),
        today.add(Duration(days: 30)),
      ];
      List totalmonth = [];

      for (var element in test) {
        if (!totalmonth.contains(element.month)) {
          totalmonth.add(element.month);
        }
      }

      return Container(
        color: HtpTheme.darkBlue2Color,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            Center(
              child: Container(
                width: 80,
                height: 3,
                color: HtpTheme.lightGreyColor,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const Row(
              children: [
                Text(
                  "Non-working days",
                  style: tenor22White,
                ),
                Spacer(),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            // ...holidays.map((e) => Column(
            for (int j = 0; j < (totalmonth.length - 1); j++)
              // ...test.map((e) {
              // final month = DateFormat('MMMM').format(e);

              // final currentMonth = e.month;

              // List<String> dateList = [];

              // if (currentMonth == e.month) {
              //   final date = DateFormat('d MMM, yyyy').format(e);

              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${totalmonth[j]}",
                        style: man14LightBlue,
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              // "Wed,28 June",
                              "date",
                              style: man14White,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: const NeedleDoubleSided(),
                  )
                ],
              )
            // ;
            // } else {
            //   return const SizedBox.shrink();
            // }
            // }
            // )
          ],
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
