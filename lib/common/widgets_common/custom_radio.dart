import 'package:flutter/material.dart';
import 'package:htp_customer/htp_theme.dart';

class CustomRadio extends StatelessWidget {
  final bool selected;
  final Function(bool value) onTap;
  const CustomRadio({Key? key, this.selected = false, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(selected);
      },
      child: CircleAvatar(
        radius: 11,
        backgroundColor: Colors.white,
        child: CircleAvatar(
          radius: 9,
          backgroundColor:
              selected ? HtpTheme.goldColor : HtpTheme.darkBlue1Color,
        ),
      ),
    );
  }
}

class RadioWithTitle extends StatelessWidget {
  final Function(bool value) onTap;
  final bool selected;
  final String title;
  const RadioWithTitle(
      {Key? key,
      required this.onTap,
      this.selected = false,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomRadio(
          selected: selected,
          onTap: onTap,
        ),
        const SizedBox(
          width: 8,
        ),
        GestureDetector(
          onTap: () {
            debugPrint('Tap');
            onTap(selected);
          },
          child: Text(
            title,
            style: selected ? man14White : man14LightGreyOpac,
          ),
        )
      ],
    );
  }
}
