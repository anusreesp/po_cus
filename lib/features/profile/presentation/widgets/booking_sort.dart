import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:htp_customer/features/profile/controller/my_booking_controller.dart';

import '../../../../htp_theme.dart';

final selectedDateProvider = StateProvider.autoDispose<String>((ref) {
  return 'Booking Date';
});

class BookingSort extends ConsumerWidget {
  const BookingSort({super.key});

  final sorts = const ['Booking Date', 'Requested Date'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedVal = ref.watch(selectedDateProvider);

    return PopupMenuButton(
      itemBuilder: (BuildContext context) {
        return [
          for (int index = 0; index < sorts.length; index++)
            PopupMenuItem(
              value: index,
              child: Row(
                children: [
                  Text(
                    sorts[index],
                    style: /* selectedFilter?.index == index
                            ? */
                        sorts[index] == selectedVal
                            ? man14Gold
                            : man14LightBlue,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                ],
              ),
            ),
        ];
      },
      onSelected: (index) {
        ref.read(selectedDateProvider.notifier).state = sorts[index];
        ref.read(myBookingProvider.notifier).sortFunc(sorts[index]);
      },
      color: HtpTheme.darkBlue2Color,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            selectedVal,
            style: man12LightBlue,
          ),
          const SizedBox(
            width: 4,
          ),
          //--------------------------------------change here (icon)
          // const Image(
          //   image: AssetImage('assets/images/icons/filter_icon.png'),
          //   height: 16,
          // ),

          SvgPicture.asset(
            "assets/svg/icons/others/showall.svg",
            height: 16,
          )
        ],
      ),
    );
  }
}
