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
              opacity: 0.3,
                fit: BoxFit.cover,
                alignment: Alignment.bottomLeft,
                image: AssetImage("assets/images/mask_group.png"))),
      ),
    );
  }
}
