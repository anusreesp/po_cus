import 'package:flutter/material.dart';

import '../../common/widgets_common/horizontal_scroll_with_controller.dart';
import '../base_shimmer.dart';

class EventListShimmer extends StatelessWidget {
  const EventListShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HorizontalScrollWithController(
      height: 240,
      arrowTopPosition: 80,
      itemCount: 3,
      itemBuilder: (context, index) {
        return Row(children: const [
          BaseShimmer(
            child: ShimmerBoxCornered(
              height: 240,
              width: 260,
              margin: EdgeInsets.only(right: 12),
            ),
          )
        ]);
      },
      arrowIcon: false,
    );
  }
}
