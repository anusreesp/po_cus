import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:htp_customer/authentication/controllers/auth_controller.dart';
import 'package:htp_customer/common/utils/images_path.dart';
import 'package:htp_customer/htp_theme.dart';
import 'package:htp_customer/splashscreen/introscreens/intro_screen.dart';
import 'package:htp_customer/startup_page.dart';
import 'package:video_player/video_player.dart';

class SplashScreenNew extends StatefulWidget {
  static const route = '/splash-screen-new';
  const SplashScreenNew({super.key});

  @override
  State<SplashScreenNew> createState() => _SplashScreenNewState();
}

class _SplashScreenNewState extends State<SplashScreenNew>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;
  late Animation<double> _opacityAnimation;

  late VideoPlayerController _videoController;

  _initializeVideo() {
    _videoController =
        VideoPlayerController.asset('assets/splash_video_updated_3s.mp4')
          ..initialize().then((_) {
            setState(() {});
          });
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    _initializeVideo();
    _sizeAnimation = Tween<double>(begin: 60, end: 100).animate(_controller);
    _opacityAnimation =
        Tween<double>(begin: 0.3, end: 1.0).animate(_controller);

    _controller.forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _videoController.play();
      }
    });

    _videoController.addListener(() {
      final duration = _videoController.value.position.inMilliseconds;
      // print("VIDEO: ${duration}");
      if (duration > 2999) {
        _videoController.pause();
        // Navigator.pushReplacement(context,
        //     MaterialPageRoute(builder: (context) => const IntroScreen()));
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const StartupPage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenHeight = size.height;

    return Scaffold(
      body: Consumer(
        builder: (context, ref, _) {
          ref.read(authProvider);
          return Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.grey.shade500,
                child: VideoPlayer(_videoController),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                  ),

                  AnimatedBuilder(
                      animation: _sizeAnimation,
                      builder: (context, _) {
                        // return Image.asset(
                        //   "assets/images/logos/party_onebottom.png",
                        //   height: _sizeAnimation.value,
                        // );
                        return SvgPicture.asset(
                          logo,
                          height: _sizeAnimation.value,
                        );
                      }),

                  // TextButton(onPressed: (){
                  //   if(_controller.isCompleted){
                  //     _controller.reset();
                  //   }else{
                  //   _controller.forward();
                  //   }
                  // }, child: Text('Animate')),

                  SizedBox(
                    height: screenHeight * 0.25,
                  ),

                  Padding(
                    padding: EdgeInsets.only(bottom: screenHeight * 0.1),
                    child: AnimatedBuilder(
                      animation: _opacityAnimation,
                      builder: (context, _) {
                        return Opacity(
                          opacity: _opacityAnimation.value,
                          child: Text(
                            'Your Access To Global Nightlife',
                            style: tenor22Gold,
                          ),
                        );
                      },
                    ),
                  ),

                  AnimatedBuilder(
                      animation: _sizeAnimation,
                      builder: (context, _) {
                        return SizedBox(
                          height: _sizeAnimation.value - 60,
                        );
                      })
                ],
              ),
            ],
          );
        }
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _videoController.dispose();
    debugPrint('SPLASH SCREEN DISPOSED');
  }
}
