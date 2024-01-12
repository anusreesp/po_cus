import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/features/booking/controllers/selection/date_controller.dart';
import 'package:htp_customer/features/booking/controllers/selection/time_slot_selection.dart';

import '../../../../../common/widgets_common/custom_radio.dart';
import '../../../../../common/widgets_common/rounded_golden_button.dart';
import '../../../../../htp_theme.dart';
import '../../../controllers/booking_selection_controller.dart';

final sampleTime = ['08:00 PM', '10:20 PM', '11:15 PM'];

class TimeSelection extends ConsumerWidget {
  const TimeSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(slotPickProvider);
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color:
                //  Colors.white,
                HtpTheme.cardBlackColor,
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Select a time slot",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ),
            // DatePickField(),

            const SizedBox(
              height: 24,
            ),

            Wrap(
              alignment: WrapAlignment.spaceBetween,
              runAlignment: WrapAlignment.spaceAround,
              spacing: 16,
              children: [
                for (int i = 0; i < sampleTime.length; i++)
                  _RadioTile(
                    text: sampleTime[i],
                    onTap: () {
                      ref.read(slotPickProvider.notifier).state = sampleTime[i];
                    },
                    selected: selectedIndex == i,
                  ),
              ],
            ),

            const SizedBox(
              height: 90,
            ),
            Consumer(
              builder: (context, ref, _) {
                final timePickController = ref.watch(slotPickProvider);

                return Padding(
                    padding: const EdgeInsets.symmetric(),
                    child: timePickController != null
                        ? RoundedGoldenButton(
                            height: 44,
                            onTap: () {
                              ref.read(selectionProvider.notifier).state =
                                  SelectionType.guest;
                            },
                            text: "Next",
                          )
                        : RoundedGoldenButton(
                            height: 44,
                            onTap: () {},
                            text: 'Next',
                            isActive: false,
                          ));
              },
            )
          ],
        ),
      ),
    );
  }
}

class _RadioTile extends StatelessWidget {
  final String text;
  final bool selected;
  final VoidCallback onTap;
  const _RadioTile(
      {Key? key,
      required this.text,
      this.selected = false,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomRadio(
              selected: selected,
              onTap: (val) {
                onTap();
              }),
          const SizedBox(
            width: 6,
          ),
          Text(
            text,
            style: selected ? null : const TextStyle(color: Colors.grey),
          )
        ],
      ),
    );
  }
}
