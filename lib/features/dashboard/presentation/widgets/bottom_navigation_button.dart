import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:htp_customer/htp_theme.dart';

class BottomNavigationButton extends StatelessWidget {
  final String iconName;
  final String text;
  final bool active;
  final bool noColor;
  final void Function()? onTap;
  const BottomNavigationButton(
      {Key? key,
      required this.iconName,
      required this.text,
      required this.onTap,
      this.active = false,
      this.noColor = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Container(
        color: Colors.black.withOpacity(0.01),
        width: 54,
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                  height: 24,
                  child:
                      //  SvgPicture.asset('assets/svg/bottom_nav/$iconName${active ? '_f.svg' : '.svg'}')
                      SvgPicture.asset(
                    "assets/svg/icons/nav_bar/$iconName.svg",
                    color: active
                        ? HtpTheme.goldColor
                        : (noColor ? null : HtpTheme.lightBlueColor),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}



// class BottomNavigationButton extends StatelessWidget {
//   final String iconName;
//   final String text;
//   final bool active;
//   final void Function()? onTap;
//   const BottomNavigationButton(
//       {Key? key,
//       required this.iconName,
//       required this.text,
//       required this.onTap,
//       this.active = false})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         color: Colors.black.withOpacity(0.01),
//         width: 54,
//         child: Padding(
//           padding: const EdgeInsets.only(top: 8.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               SizedBox(
//                   height: 24,
//                   child:
//                       //  SvgPicture.asset('assets/svg/bottom_nav/$iconName${active ? '_f.svg' : '.svg'}')
//                       SvgPicture.asset(
//                     "assets/svg/icons/nav_bar/$iconName.svg",
//                     color: active ? HtpTheme.golden2Color : HtpTheme.lightBlueColor,
//                   )),
//               // Image(image: AssetImage('assets/svg/bottom_nav/$iconName${active ? '_f.svg' : '.svg'}')),
//               const SizedBox(
//                 height: 4,
//               ),
//               Text(
//                 text,
//                 style: TextStyle(
//                     fontSize: 10,
//                     color: active ? HtpTheme.goldenColor : Colors.white),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
