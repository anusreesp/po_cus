import 'package:flutter/material.dart';

import '../base_shimmer.dart';

class AdvertisementShimmer extends StatelessWidget {
  const AdvertisementShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: const EdgeInsets.only(left: 20),
      margin: const EdgeInsets.only(top: 16, bottom: 16),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 2,
          itemBuilder: (_, __) {
            return const BaseShimmer(
                child: ShimmerBoxCornered(
              height: 92,
              width: 318,
            ));
          }),
    );
  }
}
