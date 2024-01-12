import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/htp_theme.dart';
import 'package:intl/intl.dart';

final dayPickProvider =
    StateProvider<String>((ref) => DateFormat('EEEE').format(DateTime.now()));

class WeekDays extends ConsumerWidget {
  const WeekDays({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(dayPickProvider);

    List weekDays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    return Row(
      children: [
        const SizedBox(
          width: 16,
        ),
        for (int i = 0; i < weekDays.length; i++)
          weekDayButton(weekDays[i], () {
            ref.read(dayPickProvider.notifier).state = weekDays[i];
          }, selectedIndex == weekDays[i]),
      ],
    );
  }

  Widget weekDayButton(String day, VoidCallback onPress, final bool selected) {
    return GestureDetector(
      onTap: onPress,
      child: Row(
        children: [
          Text(
            day.substring(0, 3),
            style: selected == true ? man14Gold : man14LightBlue,
          ),
          const SizedBox(
            width: 24,
          ),
        ],
      ),
    );
  }
}
