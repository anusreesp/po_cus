import 'package:flutter/material.dart';
import 'package:htp_customer/htp_theme.dart';

class RoundedGoldenButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final TextStyle textStyle;
  final double? height;
  final bool isActive;
  final EdgeInsetsGeometry childPadding;
  const RoundedGoldenButton(
      {Key? key,
      required this.onTap,
      required this.text,
      this.textStyle = const TextStyle(
          fontFamily: manrope,
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.black),
      this.height,
      this.isActive = true,
      this.childPadding = const EdgeInsets.all(12.0)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isActive ? onTap : null,
      child: Container(
        height: height ?? 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: isActive ? HtpTheme.goldColor : HtpTheme.lightBlueColor.withOpacity(0.5)
            // gradient: LinearGradient(
            //   colors: isActive
            //       ? const <Color>[
            //     Color.fromARGB(255, 247, 206, 115,),
            //     Color.fromARGB(255, 219, 166, 17),
            //   ]
            //       : const <Color>[
            //     Color.fromARGB(255, 105, 105, 105),
            //     Color.fromARGB(255, 109, 109, 109),
            //   ],
            // )
            // color: HtpTheme.goldenColor
            ),
        child: Padding(
          padding: childPadding,
          child: Center(
              child: Text(
            text,
            style: isActive ? textStyle : textStyle,
          )),
        ),
      ),
    );
  }
}

class RoundedGoldenButtonWithChild extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;
  final double? height;
  final bool isActive;
  const RoundedGoldenButtonWithChild({
    Key? key,
    required this.onTap,
    required this.child,
    this.height,
    this.isActive = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isActive ? onTap : null,
      child: Container(
        height: height ?? 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: HtpTheme.goldColor
            // gradient: LinearGradient(
            //   colors: isActive
            //       ? const <Color>[
            //     Color.fromARGB(255, 247, 206, 115,),
            //     Color.fromARGB(255, 219, 166, 17),
            //   ]
            //       : const <Color>[
            //     Color.fromARGB(255, 105, 105, 105),
            //     Color.fromARGB(255, 109, 109, 109),
            //   ],
            // )
            // color: HtpTheme.goldenColor
            ),
        child: child,
      ),
    );
  }
}
