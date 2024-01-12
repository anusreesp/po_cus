import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:htp_customer/common/widgets_common/app_bar_back_button.dart';
import 'package:htp_customer/common/widgets_common/needles_widget.dart';
import 'package:htp_customer/features/dashboard/controllers/dashboard_controllers.dart';
import 'package:htp_customer/features/dashboard/data/services/dashboard_service.dart';
import 'package:htp_customer/features/profile/presentation/widgets/support_tile.dart';
import 'package:htp_customer/freshchat/controllers/freshchat_controller.dart';
import 'package:htp_customer/htp_theme.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;
import 'package:url_launcher/url_launcher_string.dart';

class SupportPage extends ConsumerWidget {
  ///if you are not navigating to this screen from home, give true value.
  final bool isNotFromHome;
  static const route = '/support-page';
  const SupportPage({
    Key? key,
    required this.isNotFromHome,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final service = ref.watch(dashboardServiceProvider);
    final List<Map<String, String>> tileList = [
      {"title": "Call us", "img": "assets/svg/icons/support/callus_icon.svg"},
      {"title": "Whatsapp", "img": "assets/svg/icons/support/watsapp_icon.svg"},
      {"title": "Mail", "img": "assets/svg/icons/support/mail_icon.svg"},
      // {
      //   "title": "Chat with our support team",
      //   "img": "assets/svg/icons/support/chat_with_our_support_team.svg"
      // },
    ];
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("CONCIERGE"),
        leading: AppbarBackButton(
          onTap: () {
            if (isNotFromHome == true) {
              print("POP");
              Navigator.of(context).pop();
            } else {
              ref.read(dashboardProvider.notifier).selectTab(TabItem.home);
            }
          },
        ),
        //   leading: GestureDetector(
        //   child: Padding(
        //     padding: const EdgeInsets.all(20),
        //     child: SvgPicture.asset('assets/svg/icons/support/arrowleft.svg',),
        //   ),
        //   onTap: (){
        //     if(isFromProfile == true){
        //       Navigator.of(context).pop();
        //     }else{
        //       ref.read(dashboardProvider.notifier).selectTab(TabItem.home);
        //     }
        //   },
        // ),
      ),
      body: FutureBuilder(
          future: service.getSupportDetails(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    width: 324,
                    child: Text(
                      "Personal nightlife concierge at your service, 24/7!",
                      style: tenor22LightBlue,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  NeedleVertical(
                    height: size.height / 12,
                    thickness: 1,
                  ),

                  Expanded(
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        for (int index = 0; index < 3; index++)
                          SupportTile(
                              imgPath: tileList[index]['img'].toString(),
                              text: tileList[index]['title'].toString(),
                              onTap: () async {
                                if (index == 0) {
                                  await urlLauncher.launchUrl(Uri(
                                      path: snapshot.data?['phone'],
                                      scheme: 'tel'));
                                } else if (index == 1) {
                                  urlLauncher.launchUrl(
                                      Uri.parse(
                                        "https://api.whatsapp.com/send/?phone=${snapshot.data?['whatapp']}&text=Hi,\nI would like to know more about the services offered by Party One.",
                                      ),
                                      mode: Platform.isIOS
                                          ? LaunchMode.platformDefault
                                          : LaunchMode
                                              .externalNonBrowserApplication);
                                } else if (index == 2) {
                                  urlLauncher.launchUrl(Uri(
                                      path: snapshot.data?['email'],
                                      scheme: 'mailto'));
                                }
                              })
                      ],
                    ),
                  ),

                  // Container(
                  //   padding: const EdgeInsets.symmetric(horizontal: 28),
                  //   height: size.width,
                  //   width: size.width,
                  //   child: MediaQuery.removePadding(
                  //     removeLeft: true,
                  //     removeBottom: true,
                  //     context: context,
                  //     removeRight: true,
                  //     removeTop: true,
                  //     child: GridView.builder(
                  //         physics: const NeverScrollableScrollPhysics(),
                  //         itemCount: tileList.length,
                  //         shrinkWrap: true,
                  //         gridDelegate:
                  //             const SliverGridDelegateWithFixedCrossAxisCount(
                  //                 crossAxisCount: 2),
                  //         itemBuilder: (context, index) {
                  //           return SupportTile(
                  //             onTap: () {
                  //               if (index == 0) {
                  //                 urlLauncher.launchUrl(
                  //                     Uri(path: "+917200073471", scheme: 'tel'));
                  //               } else if (index == 1) {
                  //                 urlLauncher.launchUrl(
                  //                     Uri.parse(
                  //                       "https://api.whatsapp.com/send/?phone=+6583723459",
                  //                     ),
                  //                     mode: LaunchMode.externalNonBrowserApplication);
                  //               } else if (index == 2) {
                  //                 urlLauncher.launchUrl(Uri(
                  //                     path: "support@party.one", scheme: 'mailto'));
                  //               } else {
                  //                 ref.read(freshChatProvider).startChat();
                  //               }
                  //             },
                  //             imgPath: tileList[index]['img'].toString(),
                  //             text: tileList[index]['title'].toString(),
                  //           );
                  //         }),
                  //   ),
                  // ),
                  // SizedBox(height: size.height / 50),
                  if (isNotFromHome == true) SizedBox(height: size.height / 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("You can always write to us at ",
                          style: man14LightBlue),
                      GestureDetector(
                          onTap: () {
                            urlLauncher.launchUrl(Uri(
                                path: "support@party.one", scheme: 'mailto'));
                          },
                          child: const Text(
                            "support@party.one",
                            style: man14Gold,
                          )),
                    ],
                  ),

                  const SizedBox(
                    height: 120,
                  )
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
