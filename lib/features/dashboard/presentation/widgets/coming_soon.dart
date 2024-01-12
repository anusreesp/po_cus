import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../common/widgets_common/needles_widget.dart';

class ComingSoonPart extends StatefulWidget {
  const ComingSoonPart({super.key});

  @override
  State<ComingSoonPart> createState() => _ComingSoonPartState();
}

class _ComingSoonPartState extends State<ComingSoonPart> {
  String basicPath = "assets/images/coming_soon/";

  List<String> title = [
    "Yacht and Charter Services",
    "Concerts",
    "Art and Decor",
    "Celebrity Chefs",
    "Milestone Celebration",
    "Take Me Home",
    "Health and Wellness",
    "Sporting Events",
    "Luxury Shopping and Gifting"
  ];

  List<String> imgName = [
    "yacht_and_charter.png",
    "concerts.png",
    "art_and_decorations.png",
    "celebrity_chefs.png",
    "milestone_celebrations.png",
    "take_me_home.png",
    "health_and_wellness.png",
    "sporting_events.png",
    "luxury_shopping.png"
  ];

  final ScrollController _soonScrollController = ScrollController();
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
        if (_soonScrollController.hasClients) {
          // if (_soonScrollController.position.pixels ==
          //     _soonScrollController.position.maxScrollExtent) {
          //   _soonScrollController.animateTo(
          //       _soonScrollController.position.minScrollExtent,
          //       duration: const Duration(seconds: 1),
          //       curve: Curves.linear);
          // } else {
          _soonScrollController.animateTo(
              _soonScrollController.position.pixels + 180,
              duration: const Duration(seconds: 1),
              curve: Curves.linear);
          // }
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // itemCount: 9,
      // reverse: true,
      scrollDirection: Axis.horizontal,
      controller: _soonScrollController,
      itemBuilder: (BuildContext context, int index) {
        // if (index == 8) {
        //   _isLastOne = true;
        // } else {
        //   _isLastOne = false;
        // }

        final i = index % 9;
        return Container(
          padding: const EdgeInsets.only(left: 12),
          margin: EdgeInsets.only(right: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(8)),
                    child: Image.asset(
                      "$basicPath" "${imgName[i]}",
                      height: 135,
                      width: 170,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Positioned(
                      bottom: 0,
                      child: Padding(
                        padding: EdgeInsets.only(left: 1.0),
                        child: NeedleHorizontal(
                          thickness: 1.5,
                          width: 170,
                        ),
                      ))
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(mainAxisSize: MainAxisSize.min, children: [
                SizedBox(width: 170, child: Text(title[i])),
              ])
            ],
          ),
        );
      },
    );
  }
}
