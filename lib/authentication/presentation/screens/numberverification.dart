import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/authentication/controllers/auth_controller.dart';
import 'package:htp_customer/authentication/data/service/firebase_auth_service.dart';
import 'package:htp_customer/common/widgets_common/app_bar_back_button.dart';
import 'package:htp_customer/htp_theme.dart';

import '../../controllers/country_code_controller.dart';
import '../../controllers/mobile_verification_controller.dart';
import '../widgets/signup_mobile_field.dart';
import '../widgets/signup_otp_field.dart';
import '../widgets/social_button.dart';

import 'new/signup.dart';

class NumberVerification extends ConsumerWidget {
  final bool isSocialReg;
  final String? name;
  final String? email;
  NumberVerification(
      {super.key, this.isSocialReg = false, this.name, this.email});

  // final OtpFieldController otpController = OtpFieldController();

  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final showOtpField = ref.watch(showOtpFieldProvider);
    // ref.listen(mobileVerificationProvider, (previous, next) {
    //   if (next is MobileVerificationSuccess) {

    //     Navigator.pushReplacement(
    //         context,
    //         MaterialPageRoute(
    //             builder: (context) => SignUpPage(
    //                 mobile: next.mobile,
    //                 isSocialReg: isSocialReg,
    //                 name: name,
    //                 email: email,
    //                 isWhatsAppNumber: ref
    //                     .read(mobileVerificationProvider.notifier)
    //                     .isWhatsAppNumber)));
    //   }

    //   if (next is MobileVerificationError) {
    //     ScaffoldMessenger.of(context)
    //         .showSnackBar(SnackBar(content: Text(next.msg)));
    //   }
    // });
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Enter your phone number',
            style: tenor22LightBlue,
          ),
          leading: AppbarBackButton(onTap: () {
            final user = ref.read(firebaseAuthServiceProvider).geCurrentUser();
            if (isSocialReg == true || user == null) {
              if (user == null) {
                Navigator.pop(context);
                return;
              } else {
                ref.read(authProvider.notifier).logOut().then((_) {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  return;
                });
              }
              // Navigator.pushReplacement(context,
              //     MaterialPageRoute(builder: (context) => LoginPage()));
            } else {
              Navigator.pop(context);
            }
          })),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                  child: MobileField(
                    textController: _phoneController,
                    isSocialReg: isSocialReg,
                    name: name,
                    email: email,

                  ),
                ),
              ),

              const SizedBox(
                height: 22,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SocialButton(onTap: (){
                  //   final user = ref.read(firebaseAuthServiceProvider).geCurrentUser();
                  //   if(user == null){
                  //     Navigator.maybePop(context);
                  //     ref.read(authProvider.notifier).fbLogin();
                  //   }else{
                  //     ref.read(authProvider.notifier).logOut();
                  //     ref.read(authProvider.notifier).fbLogin();
                  //   }
                  // }, iconPath: 'assets/svg/icons/social/fb.svg'),
                  //
                  // const SizedBox(width: 16,),

                  SocialButton(
                      onTap: () {
                        final user = ref
                            .read(firebaseAuthServiceProvider)
                            .geCurrentUser();
                        if (user == null) {
                          Navigator.maybePop(context);
                          ref.read(authProvider.notifier).googleLogin();
                        } else {
                          ref.read(authProvider.notifier).logOut();
                          ref.read(authProvider.notifier).googleLogin();
                        }
                      },
                      iconPath: 'assets/svg/icons/social/google.svg'),
                  const SizedBox(
                    width: 16,
                  ),

                  if (Platform.isIOS)
                    SocialButton(
                        onTap: () {
                          final user = ref
                              .read(firebaseAuthServiceProvider)
                              .geCurrentUser();
                          if (user == null) {
                            Navigator.maybePop(context);
                            ref.read(authProvider.notifier).appleLogin();
                          } else {
                            ref.read(authProvider.notifier).logOut();
                            ref.read(authProvider.notifier).appleLogin();
                          }
                        },
                        iconPath: 'assets/svg/icons/social/apple.svg'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account? ",
                    style: man14LightBlue,
                  ),
                  TextButton(
                      onPressed: () {
                        final user = ref
                            .read(firebaseAuthServiceProvider)
                            .geCurrentUser();
                        if (user == null) {
                          Navigator.maybePop(context);
                        } else {
                          ref.read(authProvider.notifier).logOut();
                        }
                      },
                      child: const Text(
                        "Sign In",
                        style: man14Gold,
                      ))
                ],
              ),
              const SizedBox(
                height: 22,
              )

              //---------------------------------
            ],
          ),
        ),
      ),
    );
  }
}
