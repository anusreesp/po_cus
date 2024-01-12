import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:htp_customer/common/utils/images_path.dart';
import 'package:htp_customer/htp_theme.dart';
import 'package:htp_customer/splashscreen/intro_theme.dart';
import 'package:htp_customer/splashscreen/introscreens/single_page.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  PageController controller = PageController(initialPage: 0);

  List images = [
    "assets/images/final_splash/1.jpg",
    "assets/images/final_splash/slider_2.png",
    "assets/images/final_splash/3.jpg",
    "assets/images/final_splash/4.jpg",
    "assets/images/final_splash/slider_5.png",
    "assets/images/final_splash/6.jpg",
  ];

  // List newTitle = [
  //   "Unleash the night !",
  //   "Dance, connect, repeat !",
  //   "Rock the night !",
  //   "Your passport to nightlife adventures !",
  //   "Don’t miss the beat !",
  //   "Live the night !",
  // ];

  List<_TitleModel> titles = [
    _TitleModel('Access a world of', 'nightlife privileges'),
    _TitleModel('VIP entry to exclusive', 'venues worldwide'),
    _TitleModel('Experience hassle-free', 'nightlife'),
    _TitleModel('Crafting bespoke', 'experiences for you !'),
    _TitleModel('Live the Night...', 'We\'ll handle the rest !'),
  ];

  int get numberOfPages => titles.length;

  var colorTheme = IntroTheme.colorTheme();

  late Timer _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (_currentPage < (numberOfPages - 1)) {
        // _currentPage++;
        // controller.animateToPage(_currentPage,
        //     duration: const Duration(milliseconds: 1200), curve: Curves.easeInOut);
        controller.nextPage(
            duration: const Duration(milliseconds: 1200),
            curve: Curves.easeInOut);
      }

      if (_currentPage >= (numberOfPages - 1)) {
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  // navigateToPage() {
  //   Navigator.pushReplacement(
  //       context, MaterialPageRoute(builder: (context) => const LoginPage()));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              controller: controller,
              itemCount: numberOfPages,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTapDown: (details) {
                    _timer.cancel();
                  },
                  onTapUp: (details) {
                    _startTimer();
                  },
                  child: EachPage(
                    message: titles[index].title,
                    subTitle: titles[index].subTitle,
                    image: images[index],
                    currentIndex: index,
                    totalCount: numberOfPages,
                  ),
                );
              }),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 140, left: 28, right: 28),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ...List.generate(
                      numberOfPages,
                      (index) => Expanded(
                            flex: _currentPage == index ? 5 : 2,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 400),
                              height: 1.5,
                              // width: _currentPage == index ? 100 : 50,
                              margin: const EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                  color: _currentPage == index
                                      ? HtpTheme.goldColor
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                          ))
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 80),
              // child: Image.asset(
              //   "assets/images/logos/party_onebottom.png",
              //   fit: BoxFit.scaleDown,
              //   width: 100,
              //   height: 100,
              // ),
              child: SvgPicture.asset(logo, height: 80),
            ),
          ),
        ],
      ),
    );
  }
}

class _TitleModel {
  final String title;
  final String subTitle;
  _TitleModel(this.title, this.subTitle);
}
