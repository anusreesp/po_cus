import 'package:flutter/material.dart';

class GoldenDialogBox extends StatelessWidget {
  final Widget child;
  const GoldenDialogBox({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.black,
            border:
            Border.all(color: Colors.yellow.withOpacity(0.4), width: 0.7)),
        child: child,
      ),
    );
  }
}
