import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:htp_customer/htp_theme.dart';

import '../../../../common/widgets_common/custom_radio.dart';

class TimeSlotSelection extends StatelessWidget {
  final List<String> slots;
  final String? selectedSlot;
  final Function(String) onSelection;
  const TimeSlotSelection(
      {Key? key,
      required this.slots,
      this.selectedSlot,
      required this.onSelection})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(0, 22, 0, 4),
          child: Text(
            'Select an entry slot',
            style: man14White,
          ),
        ),
        // Row(
        //   children: [
        //     Padding(
        //         padding: const EdgeInsets.only(
        //           right: 6,
        //         ),
        //         child: SvgPicture.asset(
        //           "assets/svg/icons/others/info.svg",
        //           width: 15,
        //         )),
        //     Text(
        //       '12hr. format',
        //       style: man12White,
        //     )
        //   ],
        // ),
        const SizedBox(
          height: 24,
        ),
        Wrap(
          runSpacing: 22,
          spacing: MediaQuery.of(context).size.width * 0.2,
          alignment: WrapAlignment.spaceBetween,
          children: [
            ...slots.map((e) => SizedBox(
                  width: MediaQuery.of(context).size.width * 0.33,
                  child: RadioWithTitle(
                    onTap: (val) {
                      onSelection(e);
                    },
                    selected: e == selectedSlot,
                    title: e.toUpperCase(),
                  ),
                )),
          ],
        )
      ],
    );
  }
}
