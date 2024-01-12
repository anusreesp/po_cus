import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BaseShimmer extends StatelessWidget {
  final Widget child;
  const BaseShimmer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade500,
      highlightColor: Colors.grey.shade200,
      child: child,
    );
  }
}

class ShimmerBoxCornered extends StatelessWidget {
  final double? height;
  final double? width;
  final double borderRadius;
  final EdgeInsets margin;
  const ShimmerBoxCornered(
      {Key? key,
      this.height,
      this.width,
      this.borderRadius = 8,
      this.margin = const EdgeInsets.only(right: 8)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: margin,
      decoration: BoxDecoration(
          color: Colors.white12,
          borderRadius: BorderRadius.circular(borderRadius)),
    );
  }
}
