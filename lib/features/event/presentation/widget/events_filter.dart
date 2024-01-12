import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:htp_customer/features/event/controllers/events_filterlist_controller.dart';

import '../../../../htp_theme.dart';

final selectedValProvider = StateProvider.autoDispose<String>((ref) {
  return 'All time';
});

class EventsFilter extends ConsumerWidget {
  const EventsFilter({super.key});

  final _filters = const [
    "All time  ",
    "Today ",
    "Tomorrow",
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedVal = ref.watch(selectedValProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 22.0),
      child: PopupMenuButton(
        // iconSize: 92,
        onSelected: (int index) {
          ref
              .read(eventsFilterListProvider.notifier)
              .filterEvents(FilterEnum.values[index]);

          ref.read(selectedValProvider.notifier).state = _filters[index];
        },
        itemBuilder: (BuildContext context) {
          final selectedFilter =
              ref.read(eventsFilterListProvider.notifier).selectedFilter;

          return [
            for (int index = 0; index < _filters.length; index++)
              PopupMenuItem(
                  value: index,
                  child: Row(
                    children: [
                      Text(
                        _filters[index],
                        style: selectedFilter?.index == index
                            ? man14Gold
                            : man14LightBlue,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                    ],
                  )),
          ];
        },
        child: Row(
          children: [
            Text(
              selectedVal,
              style: man12LightBlue,
            ),
            const SizedBox(
              width: 4,
            ),
            SvgPicture.asset(
              "assets/svg/icons/others/showall.svg",
              height: 16,
            )
          ],
        ),
        offset: const Offset(0, 40),
        color: HtpTheme.darkBlue2Color,
      ),
    );
  }
}
