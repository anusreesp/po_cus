import 'dart:io';

import 'package:flutter/material.dart';
import 'package:htp_customer/common/utils/common_links.dart';
import 'package:htp_customer/common/widgets_common/app_bar_back_button.dart';
import 'package:htp_customer/common/widgets_common/needles_widget.dart';
import 'package:htp_customer/htp_theme.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;
import 'package:url_launcher/url_launcher_string.dart';

class AboutUsNew extends StatelessWidget {
  static const route = 'about-us';
  const AboutUsNew({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("ABOUT US", style: man14LightBlue),
          leading: AppbarBackButton()),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 49,
            ),
            Text(
              "About Us",
              style: tenor22White,
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "Party One evolved from the idea of creating an app for travellers around the world to plan a night out, pick the most happening clubs or bars, make reservations or get access to exclusive events with just a few clicks.",
              style: man14LightBlue,
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              'Harnessing our partnerships & connections with the top clubs, best venues and event organizers worldwide, we’ve built an AI-enabled intuitive platform that enables you to enjoy nightlife to the fullest without having to worry about the uncertainty of whether you’ll be able to secure a spot at your preferred clubs/bars/events. Whether it is celebrating a special occasion or simply looking to unwind in a vibrant nightlife setting, Party One makes it happen.',
              style: man14LightBlue,
            ),

            SizedBox(
              height: 49,
            ),
            Text(
              "Legal",
              style: tenor22White,
            ),
            SizedBox(
              height: 26,
            ),
            GestureDetector(
              onTap: () {
                urlLauncher.launchUrl(
                    Uri.parse(
                      "${supportLink}privacy/",
                    ),
                    mode: Platform.isIOS ? LaunchMode.platformDefault : LaunchMode.externalNonBrowserApplication);
              },
              child: Container(
                color: Colors.transparent,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Privacy Policy",
                      style: man14LightBlue,
                    ),
                    SizedBox(
                      height: 26,
                    ),
                    NeedleDoubleSided(),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                urlLauncher.launchUrl(
                    Uri.parse(
                      "${supportLink}terms-and-conditions/",
                    ),
                    mode: Platform.isIOS ? LaunchMode.platformDefault : LaunchMode.externalNonBrowserApplication);
              },
              child: Container(
                color: Colors.transparent,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 26,
                    ),
                    Text(
                      "Terms & Conditions",
                      style: man14LightBlue,
                    ),
                    SizedBox(
                      height: 26,
                    ),
                    // NeedleDoubleSided(),
                  ],
                ),
              ),
            ),
            // GestureDetector(
            //   onTap: () {
            //     urlLauncher.launchUrl(
            //         Uri.parse(
            //           "${supportLink}licenses/",
            //         ),
            //         mode: LaunchMode.externalNonBrowserApplication);
            //   },
            //   child: Container(
            //     color: Colors.transparent,
            //     width: MediaQuery.of(context).size.width,
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         SizedBox(
            //           height: 26,
            //         ),
            //         Text(
            //           "Licenses",
            //           style: man14LightBlue,
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
