import 'package:change_case/change_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:htp_customer/common/utils/member_utils.dart';
import 'package:htp_customer/common/widgets_common/app_bar_back_button.dart';
import 'package:htp_customer/common/widgets_common/needles_widget.dart';
import 'package:htp_customer/common/widgets_common/outlined_black_button.dart';
import 'package:htp_customer/common/widgets_common/rounded_golden_button.dart';
import 'package:htp_customer/features/clubs/presentation/widgets/new/floatingButtons.dart';
import 'package:htp_customer/features/dashboard/controllers/email_verification_controller.dart';
import 'package:htp_customer/features/idverification/presentation/pages/selfie/selfie_capture.dart';
import 'package:htp_customer/features/membership/presentation/memberships.dart';
import 'package:htp_customer/features/profile/presentation/favouriteclub.dart';
import 'package:htp_customer/features/profile/presentation/screens/about_us.dart';
import 'package:htp_customer/features/profile/presentation/screens/account_settings.dart';
import 'package:htp_customer/features/profile/presentation/screens/my_bookings_screen.dart';
import 'package:htp_customer/features/profile/presentation/widgets/support.dart';
import 'package:htp_customer/htp_theme.dart';
import 'package:htp_customer/router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../authentication/controllers/auth_controller.dart';
import '../../../../authentication/data/service/firebase_auth_service.dart';
import '../../../dashboard/presentation/widgets/email_verify_check.dart';
import '../../controller/profile_controller.dart';
import 'loyalty_points.dart';
import 'profile_update_screen.dart';

