import 'package:flutter/material.dart';

class DefaultBackground extends StatelessWidget {
  const DefaultBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        height: 400,
        decoration: const BoxDecoration(
            image: DecorationImage(
                alignment: Alignment.bottomLeft,
                opacity: 0.3,
                image: AssetImage(
                  "assets/images/mask_group.png",
                ))),
      ),
    );
  }
}
