import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:htp_customer/authentication/controllers/auth_controller.dart';
import 'package:htp_customer/authentication/data/service/auth_service.dart';
import 'package:htp_customer/authentication/data/service/firebase_auth_service.dart';
import 'package:htp_customer/authentication/presentation/widgets/social_button.dart';
import 'package:htp_customer/common/controllers/otpverification_common_controller.dart';
import 'package:htp_customer/common/widgets_common/app_bar_back_button.dart';
import 'package:htp_customer/common/widgets_common/needles_widget.dart';
import 'package:htp_customer/common/widgets_common/otp_verfication_common_page.dart';
import 'package:htp_customer/common/widgets_common/outlined_black_button.dart';
import 'package:htp_customer/common/widgets_common/rounded_golden_button.dart';
import 'package:htp_customer/features/clubs/presentation/widgets/new/floatingButtons.dart';
import 'package:htp_customer/features/dashboard/controllers/email_verification_controller.dart';
import 'package:htp_customer/features/profile/controller/delete_account_controller.dart';
import 'package:htp_customer/features/profile/controller/profile_controller.dart';
import 'package:htp_customer/features/profile/data/services/profile_services.dart';
import 'package:htp_customer/features/profile/presentation/changepassword.dart';
import 'package:htp_customer/features/profile/presentation/screens/change_email_screen.dart';
import 'package:htp_customer/features/profile/presentation/screens/change_mobile_screen.dart';
import 'package:htp_customer/features/profile/presentation/screens/email_link_screen.dart';
import 'package:htp_customer/features/profile/presentation/screens/otp_verification_screen.dart';
import 'package:htp_customer/htp_theme.dart';
import 'package:htp_customer/router.dart';
import 'delete_acc_screen.dart';
import 'package:htp_customer/features/profile/presentation/profile_page.dart';

