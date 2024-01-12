import 'package:change_case/change_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:htp_customer/features/dashboard/controllers/dashboard_controllers.dart';
import 'package:htp_customer/features/dashboard/presentation/pages/home.dart';
import 'package:htp_customer/features/ladiesnight/ladiesnight.dart';
import 'package:htp_customer/features/locations/presentation/location.dart';
import 'package:htp_customer/features/membership/presentation/memberships.dart';
import 'package:htp_customer/features/profile/presentation/screens/about_us.dart';
import 'package:htp_customer/features/profile/presentation/screens/my_bookings_screen.dart';
import 'package:htp_customer/features/profile/presentation/screens/profile_screen.dart';
import 'package:htp_customer/features/profile/presentation/screens/test/my_booking_screen.dart';

import 'package:htp_customer/htp_theme.dart';
import 'package:htp_customer/router.dart';
import 'package:htp_customer/shimmers/base_shimmer.dart';
import '../../../../common/utils/member_utils.dart';
import '../../../profile/controller/profile_controller.dart';

class CustomDrawer extends ConsumerWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    const leftPadding = 28.0;
    // final currentTab = ref.watch(dashboardProvider);
    return Container(
      width: size.width * 0.85,
      height: size.height,
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container(
          //   height: 144,
          //   color: Colors.black,
          //   padding: const EdgeInsets.only(top: 16, bottom: 8),
          //   child: Row(
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       ///-------------------------------------------------------new logo replace here-------------------------------------
          //       const Padding(
          //         padding: EdgeInsets.only(left: 16.0),
          //         child: Image(
          //           image: AssetImage('assets/images/logos/party_one_logo.png'),
          //           height: 60,
          //         ),
          //       ),
          //       const Spacer(),
          //       ProfileIcon(
          //         showName: true,
          //         onProfileTap: (){
          //           print('Profile click');
          //           Navigator.of(context).pop();
          //           Navigator.pushNamed(context, ProfilePage.route);
          //           // ref
          //           //     .read(dashboardProvider.notifier)
          //           //     .gotoPage(TabItem.home, ProfilePage.route);
          //         },
          //       ),
          //       IconButton(
          //           onPressed: () {
          //             Navigator.pop(context);
          //           },
          //           icon: const Icon(
          //             Icons.close,
          //             color: Color(0xffe8d48a),
          //             size: 26,
          //           ))
          //     ],
          //   ),
          // ),

          InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: SafeArea(
                child: SizedBox(
                  height: kToolbarHeight,
                  width: kToolbarHeight,
                  child: Center(
                    child: SvgPicture.asset(
                        'assets/svg/icons/dashboard/hamburger_active.svg'),
                  ),
                ),
              )),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 10,
                left: leftPadding,
              ),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Consumer(builder: (context, ref, _) {
                      final profileController =
                          ref.watch(profileControllerProvider);
                      print("Status------------${profileController}");
                      if (profileController is ProfileLoaded) {
                        final membershipCircle =
                            MemberUtils.getMembershipCircle(
                                profileController.profileData.membershipType);
                        return GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, ProfileScreen.route);
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: profileController
                                                  .profileData.profileImage ==
                                              null
                                          ? const Image(
                                              image: AssetImage(
                                                  'assets/images/placeholders/profile_placeholder.png'),
                                              height: 80,
                                              width: 80,
                                            )
                                          : Image(
                                              image: NetworkImage(
                                                  profileController.profileData
                                                      .profileImage!),
                                              // image: AssetImage('assets/images/temp/profile.png'),
                                              height: 80,
                                              width: 80,
                                              fit: BoxFit.cover,
                                            )),
                                  if (membershipCircle != null)
                                    Positioned(
                                        right: -6,
                                        child: Image.asset(
                                          membershipCircle,
                                          height: 30,
                                        )),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 22.0),
                                child: Text(
                                  profileController.profileData.name
                                      .toTitleCase(),
                                  style: tenor22LightBlue,
                                ),
                              )
                            ],
                          ),
                        );
                      } else {
                        return const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // SizedBox(height: 10,),
                            BaseShimmer(
                              child: ShimmerBoxCornered(
                                height: 80,
                                width: 80,
                                borderRadius: 40,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            BaseShimmer(
                              child: ShimmerBoxCornered(
                                height: 20,
                                width: 120,
                                borderRadius: 6,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                          ],
                        );
                      }
                    }),

                    const SizedBox(
                      height: 4,
                    ),

                    DrawerRow(
                        title: "Home",
                        // iconName: "home_f.png",
                        iconName: 'assets/svg/icons/nav_bar/home.svg',
                        onTap: () {
                          // Navigator.of(context).pop();
                          ref
                              .read(dashboardProvider.notifier)
                              .selectTab(TabItem.home);
                          homeScrollController.jumpTo(0);
                        }),

                    DrawerRow(
                        title: "Profile",
                        iconName: 'assets/svg/icons/nav_bar/profile_icon.svg',
                        onTap: () {
                          Navigator.pushNamed(context, ProfileScreen.route);
                        }),

                    DrawerRow(
                        title: "Location",
                        iconName: "assets/svg/icons/drawer/location.svg",
                        onTap: () {
                          Navigator.pushNamed(context, LocationPage.route);
                        }),
                    DrawerRow(
                        title: "Clubs",
                        iconName: "assets/svg/icons/nav_bar/bottle.svg",
                        onTap: () {
                          ref
                              .read(dashboardProvider.notifier)
                              .selectTab(TabItem.clubs);
                        }),
                    DrawerRow(
                        title: "Events",
                        iconName: "assets/svg/icons/nav_bar/ticket.svg",
                        onTap: () {
                          ref
                              .read(dashboardProvider.notifier)
                              .selectTab(TabItem.events);
                        }),
                    DrawerRow(
                        title: "Memberships",
                        iconName:
                            "assets/svg/icons/nav_bar/membership_icon.svg",
                        onTap: () {
                          Navigator.pushNamed(context, MembershipsPage.route);

                          // ref
                          //     .read(dashboardProvider.notifier)
                          //     .selectTabHome(TabItem.home);
                        }),

                    DrawerRow(
                        title: "My Bookings",
                        iconName: "assets/svg/icons/nav_bar/booking_Icon.svg",
                        onTap: () {
                          // ref
                          //     .read(dashboardProvider.notifier)
                          //     .selectTabHome(TabItem.home);
                          // Navigator.pop(context);
                          Navigator.pushNamed(context, MyBookingsScreen.route);
                        }),

                    DrawerRow(
                        title: "Ladies Night",
                        iconName: "assets/svg/icons/nav_bar/ladies_night.svg",
                        onTap: () {
                          // ref
                          //     .read(dashboardProvider.notifier)
                          //     .selectTabHome(TabItem.home);
                          // Navigator.pop(context);
                          Navigator.pushNamed(context, LadiesNight.route);
                        }),

                    const SizedBox(
                      height: 4,
                    ),
                    // DrawerRow(
                    //   title: "Ladies Night",
                    //   iconName: "assets/svg/icons/drawer/ladies_night.svg",
                    //   onTap: () {
                    //     ref
                    //         .read(dashboardProvider.notifier)
                    //         .gotoPage(TabItem.home, LadiesNight.route);
                    //
                    //   },
                    // ),

                    // DrawerRow(
                    //     title: "Take Me Home",
                    //     iconName: "assets/svg/icons/drawer/take_me_home.svg",
                    //     onTap: () {
                    //       ref.read(dashboardProvider.notifier)
                    //           // .gotoPage(TabItem.locations, IDVerificationPage.route);
                    //
                    //       .gotoPage(TabItem.membership, TakeMeHome.route);
                    //       // .gotoPage(TabItem.clubs, ConfirmTicket.route);
                    //     }),

                    // DrawerRow(
                    //     title: "Test",
                    //     iconName: "assets/svg/icons/bottle_icon.svg",
                    //     onTap: () {
                    //       Navigator.push(context, MaterialPageRoute(builder: (context) => TextPage()));
                    //       // ref.read(freshChatProvider).startChat();
                    //     }),

                    // const Spacer(),
                    // Row(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     GestureDetector(
                    //       onTap: (){
                    //         launchUrl(Uri.parse('https://party.one/privacy/'));
                    //       },
                    //       child: const Text(
                    //         "Privacy Policy",
                    //         style: TextStyle(
                    //             color: Colors.grey,
                    //             fontSize: 14,
                    //             fontWeight: FontWeight.w500),
                    //       ),
                    //     ),
                    //
                    //     GestureDetector(
                    //       onTap: (){
                    //         launchUrl(Uri.parse('https://party.one/terms-and-conditions/'));
                    //       },
                    //       child: const Text(
                    //         " | Terms & Conditions",
                    //         style: TextStyle(
                    //             color: Colors.grey,
                    //             fontSize: 14,
                    //             fontWeight: FontWeight.w500),
                    //       ),
                    //     ),
                    //   ],
                    // )
                  ],
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: leftPadding),
            child: Column(
              children: [
                DrawerRowNoTitle(
                    title: 'Contact Support',
                    onTap: () {
                      // ref.read(freshChatProvider).startChat();
                      // Navigator.pop(context);
                      ref
                          .read(dashboardProvider.notifier)
                          .selectTab(TabItem.support);
                    }),
                DrawerRowNoTitle(
                    title: 'About Us',
                    onTap: () {
                      // Navigator.pop(context);
                      mainNavigatorKey.currentState!
                          .pushNamed(AboutUsNew.route);
                    }),
                const SizedBox(
                  height: 22,
                ),
                DrawerRowNoTitle(
                    title: 'Logout',
                    titleTextStyle:
                        man16LightBlue.apply(color: Colors.redAccent),
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (context) {
                            return logoutDialog(context);
                          });
                    }),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class DrawerRow extends StatelessWidget {
  final String title;
  final String iconName;
  final Function onTap;
  const DrawerRow(
      {Key? key,
      required this.title,
      required this.iconName,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0.0),
      child: ListTile(
        onTap: () {
          debugPrint("--------------------------$title");
          Navigator.of(context).pop();
          onTap();
        },
        contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        horizontalTitleGap: -6,
        dense: true,
        leading: Container(
          alignment: Alignment.centerLeft,
          width: MediaQuery.of(context).size.width / 10,
          child: SizedBox(
            height: 40,
            width: 20,
            child: Center(
              child: SvgPicture.asset(
                alignment: Alignment.center,
                iconName,
                height: 20,
                width: 20,
                fit: BoxFit.scaleDown,
                color: HtpTheme.lightBlueColor,
              ),
            ),
          ),
        ),
        title: Text(title, style: man16LightBlue),
      ),
    );
  }
}

