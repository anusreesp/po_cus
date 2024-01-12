import "package:flutter/material.dart";
import 'package:htp_customer/authentication/presentation/screens/login.dart';
import 'package:htp_customer/authentication/presentation/screens/numberverification.dart';
import 'package:htp_customer/authentication/presentation/screens/signup.dart';
import 'package:htp_customer/authentication/theme.dart';
import 'package:htp_customer/common/widgets_common/outlined_black_button.dart';
import 'package:htp_customer/htp_theme.dart';

class FooterWidget extends StatelessWidget {
  FooterWidget({super.key});

  final colorTheme = AuthTheme.colorTheme();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           const Text(
              "Already have an account?",
              style: man16LightBlue,
            ),

            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginPage()));
                },
                child: const Text(
                  "Sign In",
                  style: man16White,
                ))
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: OutlinedBlackButton(onTap: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NumberVerification()));
          }, text: 'SIGN UP',),
          // child: Center(
          //   child: MaterialButton(
          //     // color: Colors.transparent,
          //     minWidth: double.maxFinite,
          //     height: 50,
          //     shape: RoundedRectangleBorder(
          //         side: BorderSide(color: colorTheme.primaryColor),
          //         borderRadius: BorderRadius.circular(25)),
          //     child: Text(
          //       "SIGN UP",
          //       style: TextStyle(
          //         color: colorTheme.primaryColor,
          //         fontFamily: 'OpenSans',
          //         fontSize: 15,
          //       ),
          //     ),
          //     onPressed: () {
          //       Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //               builder: (context) => NumberVerification()));
          //     },
          //   ),
          // ),
        ),
      ],
    );
  }
}
