import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:htp_customer/authentication/controllers/password_reset_controller.dart';
import 'package:htp_customer/authentication/data/service/auth_service.dart';
import 'package:htp_customer/authentication/presentation/screens/change_forgot_password_page.dart';
import 'package:htp_customer/authentication/theme.dart';
import 'package:htp_customer/authentication/presentation/widgets/footer.dart';
import 'package:htp_customer/common/form_validator.dart';
import 'package:htp_customer/common/utils/images_path.dart';
import 'package:htp_customer/common/widgets_common/app_bar_back_button.dart';
import 'package:htp_customer/common/widgets_common/otp_verfication_common_page.dart';
import 'package:htp_customer/common/widgets_common/text_field_electra.dart';
import 'package:htp_customer/htp_theme.dart';
import 'package:htp_customer/common/widgets_common/rounded_golden_button.dart';

class ForgetPassword extends ConsumerWidget {
  const ForgetPassword({super.key});

  // var colorTheme = AuthTheme.colorTheme();

  // final _focusPhone = FocusNode();

  // startTimefun() async {
  //   var duration = const Duration(seconds: 6);
  //   return Timer(duration, navigateToPage);
  // }

  // navigateToPage() {
  //   Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => const PasswordOtp()
  //           // IntroScreen()
  //           ));
  // }

  // Widget diologBox() {
  //   return Dialog(
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
  //     elevation: 16,
  //     child: Container(
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(40),
  //         // color: HtpTheme.dark().scaffoldBackgroundColor
  //         // border: Border.all(color: Colors.yellow, width: 0.6)
  //       ),
  //       height: 200.0,
  //       width: 440.0,
  //       child: const Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           Padding(
  //             padding: EdgeInsets.all(45.0),
  //             child: Text(
  //               textAlign: TextAlign.center,
  //               'We have e-mailed your password reset link !',
  //               style: man16White,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKeyForget = GlobalKey<FormState>();
    final emailTextController = TextEditingController();
    final otpController = TextEditingController();
    
    return Scaffold(
      appBar: AppBar(
        leading: const AppbarBackButton(),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Form(
              key: formKeyForget,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    SvgPicture.asset(
                      logo,
                      height: 80,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Align(
                        alignment: Alignment.topLeft,
                        child:
                            Text("Forgot Password", style: tenor22LightBlue)),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFieldElectra(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailTextController,
                      hintText: 'Enter your email id',
                      validator: MultiValidator([
                        EmailValidator(
                            errorText: 'Enter a valid email address'),
                        RequiredValidator(
                            errorText: 'Enter a valid email address')
                      ]),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Center(
                        child: Consumer(
                          builder: (context, ref, _) {
                            final controller = ref.watch(passwordResetProvider);
                            ref.listen(passwordResetProvider, (previous, next) {

                              if (next is ResetErrorState) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(next.msg)));
                              }

                              if (next is ResetLinkSentState) {
                                // showDialog(
                                //     context: context,
                                //     builder: (context) {
                                //       // startTimefun();
                                //       return diologBox();
                                //     });
                                // Future.delayed(const Duration(seconds: 2))
                                //     .then((_) {
                                //   if (context.mounted) {
                                //     Navigator.of(context)
                                //         .popUntil((route) => route.isFirst);
                                //   }
                                // });
                                Navigator.push(context, MaterialPageRoute(builder: (context) => OtpVerificationCommonPage(
                                  otpController: otpController,
                                  onContinue: ()async{
                                    await ref.read(authServiceProvider).verifyEmailOtp(emailTextController.text, otpController.text);
                                  },
                                  onResend: ()async{
                                    await ref.read(authServiceProvider).sendEmailOtp(emailTextController.text);
                                  },
                                  onComplete: (){
                                    otpController.clear();
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (context) =>
                                            ChangeForgotPasswordPage(email: emailTextController.text)));
                                    // Navigator.push(context, MaterialPageRoute(builder: (context) => ChangeForgotPasswordPage()));
                                  },
                                ),
                                ));


                              }
                            });
                            if (controller is ResetLoading) {
                              return const Center(
                                child: const CircularProgressIndicator(color: HtpTheme.goldenColor),
                              );
                            }

                            return RoundedGoldenButton(
                              onTap: () {

                                if (formKeyForget.currentState?.validate() ??
                                    false) {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  // print('Validated');
                                  ref
                                      .read(passwordResetProvider.notifier)
                                      .sentEmailResetLink(
                                          emailTextController.text);



                                }
                              },
                              text: "Reset password",
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          const SizedBox(
            height: 160,
          ),
          FooterWidget(),

          //-----------------
          const SizedBox(
            height: 12,
          )
        ],
      )),
    );
  }

  // InputDecoration inputDecorations(String? hintText) {
  //   return InputDecoration(
  //     enabledBorder: UnderlineInputBorder(
  //       borderSide: BorderSide(
  //         width: 0.6,
  //         //  color: Colors.yellow
  //         color: colorTheme.primaryColor,
  //       ),
  //     ),
  //     focusedBorder: UnderlineInputBorder(
  //         borderSide: BorderSide(color: colorTheme.primaryColor)),
  //     focusedErrorBorder: const UnderlineInputBorder(
  //       borderSide: BorderSide(color: Colors.red),
  //     ),
  //     hintText: hintText,
  //
  //     hintStyle: const TextStyle(
  //       color: Color.fromARGB(255, 161, 161, 161),
  //     ),
  //     // hoverColor: const Color.fromARGB(255, 71, 71, 71),
  //   );
  // }
}
