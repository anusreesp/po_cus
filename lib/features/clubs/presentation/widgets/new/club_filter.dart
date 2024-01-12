import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:htp_customer/htp_theme.dart';
import '../../../controllers/new/clubs_filterlist_controller.dart';

final selectedClubProvider = StateProvider.autoDispose<String>((ref) {
  return 'Showing all';
});

class ClubsFilter extends ConsumerWidget {
  const ClubsFilter({super.key});

  final _filters = const ["Showing all", "Popular", "Open now"];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedVal = ref.watch(selectedClubProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 22.0),
      child: PopupMenuButton(
        // iconSize: 92,
        // padding: const EdgeInsets.symmetric(vertical: 16),
        onSelected: (index) {
          ref
              .read(clubsFilterListProvider.notifier)
              .filterClubs(FilterEnum.values[index]);

          ref.read(selectedClubProvider.notifier).state = _filters[index];
        },
        offset: const Offset(0, 40),
        color: HtpTheme.darkBlue2Color,

        itemBuilder: (context) {
          final selectedFilter =
              ref.read(clubsFilterListProvider.notifier).selectedFilter;

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
      ),
    );
  }
}