class ProfileScreen extends ConsumerWidget {
  static const route = '/profile-screen';
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final fire = ref.watch(firebaseAuthServiceProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "PROFILE",
          style: man14LightBlue,
        ),
        leading: AppbarBackButton(),
        actions: [
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: SvgPicture.asset(
                'assets/svg/icons/profile/Edit_icon.svg',
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, UpdateProfileScreen.route);
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          fire.reloadUser();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Consumer(builder: (context, ref, _) {
              final profileController = ref.watch(profileControllerProvider);
              // final linkSentProvider = ref.watch(verificationLinkSentProvider);

              final fire = ref.watch(firebaseAuthServiceProvider);

              // bool isVerified = fire.isEmailVerified;
              final verificationStatus = ref.watch(emailVerificationProvider);
              final providerId = ref
                  .read(firebaseAuthServiceProvider)
                  .geCurrentUser()
                  ?.providerData
                  .first
                  .providerId;

              String membershipNumber(String? x) =>
                  "${x?.substring(0, 3)}  ${x?.substring(3, 7)}  ${x?.substring(7, 11)}  ${x?.substring(11, 15)}  ${x?.substring(15, x.length)}";

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (profileController is ProfileLoaded &&
                      profileController.activeMembershipData == null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: const Text(
                              "Unlock exclusive features with a membership",
                              style: man14LightBlue,
                              textAlign: TextAlign.center,
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        OutlinedBlackButton(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MembershipsPage()));
                            },
                            child: const Center(
                              child: Text(
                                "Get Membership",
                                style: man16White,
                              ),
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        ProfilePicIcon(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SelfieCapture(
                                          onCapture: (XFile file) async {
                                            debugPrint("Executed");
                                            debugPrint(
                                                "PROFILE IMAGE: ${file.path}");

                                            // showDialog(
                                            //     barrierDismissible: false,
                                            //     context: context, builder: (context) => const Center(child: CircularProgressIndicator(),));
                                            Navigator.pop(context);
                                            await ref
                                                .read(profileControllerProvider
                                                    .notifier)
                                                .updateProfileImage(file);
                                          },
                                        )));
                          },
                          img: profileController.profileData.profileImage ==
                                  null
                              ? "assets/images/placeholders/profile_placeholder.png"
                              : profileController.profileData.profileImage!,
                        )
                      ],
                    ),
                  if (profileController is ProfileLoaded &&
                      profileController.activeMembershipData != null)
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // profileController.activeMembershipData != null ? Image.network(
                        //   profileController
                        //       .activeMembershipData!.flatImage,
                        //   height: 200,
                        // ) : const SizedBox.shrink(),
                        // profileController.activeMembershipData != null
                        Visibility(
                          visible:
                              profileController.activeMembershipData != null,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              SizedBox(
                                height: size.height / 3.9,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const MembershipsPage()));
                                  },
                                  child: Image.asset(ref
                                      .read(profileControllerProvider.notifier)
                                      .membershipCardType(profileController
                                          .activeMembershipData?.id)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // : SizedBox.shrink(),
                        Positioned(
                            top: MediaQuery.of(context).size.height / 13.5,
                            left: 20,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (profileController
                                        .profileData.membershipType !=
                                    MembershipType.nonMember)
                                  SizedBox(
                                    width: 210,
                                    height: size.height * 0.07,
                                    child: Text(
                                        profileController.profileData.name
                                            .toTitleCase(),
                                        style: textstyleDetermine(
                                            profileController.profileData
                                                .activeMembershipName)[0],

                                        // tenor22White.merge(
                                        //     TextStyle(letterSpacing: 1.4)),
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                        maxLines: 2),
                                  ),
                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                                Text(
                                    membershipNumber(profileController
                                            .profileData
                                            .activeMembershipCardNo) ??
                                        "",
                                    style:
                                        //  man15LightBlue
                                        textstyleDetermine(profileController
                                            .profileData
                                            .activeMembershipName)[1]),
                                SizedBox(
                                  height: size.height * 0.017,
                                ),
                                Text(
                                    profileController
                                            .profileData.activeMembershipName ??
                                        "",
                                    style: textstyleDetermine(profileController
                                        .profileData.activeMembershipName)[2]
                                    //  tenor22White
                                    ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                    profileController.profileData
                                                .membershipStartDate !=
                                            null
                                        ? "Member since ${DateFormat('dd MMM yyyy').format(profileController.profileData.membershipStartDate!)}"
                                        : "",
                                    style: textstyleDetermine(profileController
                                        .profileData.activeMembershipName)[3]
                                    // tenor10White

                                    ),
                                Text(
                                    profileController.profileData
                                                .membershipEndDate !=
                                            null
                                        ? "Valid Until ${DateFormat('dd MMM yyyy').format(profileController.profileData.membershipEndDate!)}"
                                        : "",
                                    style: textstyleDetermine(profileController
                                        .profileData.activeMembershipName)[3]
                                    // tenor10White
                                    )
                              ],
                            )),
                        if (profileController is ProfileLoaded &&
                            profileController.activeMembershipData == null)
                          Positioned(
                              left: MediaQuery.of(context).size.width * 0.37,
                              top: size.height / 4.4,
                              child: ProfilePicIcon(
                                onTap: () {},
                                img: profileController
                                            .profileData.profileImage ==
                                        null
                                    ? "assets/images/placeholders/profile_placeholder.png"
                                    : profileController
                                        .profileData.profileImage!,
                              )),
                      ],
                    ),
                  if (profileController is ProfileLoaded &&
                      profileController.activeMembershipData != null)
                    const SizedBox(
                      height: 20,
                    ),

                  if (profileController is ProfileLoading)
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Center(
                        child: const CircularProgressIndicator(
                            color: HtpTheme.goldenColor),
                      ),
                    ),
                  if (profileController is ProfileError)
                    Container(
                        height: size.height * 0.8,
                        padding: const EdgeInsets.all(4.0),
                        child: Center(
                          child: Text(
                            "This account  doesn't exits",
                            style: man16White,
                          ),
                        )),
                  // SizedBox(
                  //   height: 52,
                  // ),
                  if (profileController is ProfileLoaded)
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  if (profileController is ProfileLoaded &&
                                      profileController.activeMembershipData !=
                                          null)
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 12.0),
                                      child: ProfilePicIcon(
                                        onTap: () {},
                                        img: profileController
                                                    .profileData.profileImage ==
                                                null
                                            ? "assets/images/placeholders/profile_placeholder.png"
                                            : profileController
                                                .profileData.profileImage!,
                                      ),
                                    ),
                                  const SizedBox(
                                    width: 24,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (profileController
                                                is ProfileLoaded &&
                                            profileController
                                                    .activeMembershipData !=
                                                null)
                                          Container(
                                            width: 210,
                                            // height: 60,
                                            padding: EdgeInsets.only(top: 24),
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                                profileController
                                                    .profileData.name
                                                    .toTitleCase(),
                                                style: tenor22White.merge(
                                                    TextStyle(
                                                        letterSpacing: 1.4)),
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.start,
                                                softWrap: false,
                                                maxLines: 2),
                                          ),
                                        if (profileController is ProfileLoaded)
                                          Text(
                                              profileController
                                                          .activeMembershipData !=
                                                      null
                                                  ? "${profileController.activeMembershipData?.name.toTitleCase()} Member"
                                                  : "",
                                              style: man14LightBlue),
                                        if (profileController
                                                is ProfileLoaded &&
                                            profileController
                                                    .activeMembershipData !=
                                                null)
                                          const SizedBox(
                                            height: 24,
                                          ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              if (profileController is ProfileLoaded &&
                                  profileController.activeMembershipData ==
                                      null)
                                SizedBox(
                                    // height: 54,
                                    width:
                                        MediaQuery.of(context).size.width - 44,
                                    child: Text(
                                        profileController.profileData.name,
                                        style: tenor16White,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                        maxLines: 2)),
                              SizedBox(
                                height:
                                    profileController.activeMembershipData ==
                                            null
                                        ? 16
                                        : 0,
                              ),
                              if (verificationStatus is EmailVerificationLoaded)
                                !verificationStatus.isVerifed
                                    ?

                                    // ? linkSentProvider == true
                                    //     ? SizedBox(
                                    //         width: MediaQuery.of(context)
                                    //                 .size
                                    //                 .width -
                                    //             12,
                                    //         child: const VerificationLinkSent())
                                    //     :
                                    (providerId != 'google.com' ||
                                            providerId != 'apple.com')
                                        ? SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                12,
                                            child:
                                                const EmailVerifictionSection())
                                        : SizedBox()
                                    : Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        width:
                                            MediaQuery.of(context).size.width -
                                                44,
                                        child: const Text(
                                          "Update your profile for a personalized experience. The information you share will help us enhance your experience.",
                                          style: man14LightBlue,
                                          textAlign: TextAlign.center,
                                        )),
                              const SizedBox(
                                height: 16,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: Column(
                              children: [
                                settingTile("My Bookings",
                                    "assets/svg/icons/profile/mybookings_icon.svg",
                                    () {
                                  mainNavigatorKey.currentState!
                                      .pushNamed(MyBookingsScreen.route);
                                  // Navigator.push(context, MaterialPageRoute(builder: (context)=> NewBooking()));
                                }, context),
                                settingTile("Loyalty Points",
                                    "assets/svg/icons/my_bookings/loyalty points icon.svg",
                                    () {
                                  mainNavigatorKey.currentState!
                                      .pushNamed(LoyaltyPointsScreen.route);
                                  // Navigator.push(context, MaterialPageRoute(builder: (context)=> NewBooking()));
                                }, context),
                                settingTile("My Favourite Clubs",
                                    "assets/svg/icons/profile/myfavouriteclub_icon.svg",
                                    () {
                                  mainNavigatorKey.currentState!
                                      .pushNamed(FavouriteClub.route);
                                }, context),
                                settingTile(" Support",
                                    "assets/svg/icons/profile/support.svg", () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SupportPage(
                                                isNotFromHome: true,
                                              )));
                                }, context),
                                settingTile("Account Settings",
                                    "assets/svg/icons/profile/accountsettings_icon.svg",
                                    () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AccountSettingsPage()));
                                }, context),
                                settingTile("About Us",
                                    "assets/svg/icons/po-about-ico.svg", () {
                                  mainNavigatorKey.currentState!
                                      .pushNamed(AboutUsNew.route);
                                }, context),
                                settingTile("Logout",
                                    "assets/svg/icons/profile/logouticon.svg",
                                    () async {
                                  // await ref.read(authProvider.notifier).logOut();
                                  // Navigator.popUntil(context, (route) => route.isFirst);
                                  showModalBottomSheet(
                                      context: context,
                                      backgroundColor: Colors.transparent,
                                      builder: (context) {
                                        return logoutDialog(context);
                                      });
                                  //     showBottomSheet(context: context, builder: (context){
                                  //       return UpdateAppComponent(
                                  //         onConfirm: (){},
                                  //         onTapClose: (){},
                                  //         image: "assets/svg/icons/update_app_icon.svg",
                                  //       );
                                  //     });
                                }, context),
                                const SizedBox(
                                  height: 32,
                                ),
                              ],
                            ),
                          )
                        ])
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  textstyleDetermine(String? membership) {
    switch (membership) {
      case 'Gold':
        return [
          tenor22Black.merge(const TextStyle(letterSpacing: 1.4)),
          man15Black,
          tenor22Black,
          tenor10Black
        ];
      case 'Solitaire':
        return [
          tenor22White.merge(const TextStyle(letterSpacing: 1.4)),
          man15LightBlue,
          tenor22White,
          tenor10White,
        ];
      case 'Silver':
        return [
          tenor22Black.merge(const TextStyle(letterSpacing: 1.4)),
          man15Black,
          tenor22Black,
          tenor10Black
        ];
      case 'Platinum':
        return [
          tenor22White.merge(const TextStyle(letterSpacing: 1.4)),
          man15White,
          tenor22White,
          tenor10White
        ];
      case 'Amethyst':
        return [
          tenor22Gold.merge(const TextStyle(letterSpacing: 1.4)),
          man15Gold,
          tenor22Gold,
          tenor10Gold
        ];
    }
  }

  Widget settingTile(String title, String icon, GestureTapCallback onTap,
      BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 26.5,
            width: MediaQuery.of(context).size.width - 100,
            color: Colors.transparent,
          ),
          Row(
            children: [
              SvgPicture.asset(icon, color: HtpTheme.lightGreyColor),
              const SizedBox(
                width: 15,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 105,
                child: Text(
                  title,
                  style: man14LightBlue,
                ),
              ),
            ],
          ),
          Container(
            height: 26.5,
            width: MediaQuery.of(context).size.width - 100,
            color: Colors.transparent,
          ),
          NeedleDoubleSided()
        ],
      ),
    );
  }
}

