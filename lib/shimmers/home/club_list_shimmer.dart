import 'package:flutter/material.dart';

import '../../common/widgets_common/horizontal_scroll_with_controller.dart';
import '../base_shimmer.dart';

class ClubListShimmer extends StatelessWidget {
  const ClubListShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HorizontalScrollWithController(
      height: 220,
      itemCount: 2,
      itemBuilder: (context, index) {
        // var data = snapshot.data;

        return Row(children: const [
          BaseShimmer(
            child: ShimmerBoxCornered(
              height: 220,
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
