import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:htp_customer/features/profile/controller/profile_controller.dart';
import 'package:htp_customer/features/profile/presentation/screens/profile_screen.dart';
import 'package:htp_customer/htp_theme.dart';

import '../../../profile/presentation/profile_page.dart';
import '../../controllers/dashboard_controllers.dart';

class ProfileIcon extends StatelessWidget {
  final VoidCallback? onProfileTap;
  final bool showName;
  const ProfileIcon({Key? key, this.onProfileTap, this.showName = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
      final profileController = ref.watch(profileControllerProvider);

      return GestureDetector(
        onTap: () {
          if (onProfileTap != null) {
            onProfileTap!();
          } else {
            Navigator.pushNamed(context, ProfileScreen.route);
            // ref
            //     .read(dashboardProvider.notifier)
            //     .gotoPage(TabItem.membership, ProfilePage.route);
          }
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (showName)
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    "Welcome,",
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                  if (profileController is ProfileLoaded)
                    Text(
                      profileController.profileData.name,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  // if (profileController is ProfileLoaded)
                  //   const Text(
                  //     "Dua",
                  //     style: TextStyle(
                  //         fontSize: 14,
                  //         fontWeight: FontWeight.w600,
                  //         color: Colors.white),
                  //   )
                ],
              ),
            if (profileController is ProfileLoaded)
              Padding(
                padding: const EdgeInsets.only(left: 6, top: 4),
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.transparent,
                  // backgroundImage:
                  //     const AssetImage('assets/images/profile-back.png'),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: profileController.profileData.profileImage == null
                          ? const Image(
                              image: AssetImage(
                                  'assets/images/placeholders/profile_placeholder.png'),
                              height: 50,
                              width: 50,
                            )
                          : Image(
                              image: NetworkImage(
                                  profileController.profileData.profileImage!),
                              // image: AssetImage('assets/images/temp/profile.png'),
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                            )),
                ),
              ),
            if (profileController is ProfileLoading)
              const CircularProgressIndicator(color: HtpTheme.goldenColor),
          ],
        ),
      );
    });
  }
}