class AccountSettingsPage extends ConsumerWidget {
  static String route = 'account-settings';
  const AccountSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<String> tileNames = [
      "Change Phone Number",
      "Change Email",
      "Change Password",
      "Delete Account"
    ];
    final profileController = ref.watch(profileControllerProvider);
    String? email;
    if (profileController is ProfileLoaded) {
      email = profileController.profileData.email;
    }
    final providerId = ref
        .read(firebaseAuthServiceProvider)
        .geCurrentUser()
        ?.providerData
        .first
        .providerId;
    return Scaffold(
        appBar: AppBar(
            title: const Text("ACCOUNT SETTINGS", style: man14LightBlue),
            leading: const AppbarBackButton()),
        body: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  settingTile(tileNames[0], () {
                    mainNavigatorKey.currentState!
                        .pushNamed(ChangeMobileScreen.route);
                  }, context),
                  // }),

                  // if(providerId == 'google.com')
                  //   settingTile('Unlink Google', () {
                  //     Navigator.push(context, MaterialPageRoute(builder: (context) => EmailLinkScreen(providerId: 'google.com')));
                  //   },context),
                  //
                  // if(providerId == 'apple.com')
                  //   settingTile('Unlink Apple', () {
                  //     Navigator.push(context, MaterialPageRoute(builder: (context) => EmailLinkScreen(providerId: 'apple.com')));
                  //   },context),

                  ///Change email
                  if (providerId == 'password')
                    settingTile(tileNames[1], () {
                      mainNavigatorKey.currentState!
                          .pushNamed(ChangeEmailScreen.route);
                    }, context),
                  if (ref
                          .read(firebaseAuthServiceProvider)
                          .geCurrentUser()
                          ?.providerData
                          .first
                          .providerId ==
                      'password')
                    settingTile(tileNames[2], () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChangePassword()));
                    }, context),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: settingTile(tileNames[3], () async {
                        // if (ref.read(firebaseAuthServiceProvider).geCurrentUser()?.providerData.first.providerId == 'password') {
                        //   Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) =>
                        //               DeleteAccountScreen()));
                        // } else {
                        showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (context) {
                              return deleteDialog(context, ref, () async {
                                final fire =
                                    ref.watch(firebaseAuthServiceProvider);
                                // if (profileController is ProfileLoaded) {
                                //   await ref.read(authServiceProvider).sendOtp(
                                //       profileController
                                //           .profileData.contacts.first.phone);
                                //   Navigator.pop(context);
                                //   mainNavigatorKey.currentState!.pushNamed(
                                //       OtpVerificationScreen.route,
                                //       arguments: {
                                //         "type": "delete",
                                //         "data": profileController
                                //             .profileData.contacts.first.phone
                                //       });
                                // }
                                await ref
                                    .read(profileServiceProvider)
                                    .deleteAccountEmailOtp(fire.uid);

                                final otpController = TextEditingController();
                                if (!context.mounted) return;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            OtpVerificationCommonPage(
                                              otpController: otpController,
                                              onContinue: () async {
                                                // await Future.delayed(
                                                //     const Duration(seconds: 2));

                                                final isVerified = await ref
                                                    .read(otpVerifyEmailProvider
                                                        .notifier)
                                                    .verifyEnterOtp(
                                                        otpController.text,
                                                        fire
                                                            .geCurrentUser()!
                                                            .email!);

                                                if (isVerified == true) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(const SnackBar(
                                                          content: Text(
                                                              "Your account deletion request is accepted..but still you have 7 days to think and to login again")));
                                                }
                                              },
                                              onComplete: () async {
                                                await ref
                                                    .read(deleteAccountProvider
                                                        .notifier)
                                                    .deleteAccount("");
                                                await ref
                                                    .read(authProvider.notifier)
                                                    .logOut();
                                                Navigator.popUntil(context,
                                                    (route) => route.isFirst);
                                              },
                                              onResend: () async {
                                                await ref
                                                    .read(
                                                        profileServiceProvider)
                                                    .sendEmailOtp(
                                                        fire.uid,
                                                        fire
                                                            .geCurrentUser()
                                                            ?.email);
                                              },
                                            )));
                              });
                            });
                        // }
                      }, context)),

                  if (providerId == 'google.com' || providerId == 'apple.com')
                    unlinkButton(providerId!, email ?? "", context),
                ],
              ),

              // child: ListView.builder(
              //     itemCount: 4,
              //     itemBuilder: (context,index){
              //   return GestureDetector(
              //   onTap: (){
              //     if(index == 0){
              //       mainNavigatorKey.currentState!.pushNamed(ChangeMobileScreen.route);
              //     }else if(index==1){
              //       mainNavigatorKey.currentState!.pushNamed(ChangeEmailScreen.route);
              //     }else if(index == 2){
              //       print("------->${ref.read(firebaseAuthServiceProvider).geCurrentUser()?.providerData.first.providerId}");
              //       Navigator.push(context, MaterialPageRoute(builder: (context)=> ChangePassword()));
              //     }else{
              //       Navigator.push(context, MaterialPageRoute(builder: (context)=> DeleteAccountScreen()));
              //     }
              //   }
              //   ,child: settingTile(tileNames[index], ref.read(firebaseAuthServiceProvider).geCurrentUser()?.providerData.first.providerId));
              // }),
            ),
          ],
        ));
  }

  // Widget settingTile(String title, String icon, GestureTapCallback onTap,
  //     BuildContext context) {
  //   return GestureDetector(
  //     onTap: onTap,
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Container(
  //           height: 26.5,
  //           width: MediaQuery.of(context).size.width - 100,
  //           color: Colors.transparent,
  //         ),
  //         Row(
  //           children: [
  //             SvgPicture.asset(icon),
  //             const SizedBox(
  //               width: 15,
  //             ),
  //             SizedBox(
  //               width: MediaQuery.of(context).size.width - 105,
  //               child: Text(
  //                 title,
  //                 style: man14LightBlue,
  //               ),
  //             ),
  //           ],
  //         ),
  //         Container(
  //           height: 26.5,
  //           width: MediaQuery.of(context).size.width - 100,
  //           color: Colors.transparent,
  //         ),
  //         NeedleDoubleSided()
  //       ],
  //     ),
  //   );
  // }
  Widget deleteDialog(context, WidgetRef ref, GestureTapCallback onTap) {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: HtpTheme.darkBlue2Color,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 26,
          ),
          Container(
              margin: EdgeInsets.only(left: 16),
              width: 300,
              child: Text(
                "Are you sure you want to delete your account?",
                style: man16LightBlue,
                textAlign: TextAlign.left,
              )),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.067,
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
                      text: "Cancel",
                    )),
                SizedBox(
                  width: 16,
                ),
                Flexible(
                  flex: 1,
                  child: RoundedGoldenButton(
                    onTap: onTap,
                    text: "Yes",
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
  //
  // Widget settingsTile(String title, String icon, GestureTapCallback onTap,
  //     BuildContext context) {
  //   return GestureDetector(
  //     onTap: onTap,
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Container(
  //           height: 26.5,
  //           width: MediaQuery.of(context).size.width - 100,
  //           color: Colors.transparent,
  //         ),
  //         Row(
  //           children: [
  //             SvgPicture.asset(icon),
  //             const SizedBox(
  //               width: 15,
  //             ),
  //             SizedBox(
  //               width: MediaQuery.of(context).size.width - 105,
  //               child: Text(
  //                 title,
  //                 style: man14LightBlue,
  //               ),
  //             ),
  //           ],
  //         ),
  //         Container(
  //           height: 26.5,
  //           width: MediaQuery.of(context).size.width - 100,
  //           color: Colors.transparent,
  //         ),
  //         NeedleDoubleSided()
  //       ],
  //     ),
  //   );
  // }

  Widget settingTile(
      String title, GestureTapCallback onTap, BuildContext context,
      {bool showNeedle = true}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.transparent,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                title,
                style: man14LightBlue,
              ),
            ),
          ),
          if (showNeedle) const NeedleDoubleSided(),
        ],
      ),
    );
  }

  Widget unlinkButton(String provider, String email, BuildContext context) {
    bool googleUnlink = provider == 'google.com';
    return Container(
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.fromLTRB(16, 28, 16, 0),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          Row(
            children: [
              SocialButton(
                  onTap: () {},
                  iconPath: googleUnlink
                      ? 'assets/svg/icons/social/google.svg'
                      : 'assets/svg/icons/social/apple.svg'),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      googleUnlink ? 'Google' : 'Apple',
                      style: man14White,
                    ),
                    Text(
                      'You are connected with ${googleUnlink ? 'Google' : 'Apple'}. Unlink?',
                      style: man14LightBlue,
                    ),
                    Text(
                      email,
                      style: man14White,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          OutlinedBlackButton(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          EmailLinkScreen(providerId: provider)));
            },
            text: 'Unlink Account',
          )
        ],
      ),
    );
  }
}
