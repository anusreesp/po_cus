import 'package:flutter/material.dart';

import '../../htp_theme.dart';

class RadioTile<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final void Function(T?)? onChanged;
  final String title;
  const RadioTile(
      {super.key,
      required this.value,
      required this.groupValue,
      required this.onChanged,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<T>(
          // activeColor: null,
          // fillColor: MaterialStateProperty.all(HtpTheme.goldenColor),
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
        ),
        GestureDetector(
            onTap: () {
              if (onChanged != null) {
                onChanged!(value);
              }
            },
            child: Text(title)),
      ],
    );
  }
}

class CustomRadioButton<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final void Function(T?)? onChanged;
  final String title;
  const CustomRadioButton(
      {Key? key,
      required this.value,
      required this.groupValue,
      required this.onChanged,
      required this.title})
      : super(key: key);

//   @override
//   _CustomRadioButtonState createState() => _CustomRadioButtonState();
// }

// class _CustomRadioButtonState extends State<CustomRadioButton> {
  @override
  Widget build(BuildContext context) {
    bool selected = (value == groupValue);

    return InkWell(
      onTap: () {
        if (onChanged != null) {
          onChanged!(value);
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.all(4),
            padding: const EdgeInsets.all(0.5),
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: HtpTheme.whiteColor),
            child: Icon(
              Icons.circle,
              size: 22,
              color: selected ? HtpTheme.goldenColor : HtpTheme.darkBlue1Color,
            ),
          ),
          const SizedBox(
            width: 4,
          ),
          Text(
            title,
            style: selected ? man14White : man14LightGreyOpac,
          ),
        ],
      ),
    );
  }
}
