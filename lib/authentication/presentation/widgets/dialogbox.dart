import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/authentication/controllers/signup_controller.dart';
import 'package:htp_customer/authentication/theme.dart';
import 'package:htp_customer/common/widgets_common/rounded_golden_button.dart';

class DialogBox {
  static var colorTheme = AuthTheme.colorTheme();
  static forgetPasswordDialog() {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      elevation: 16,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: colorTheme.backgroundColor,
          // border: Border.all(color: Colors.yellow, width: 0.6)
        ),
        height: 200.0,
        width: 440.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(45.0),
              child: Text(
                textAlign: TextAlign.center,
                'OTP sent to registered mobile number',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: colorTheme.primaryColor,
                    fontSize: 17.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static signupDialog(BuildContext context, WidgetRef ref) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      elevation: 16,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          // color: colorTheme.backgroundColor,
          // border: Border.all(color: Colors.yellow, width: 0.6)
        ),
        height: 180.0,
        width: 480.0,
        // child: Padding(
        //   padding: const EdgeInsets.all(45.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              textAlign: TextAlign.center,
              'You must be of legal age to enter !',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: colorTheme.primaryColor,
                  fontSize: 13.0),
            ),
            const SizedBox(height: 8,),
            const Text(
              textAlign: TextAlign.center,
              'Are you 21 or over ?',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 24.0),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 16, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [


                  MaterialButton(
                    minWidth: 125,
                    height: 44,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    shape: RoundedRectangleBorder(
                        side:
                            const BorderSide(color: Colors.yellow, width: 0.6),
                        borderRadius: BorderRadius.circular(25)
                    ),
                    child: const Text(
                      "No",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),

                  const SizedBox(width: 12,),

                  SizedBox(
                    width: 125,
                    child: RoundedGoldenButton(
                        height: 44,
                        onTap: (){
                      ref.read(termsAndConditionProvider.notifier).state = true;
                      Navigator.of(context).pop();
                    }, text: 'Yes'),
                  ),

                  // MaterialButton(
                  //   onPressed: () {
                  //     ref.read(termsAndConditionProvider.notifier).state = true;
                  //     Navigator.of(context).pop();
                  //   },
                  //   child: Ink(
                  //     // width: double.maxFinite,
                  //     width: 125,
                  //     height: 45,
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(25),
                  //         gradient: const LinearGradient(
                  //           colors: <Color>[
                  //             Color.fromARGB(255, 250, 241, 160),
                  //             Colors.yellow
                  //           ],
                  //         )),
                  //     child: Container(
                  //       alignment: Alignment.center,
                  //       child: Text(
                  //         "Yes",
                  //         textAlign: TextAlign.center,
                  //         style: TextStyle(
                  //             color: colorTheme.backgroundColor, fontSize: 18),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            )
          ],
        ),
        // ),
      ),
    );
  }
}
