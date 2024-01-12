import 'dart:io';

import 'package:flutter/gestures.dart';
import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:htp_customer/authentication/controllers/auth_controller.dart';
import 'package:htp_customer/authentication/presentation/screens/forgetpassword.dart';
import 'package:htp_customer/common/form_validator.dart';
import 'package:htp_customer/common/utils/images_path.dart';
import 'package:htp_customer/common/widgets_common/needles_widget.dart';
import 'package:htp_customer/common/widgets_common/outlined_black_button.dart';
import 'package:htp_customer/common/widgets_common/text_field_electra.dart';
import 'package:htp_customer/htp_theme.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;
import '../../../common/utils/common_links.dart';
import '../../../common/widgets_common/rounded_golden_button.dart';
import '../widgets/social_button.dart';

import 'numberverification.dart';

class LoginPage extends ConsumerWidget {
  static const route = '/login-page';
  LoginPage({super.key});

  // final colorTheme = AuthTheme.colorTheme();

  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  final _formKeyLogin = GlobalKey<FormState>();

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  // final bool _isPasswordVisible = false;
  // final bool _agreeTandC = false;

  // InputDecoration inputDecorations(String? hintText) {
  //   return InputDecoration(
  //     enabledBorder: const UnderlineInputBorder(
  //       borderSide: BorderSide(width: 0.3, color: Colors.yellow
  //           // color: colorTheme.primaryColor,
  //           ),
  //     ),
  //     focusedBorder: UnderlineInputBorder(
  //         borderSide: BorderSide(color: colorTheme.primaryColor)),
  //     focusedErrorBorder: const UnderlineInputBorder(
  //       borderSide: BorderSide(color: Colors.red),
  //     ),
  //     hintText: hintText,
  //     hintStyle: const TextStyle(
  //       fontSize: 12,
  //       color: Color.fromARGB(255, 161, 161, 161),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(authProvider, (previous, next) {
      if (next is AuthErrorState) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(next.msg)));
      }
    });
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
              // height: MediaQuery.of(context).size.height,
              // decoration: const BoxDecoration(
              //     image: DecorationImage(
              //       opacity: 0.3,
              //         alignment: Alignment.bottomLeft,
              //         image: AssetImage(
              //           "assets/images/mask_group.png",
              //         ))),
              // padding: const EdgeInsets.only(left: 24.0, right: 24.0),
              child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Column(
              children: [
                Form(
                  key: _formKeyLogin,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      // Align(
                      //   alignment: Alignment.centerLeft,
                      // Image.asset(
                      //   "assets/images/logos/party_onebottom.png",
                      //   scale: 6.0,
                      // ),
                      ///Brand logo
                      SvgPicture.asset(
                        logo,
                        height: 80,
                      ),
                      // ),
                      const SizedBox(
                        height: 40,
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        alignment: Alignment.topLeft,
                        child: const Text(
                          "Login",
                          style: tenor22LightBlue,
                        ),
                      ),

                      //-----------------------------------email
                      TextFieldElectra(
                        padding: const EdgeInsets.only(bottom: 8),
                        hintText: 'Email address',
                        controller: _emailTextController,
                        focus: _focusEmail,
                        autovalidateMode: AutovalidateMode.disabled,
                        validator: MultiValidator([
                          RequiredValidator(
                              errorText: 'Enter an email address'),
                          EmailValidator(errorText: 'Enter valid email')
                        ]),
                      ),
                      //----------------------------------------password
                      TextFieldElectra(
                        padding: const EdgeInsets.only(bottom: 0),
                        hintText: 'Password',
                        obscureText: true,
                        autovalidateMode: AutovalidateMode.disabled,
                        controller: _passwordTextController,
                        focus: _focusPassword,
                        validator: MultiValidator([
                          RequiredValidator(errorText: 'Password required'),
                          MinLengthValidator(6, errorText: 'Password too short')
                        ]),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              style: TextButton.styleFrom(
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  padding: EdgeInsets.zero,
                                  minimumSize: Size.zero),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ForgetPassword()
                                        // IntroScreen()
                                        ));
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                  color: HtpTheme.goldColor,
                                  width: 1.0, // Underline thickness
                                ))),
                                child: Text("Trouble logging in ?",
                                    style: tenor12Gold),
                              ))
                        ],
                      ),
                      //------------------

                      const SizedBox(
                        height: 22,
                      ),
                      //------------------------------Login Button-------------------------------
                      Container(
                        height: 80,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 12),
                        child: Center(child: Consumer(
                          builder: (context, ref, _) {
                            final controller = ref.watch(authProvider);
                            if (controller is AuthLoadingState) {
                              return const CircularProgressIndicator(color: HtpTheme.goldenColor);
                            } else {
                              return RoundedGoldenButton(
                                height: 50,
                                onTap: () async {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  if (_formKeyLogin.currentState!.validate()) {
                                    ref.read(authProvider.notifier).emailLogin(
                                        _emailTextController.text,
                                        _passwordTextController.text,context);
                                  }
                                },
                                text: 'Login',
                                // textStyle: const TextStyle(
                                //     fontWeight: FontWeight.w700,
                                // fontSize: 18,
                                // color: colorTheme.backgroundColor
                                // ),
                              );
                            }
                          },
                        )),
                      ),

                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Expanded(
                              child: NeedleHorizontal(
                            flip: true,
                            thickness: 1.5,
                          )),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 4.0, right: 4, bottom: 2),
                            child: Text(
                              'or',
                              style: man12LightGrey,
                            ),
                          ),
                          const Expanded(
                              child: NeedleHorizontal(
                            thickness: 1.5,
                          )),
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 28.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // SocialButton(onTap: (){
                            //   ref.read(authProvider.notifier).fbLogin();
                            // }, iconPath: 'assets/svg/icons/social/fb.svg'),
                            // const SizedBox(width: 16,),

                            SocialButton(
                                onTap: () {
                                  ref.read(authProvider.notifier).googleLogin();
                                },
                                iconPath: 'assets/svg/icons/social/google.svg'),

                            if (Platform.isIOS)
                              const SizedBox(
                                width: 16,
                              ),

                            if (Platform.isIOS)
                              SocialButton(
                                  onTap: () {
                                    ref
                                        .read(authProvider.notifier)
                                        .appleLogin();
                                  },
                                  iconPath:
                                      'assets/svg/icons/social/apple.svg'),
                          ],
                        ),
                      ),

                      OutlinedBlackButton(
                          text: 'Sign Up',
                          textStyle: const TextStyle(
                              fontFamily: manrope, fontSize: 18),
                          onTap: () {
                            //TODO: Remove before build
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => SignUpPage(
                            //               mobile: '+9199999112422',
                            //               isSocialReg: false,
                            //             )));

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        NumberVerification()));

                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => SignUpPage(
                            //               mobile: '+919496795400',
                            //               isSocialReg: false,
                            //             )));
                          }),

                      // Center(
                      //   child: MaterialButton(
                      //     color: Colors.black12,
                      //     minWidth: double.maxFinite,
                      //     height: 50,
                      //     shape: RoundedRectangleBorder(
                      //         side: const BorderSide(color: HtpTheme.goldColor),
                      //         borderRadius: BorderRadius.circular(8)),
                      //     child: const Text(
                      //       "Sign Up",
                      //       style: TextStyle(
                      //           fontFamily: manrope,
                      //           fontSize: 18,
                      //           fontWeight: FontWeight.w500),
                      //     ),
                      //     onPressed: () {
                      //       // Navigator.push(
                      //       //     context,
                      //       //     MaterialPageRoute(
                      //       //         builder: (context) =>
                      //       //             NumberVerification()));
                      //
                      //       Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //               builder: (context) => SignUpPage(
                      //                     mobile: '9496795400',
                      //                     isSocialReg: false,
                      //                   )));
                      //       //TODO: Remove before build
                      //       // Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage(mobile: '+9199999112422', isSocialReg: false,)));
                      //       // Navigator.push(1
                      //       //     context,
                      //       //     MaterialPageRoute(
                      //       //         builder: (context) =>
                      //       //             SignupPage()));
                      //     },
                      //   ),
                      // ),

                      const SizedBox(
                        height: 18,
                      ),

                      RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              style: man10LightBlue,
                              text: 'By continuing, you agree to our ',
                              children: [
                                TextSpan(
                                    text: 'Terms & Conditions ',
                                    style: const TextStyle(
                                        decoration: TextDecoration.underline,
                                        decorationThickness: 3),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        urlLauncher.launchUrl(
                                            Uri.parse(
                                              "${supportLink}terms-and-conditions/",
                                            ),
                                            mode: LaunchMode
                                                .externalNonBrowserApplication);
                                      }),
                                const TextSpan(text: 'and '),
                                TextSpan(
                                    text: 'Privacy Policy ',
                                    style: const TextStyle(
                                        decoration: TextDecoration.underline,
                                        decorationThickness: 3),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        urlLauncher.launchUrl(
                                            Uri.parse(
                                              "${supportLink}privacy/",
                                            ),
                                            mode: LaunchMode
                                                .externalNonBrowserApplication);
                                      }),
                                const TextSpan(
                                    text:
                                        'and to subscribe to emails for offers, alerts and services.')
                              ]))
                    ],
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
