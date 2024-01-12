import 'package:flutter/material.dart';
import 'package:htp_customer/htp_theme.dart';

class Bg extends StatelessWidget {
  const Bg({super.key});

  Widget card() {
    return Row(
      children: [
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8)),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Cardss.staticCards()
        // Container(
        //     width: 320.0,
        //     height: 180.0,
        //     decoration: BoxDecoration(
        //       image: DecorationImage(
        //         image: AssetImage("assets/images/temp/map.png"),
        //         // fit: BoxFit.cover,
        //         colorFilter: ColorFilter.mode(
        //             Colors.black.withOpacity(0.8), BlendMode.darken),
        //       ),
        //     )),
        );
  }
}

class Cardss {
  static staticCards() {
    return Container(
      color: const Color.fromRGBO(255, 255, 255, 0.11),
      child: Column(
        children: [
          Container(
            height: 375,
            width: double.infinity,
            // child: Text("hey"),
            decoration: BoxDecoration(
              // color: HtpTheme.light().scaffoldBackgroundColor,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(6),
                  bottomRight: Radius.circular(6)),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            width: double.infinity,
            height: 750,
            // child: Text("hey"),
            decoration: BoxDecoration(
              image: const DecorationImage(

                  // fit: BoxFit.cover,
                  alignment: Alignment.bottomLeft,
                  image: AssetImage(
                    "assets/images/mask_group.png",
                  )),
              // color: HtpTheme.light().scaffoldBackgroundColor,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(6), topRight: Radius.circular(6)),
            ),
          )
        ],
      ),
    );
  }
}

class AboutBg {
  static backgroundImage(BuildContext context) {
    return
        // Align(
        //   alignment: Alignment.center,
        // child:
        Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          width: double.infinity,
          height: 200.0,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              opacity: 0.5,
              image: AssetImage("assets/images/others/background.jpg"),
            ),
          ),
        ),
        // Container(
        //   width: MediaQuery.of(context).size.width,
        //   height: 200.0,
        //   decoration: BoxDecoration(
        //     color: Color.fromRGBO(73, 26, 60, 0.92),
        //   ),
        // )
      ],
      // ),
    );
  }
}
