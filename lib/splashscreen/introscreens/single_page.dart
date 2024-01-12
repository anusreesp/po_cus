import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:htp_customer/authentication/controllers/auth_controller.dart';
import 'package:htp_customer/common/widgets_common/rounded_golden_button.dart';
import 'package:htp_customer/htp_theme.dart';
import 'package:htp_customer/router.dart';
import 'package:htp_customer/startup_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EachPage extends ConsumerWidget {
  final String message;
  final String image;
  final String subTitle;
  final int currentIndex;
  final int totalCount;
  const EachPage(
      {super.key,
      required this.message,
      required this.subTitle,
      required this.image,
      required this.currentIndex,
      required this.totalCount});

  bool get lastPage => currentIndex == (totalCount - 1);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(image),
            // opacity: 0.45
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        // decoration: BoxDecoration(color: Colors.black.withOpacity(0.4)),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // const SizedBox(
            //   height: 40,
            // ),
            const Spacer(),

            Text(message, style: const TextStyle(fontFamily: tenorSans, fontSize: 26, color: Color(0xffD3BB8A))),
            Text(subTitle, style: const TextStyle(fontFamily: tenorSans, fontSize: 26),),

            SizedBox(
              height: lastPage ? 84 : 170,
            ),
            // const Spacer(),

            if (lastPage)
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: SizedBox(
                    width: 190,
                    child: RoundedGoldenButtonWithChild(
                        height: 50,
                        onTap: () async {
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setBool('onboard', true);
                          await ref.read(authProvider.notifier).checkUser();
                          mainNavigatorKey.currentState
                              ?.pushReplacementNamed(StartupPage.route);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Get Started', style: man16DarkBlue),
                            const SizedBox(
                              width: 10,
                            ),
                            SvgPicture.asset(
                                'assets/svg/arrow_splashscreen.svg')
                            // Icon(Icons.arrow_forward_outlined, color: Colors.black,)
                          ],
                        )),
                  ),
                ),
              ),
            // Image.asset(
            //   logoImage,
            //   fit: BoxFit.scaleDown,
            //   width: 100,
            //   height: 100,
            // ),

            // SizedBox(
            //   height: 100,
            //   child: currentIndex == (totalCount - 1)
            //       ? Row(
            //           children: [
            //             const Spacer(),
            //             IconButton(
            //                 iconSize: 60,
            //                 // color: Colors.white.withOpacity(0.2),
            //                 onPressed: () async {
            //                   // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
            //                   // mainNavigatorKey.currentState?.pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginPage()), (route) => route.isFirst);
            //                   final prefs =
            //                       await SharedPreferences.getInstance();
            //                   prefs.setBool('onboard', true);
            //                   await ref.read(authProvider.notifier).checkUser();
            //                   mainNavigatorKey.currentState
            //                       ?.pushReplacementNamed(StartupPage.route);
            //                   // mainNavigatorKey.currentState?.pushReplacement(
            //                   //
            //                   //     MaterialPageRoute(
            //                   //         builder: (context) => LoginPage()));
            //                 },
            //                 // icon: CircleAvatar(
            //                 //   backgroundColor: Colors.white38,
            //                 //   child: const Icon(
            //                 //     Icons.arrow_forward_ios_outlined,
            //                 //     color: Colors.white,
            //                 //     size: 30,
            //                 //   ),
            //                 // )),
            //                 icon: const Icon(
            //                   Icons.arrow_forward_ios_outlined,
            //                   color: Colors.white,
            //                   size: 30,
            //                 )),
            //             const SizedBox(
            //               width: 8,
            //             )
            //           ],
            //         )
            //       : null,
            // )
          ],
        ),
      ),
    );
  }
}
