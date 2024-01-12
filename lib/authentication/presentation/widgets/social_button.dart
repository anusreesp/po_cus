import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../htp_theme.dart';

class SocialButton extends StatelessWidget {
  final VoidCallback onTap;
  final String iconPath;
  const SocialButton({Key? key, required this.onTap, required this.iconPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: Colors.white, width: 0.75)),
        child: SvgPicture.asset(
          iconPath,
          height: 22,
          width: 22,
        ),
      ),
    );
  }
}