Widget logoutDialog(context) {
  return Container(
    height: 194,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      color: HtpTheme.darkBlue2Color,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
    ),
    child: Consumer(
      builder: (context, ref, _) {
        return Column(
          children: [
            SizedBox(
              height: 26,
            ),
            Align(
                alignment: Alignment.center,
                child: Text(
                  "Are you sure?",
                  style: tenor22White,
                )),
            SizedBox(
              height: 62,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                      flex: 1,
                      child: FloatingBlackButton(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        text: "Stay Back",
                      )),
                  SizedBox(
                    width: 16,
                  ),
                  Flexible(
                    flex: 1,
                    child: RoundedGoldenButtonWithChild(
                      onTap: () {
                        Navigator.pop(context);
                        ref.read(authProvider.notifier).logOut();
                        ref.invalidate(profileControllerProvider);
                        mainNavigatorKey.currentState!
                            .popUntil((route) => route.isFirst);
                      },
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 48),
                          child: Text(
                            "Logout",
                            style: man16DarkBlue,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        );
      },
    ),
  );
}

class ProfilePicIcon extends ConsumerWidget {
  final GestureTapCallback onTap;
  final String img;
  const ProfilePicIcon({Key? key, required this.onTap, required this.img})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileController = ref.watch(profileControllerProvider);
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            // height: 145,
            // width: 145,
            decoration: BoxDecoration(
                border: Border.all(width: 3, color: HtpTheme.whiteColor),
                borderRadius: BorderRadius.circular(100)),
            child: CircleAvatar(
              radius: 37,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(70),
                  child: img !=
                          'assets/images/placeholders/profile_placeholder.png'
                      ? Image(
                          image: NetworkImage(
                            img,
                          ),
                          fit: BoxFit.cover,
                          height: 140,
                          width: 140,
                        )
                      : Image.asset(
                          "assets/images/placeholders/profile_placeholder.png")),
              backgroundImage:
                  const AssetImage('assets/images/profile-back.png'),
              // child: ClipRRect(
              //     borderRadius: BorderRadius.circular(70),
              //     child:Image.network(img,fit: BoxFit.cover,)),
            ),
          ),
          if (profileController is ProfileLoaded &&
              profileController.activeMembershipData == null)
            Padding(
              padding: const EdgeInsets.only(
                right: 5.0,
              ),
              child: GestureDetector(
                onTap: onTap,
                child: CircleAvatar(
                  radius: 12,
                  child: SvgPicture.asset(
                      "assets/svg/icons/profile/changeprofileimage.svg"),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
