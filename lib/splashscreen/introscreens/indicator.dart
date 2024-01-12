import 'package:flutter/material.dart';
import 'package:htp_customer/splashscreen/intro_theme.dart';

class Indicator extends AnimatedWidget {
  final PageController controller;
  final int pageCount;

  Indicator({super.key, required this.controller, required this.pageCount})
      : super(listenable: controller);

  final colortheme = IntroTheme.colorTheme();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ListView.builder(
              shrinkWrap: true,
              itemCount: pageCount,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return _createIndicator(index);
              })
        ],
      ),
    );
  }

  Widget _createIndicator(index) {
    double w = 15;
    double h = 15;
    MaterialColor color = Colors.grey;

    if (controller.page == index) {
      // color = Colors.blueGrey;
      h = 25;
      w = 25;
    }

    return SizedBox(
      height: 28,
      width: 34,
      child: Center(
        child: AnimatedContainer(
          foregroundDecoration:
              BoxDecoration(borderRadius: BorderRadius.circular(25)),
          margin: const EdgeInsets.all(5),
          color: color,
          width: w,
          height: h,
          duration: const Duration(milliseconds: 10),
        ),
      ),
    );
  }
}
