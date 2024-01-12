import 'package:flutter/material.dart';
import 'package:htp_customer/htp_theme.dart';

// class RadioButton extends StatefulWidget {
//   final String radioValue;
//   final bool radiobutton;
//
//   const RadioButton(
//       {super.key, required this.radioValue, required this.radiobutton});
//
//   @override
//   State<RadioButton> createState() => _RadioButtonState();
// }
//
// class _RadioButtonState extends State<RadioButton> {
//   bool onclick = false;
//   bool radiobutton = true;
//
//   @override
//   void initState() {
//     super.initState();
//     radiobutton == widget.radiobutton;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 105,
//       height: 50,
//       child: Row(
//         children: [
//           radiobutton == false
//               ? IconButton(
//                   onPressed: () {
//                     setState(() {
//                       radiobutton = true;
//                     });
//                   },
//                   icon: const Image(
//                     fit: BoxFit.cover,
//                     height: 20,
//                     width: 20,
//                     image: AssetImage(
//                       "assets/images/icons/radio-off.png",
//                     ),
//                   ))
//               : IconButton(
//                   onPressed: () {
//                     setState(() {
//                       radiobutton = false;
//                     });
//                   },
//                   icon: const Image(
//                     fit: BoxFit.cover,
//                     height: 20,
//                     width: 20,
//                     image: AssetImage(
//                       "assets/images/icons/radio-on.png",
//                     ),
//                   )),
//           Text(
//             widget.radioValue,
//             style: radiobutton == true
//                 ? TextStyle(color: Colors.white)
//                 : TextStyle(color: Color.fromRGBO(255, 255, 255, 0.40)),
//           ),
//         ],
//       ),
//     );
//   }
// }

class MyRadioListTile<T> extends StatelessWidget {
  final T value;
  final T groupValue;

  final String title;
  final ValueChanged<T?> onChanged;

  const MyRadioListTile({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(value),
      child: Container(
        height: 40,
        //padding: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            _customRadioButton,
          ],
        ),
      ),
    );
  }

  Widget get _customRadioButton {
    final isSelected = value == groupValue;
    final title = this.title;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: Row(children: [
        CircleAvatar(
          radius: 10,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: 8,
            backgroundColor:
                isSelected ? HtpTheme.goldenColor : HtpTheme.darkBlue1Color,
          ),
        ),

        // isSelected
        //     ? Image(
        //         fit: BoxFit.cover,
        //         height: 22,
        //         width: 22,
        //         image: AssetImage(
        //           "assets/images/icons/radio-on.png",
        //         ),
        //       )
        //     : Image(
        //         fit: BoxFit.cover,
        //         height: 22,
        //         width: 22,
        //         image: AssetImage(
        //           "assets/images/icons/radio-off.png",
        //         ),
        //       ),
        SizedBox(
          width: 8,
        ),
        Text(title,
            style: isSelected
                ? man12LightBlue
                : man12White,
                  ),
      ]),
    );
  }

  // Widget get titleName (){
  //   return Text($title)
  // }
}