class DrawerRowNoTitle extends StatelessWidget {
  final String title;
  final Function onTap;
  final TextStyle? titleTextStyle;
  const DrawerRowNoTitle(
      {Key? key, required this.title, required this.onTap, this.titleTextStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18.0),
      child: GestureDetector(
        onTap: () {
          debugPrint("--------------------------$title");
          Navigator.of(context).pop();
          onTap();
        },
        child: Container(
          color: Colors.black87,
          child: Row(
            children: [Text(title, style: titleTextStyle ?? man16LightBlue)],
          ),
        ),
      ),
    );
  }
}

//
// class PngDrawer extends StatelessWidget {
//   final String title;
//   final String iconName;
//   final Function onTap;
//   const PngDrawer(
//       {Key? key,
//       required this.title,
//       required this.iconName,
//       required this.onTap})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 22.0),
//       child: GestureDetector(
//         onTap: () {
//           Navigator.of(context).pop();
//           onTap();
//         },
//         child: Row(
//           children: [
//             Image(
//               image: AssetImage('assets/images/icons/$iconName'),
//               height: 22,
//               width: 22,
//             ),
//             const SizedBox(
//               width: 18,
//             ),
//             Text(title,
//                 style:
//                     const TextStyle(fontSize: 18, fontWeight: FontWeight.w600))
//           ],
//         ),
//       ),
//     );
//   }
// }
