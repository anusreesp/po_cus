import 'package:flutter/material.dart';

class HorizontalScrollWithController extends StatelessWidget {
  final Widget Function(BuildContext, int) itemBuilder;
  final int? itemCount;
  final double height;
  final EdgeInsetsGeometry padding;
  final double scrollWidth;
  final double arrowTopPosition;
  final double forwardArrowRightPosition;
  final double backwardArrowLeftPosition;
  final bool arrowIcon;
  HorizontalScrollWithController(
      {Key? key,
      required this.itemBuilder,
      this.itemCount,
      required this.height,
      this.padding = const EdgeInsets.only(left: 12),
      this.scrollWidth = 150,
      this.arrowTopPosition = 40.0,
      this.forwardArrowRightPosition = -10.0,
      this.backwardArrowLeftPosition = 20.0,
      required this.arrowIcon})
      : super(key: key);

  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: height,
          padding: padding,
          child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: itemCount,
              itemBuilder: itemBuilder),
        ),
        arrowIcon == true
            ? Positioned(
                top: arrowTopPosition,
                right: forwardArrowRightPosition,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white54,
                  ),
                  onPressed: () {
                    scrollController.animateTo(
                        scrollController.offset + scrollWidth,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.linear);
                  },
                ))
            : Container(),
        arrowIcon == true
            ? Positioned(
                top: arrowTopPosition,
                left: backwardArrowLeftPosition,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white54,
                  ),
                  onPressed: () {
                    scrollController.animateTo(
                        scrollController.offset - scrollWidth,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.linear);
                  },
                ))
            : Container()
      ],
    );
  }
}
