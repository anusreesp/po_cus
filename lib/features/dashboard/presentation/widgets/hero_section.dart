import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:htp_customer/features/dashboard/controllers/dashboard_controllers.dart';
import 'package:htp_customer/shared_prefs_provider.dart';
import 'package:video_player/video_player.dart';

import '../../../../common/widgets_common/needles_widget.dart';
import '../../../../htp_theme.dart';
import '../../../membership/presentation/memberships.dart';

class HeroSectionExistingUser extends ConsumerStatefulWidget {
  const HeroSectionExistingUser({super.key});

  @override
  HeroSectionExistingUserState createState() => HeroSectionExistingUserState();
}

class HeroSectionExistingUserState
    extends ConsumerState<HeroSectionExistingUser> {
  late VideoPlayerController _videoController;

  _initializeDefaultVideo() {
    debugPrint("Initialized downloaded video");
    _videoController = VideoPlayerController.asset('assets/dj_new_e.mp4',
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true))
      ..initialize().then((_) {
        debugPrint("Initialized default video : DONE");
        setState(() {});
        _videoController.play();
        _videoController.setVolume(0);
        _videoController.setLooping(true);
      });
  }

  _initializedDownloadedVideo(String path) async{
    debugPrint("Initialized downloaded NEW USER video");
    final file = File(path);

    _videoController = VideoPlayerController.file(file)
      ..initialize().then((_) {
        debugPrint("Initialized downloaded video DONE");
        setState(() {});
        _videoController.play();
        _videoController.setLooping(true);
      });

    final fileExist =  await file.exists();
    if(!fileExist){
      _initializeDefaultVideo();
      ///Download video in background if new video has issue
      ref.read(dashboardProvider.notifier).processHeroVideo();
    }
  }

  @override
  void initState() {
    super.initState();

    ///Check video stored locally from cloud
    final storedVideo = ref
        .read(sharedPrefsProvider)
        .getString(SharedPrefsKey.localHeroVideoPath);
    if (storedVideo != null) { ///If video download play it, else play default
      // _initializeDefaultVideo();
      _initializedDownloadedVideo(storedVideo);
    } else {
      _initializeDefaultVideo();
    }

    ///Download video in background if new video is there
    ref.read(dashboardProvider.notifier).processHeroVideo();
  }

  @override
  void dispose() {
    super.dispose();
    _videoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Container(
      color: Colors.blueGrey,
      height: height,
      width: width,
      child: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: HtpTheme.darkGrey4Color,
            child: SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                    height: _videoController.value.size.height,
                    width: _videoController.value.size.width,
                    child: VideoPlayer(_videoController)),
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: height * 0.2,
                width: double.infinity,
              ),
              // SvgPicture.asset(logoSideText, height: 34,),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                        style: tenor22LightBlue,
                        text: 'Elevate Your Nightlife \n',
                        children: [
                          TextSpan(
                              text: 'Experiences',
                              style: TextStyle(fontSize: 38))
                        ])),
              ),
              const Spacer(),
              NeedleVertical(
                height: height * 0.16,
                thickness: 1,
              ),

              const Spacer(),
              Container(
                height: 30,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      // Colors.transparent,
                      HtpTheme.darkBlue1Color.withOpacity(0.05),
                      HtpTheme.darkBlue1Color
                    ])),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class HeroSection extends ConsumerStatefulWidget {
  const HeroSection({super.key});

  @override
  HeroSectionState createState() => HeroSectionState();
}

class HeroSectionState extends ConsumerState<HeroSection> {
  late VideoPlayerController _videoController;

  _initializeDefaultVideo() {
    debugPrint("Initialized default video");
    _videoController = VideoPlayerController.asset('assets/dj_new_e.mp4',
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true))
      ..initialize().then((_) {
        debugPrint("Initialized default video DONE");
        setState(() {});
        _videoController.play();
        _videoController.setVolume(0);
        _videoController.setLooping(true);
      });
  }

  _initializedDownloadedVideo(String path) async{
    debugPrint("Initialized downloaded NEW USER video");
    final file = File(path);

    _videoController = VideoPlayerController.file(file)
      ..initialize().then((_) {
        debugPrint("Initialized downloaded video DONE");
        setState(() {});
        _videoController.play();
        _videoController.setLooping(true);
      });

    final fileExist =  await file.exists();
    if(!fileExist){
      _initializeDefaultVideo();
      ///Download video in background if new video has issue
      ref.read(dashboardProvider.notifier).processHeroVideo();
    }
  }

  @override
  void initState() {
    super.initState();

    ///Check video stored locally from cloud
    final storedVideo = ref
        .read(sharedPrefsProvider)
        .getString(SharedPrefsKey.localHeroVideoPath);
    if (storedVideo != null) { ///If video download play it, else play default
      // _initializeDefaultVideo();
      _initializedDownloadedVideo(storedVideo);
    } else {
      _initializeDefaultVideo();
    }

    ///Download video in background if new video is there
    ref.read(dashboardProvider.notifier).processHeroVideo();
  }

  @override
  void dispose() {
    super.dispose();
    _videoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Container(
      color: Colors.blueGrey,
      height: height,
      width: width,
      child: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.grey.shade500,
            child: VideoPlayer(_videoController),
          ),
          Column(
            children: [
              SizedBox(
                height: height * 0.15,
              ),
              // SvgPicture.asset(logoSideText, height: 34,),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                        style: tenor22LightBlue,
                        text: 'Your Access To \n',
                        children: [
                          TextSpan(
                              text: 'Global Nightlife',
                              style: TextStyle(fontSize: 38))
                        ])),
              ),

              NeedleVertical(
                height: height * 0.14,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, MembershipsPage.route);
                },
                child: Image.asset(
                  'assets/images/membership_circle.png',
                  height: height * 0.16,
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),

              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, MembershipsPage.route);
                },
                child: Stack(
                  // fit: StackFit.loose,
                  clipBehavior: Clip.none,
                  alignment: AlignmentDirectional.center,
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.black87,
                      radius: 50,
                    ),
                    Positioned(
                        top: -20,
                        child: NeedleVertical(
                          height: height * 0.1,
                        )),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, MembershipsPage.route);
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'EXPLORE MEMBERSHIPS',
                            style: tenor12WhiteBold,
                          ),
                          // const SizedBox(
                          //   width: 8,
                          // ),
                          // SvgPicture.asset(
                          //   'assets/svg/arrow_splashscreen.svg',
                          //   color: Colors.white,
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const Icon(Icons.keyboard_arrow_down),
            ],
          ),
        ],
      ),
    );
  }
}
