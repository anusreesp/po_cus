import 'package:flutter/material.dart';

class VerifyAppBar extends StatelessWidget implements PreferredSize {
  @override
  final Widget child;
  final double height, leftSpace, bottomSpace;
  final bool hideBackButton;

  const VerifyAppBar({
    super.key,
    this.child = const SizedBox.shrink(),
    this.height = kToolbarHeight,
    required this.hideBackButton,
    this.leftSpace = 24,
    this.bottomSpace = 24,
  });

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(height + 70);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: leftSpace,
          ),
          if (!hideBackButton)
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
          child,
          SizedBox(
            height: bottomSpace + 30,
          )
        ],
      ),
    );
  }
}
