import 'package:flutter/material.dart';

class ImageBackContainer extends StatelessWidget {
  final Widget child;
  final double? height;
  const ImageBackContainer({Key? key, required this.child, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fitWidth,
              alignment: Alignment.bottomLeft,
              opacity: 0.3,
              image: AssetImage("assets/images/mask_group.png"))),
      child: child,
    );
  }
}
