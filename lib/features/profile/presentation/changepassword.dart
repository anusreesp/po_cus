import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:htp_customer/authentication/theme.dart';
import 'package:htp_customer/common/form_validator.dart';
import 'package:htp_customer/common/widgets_common/rounded_golden_button.dart';
import 'package:htp_customer/common/widgets_common/text_field_electra.dart';
import 'package:htp_customer/features/profile/controller/password_change_controller.dart';
import '../../../htp_theme.dart';
import '../../dashboard/presentation/widgets/custom_app_bar.dart';

class ChangePassword extends ConsumerWidget {
  static const route = '/change-password';
  ChangePassword({super.key});

  var colorTheme = AuthTheme.colorTheme();

  final _formKeyChangepswd = GlobalKey<FormState>();
  final _focusOldPswd = FocusNode();
  final _focusNewPswd = FocusNode();
  final _focusConfirmPswd = FocusNode();

  final _oldPswdTextController = TextEditingController();
  final _newPswdController = TextEditingController();
  final _confrmPswdController = TextEditingController();

  // var colorTheme = AuthTheme.colorTheme();

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

  // TextStyle styling = const TextStyle(
  //     // height: 0.4,
  //     fontFamily: 'OpenSans',
  //     fontSize: 14,
  //     color: Color.fromRGBO(255, 255, 255, 0.96));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(passwordChangeProvider);

    ref.listen(passwordChangeProvider, (previous, next) {
      if (next is PasswordChangeError) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(next.msg)));
      }

      if (next is PasswordChangeSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Password updated successfully')));
        if (context.mounted) {
          Navigator.of(context).pop();
        }
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text("CHANGE PASSWORD", style: man14LightBlue),
        leading: GestureDetector(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SvgPicture.asset(
              'assets/svg/icons/support/arrowleft.svg',
            ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        // height: MediaQuery.of(context).size.height - 140,
        // decoration: const BoxDecoration(
        //     image: DecorationImage(
        //         alignment: Alignment.bottomLeft,
        //         opacity: 0.3,
        //         image: AssetImage(
        //           "assets/images/mask_group.png",
        //         ))),
        child: Form(
          key: _formKeyChangepswd,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 29),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "You’ll be logged out of all devices except this one to protect your account if anyone is trying to gain access.",
                    style: man14LightBlue,
                  ),
                  SizedBox(
                    height: 52,
                  ),

                  TextFieldElectra(
                    obscureText: true,
                    labelText: "Type Current Password",
                    // TextStyle(color: colorTheme.primaryColor),
                    controller: _oldPswdTextController,
                    focus: _focusOldPswd,
                    padding: const EdgeInsets.all(0),
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'This field is mandatory'),
                      MinLengthValidator(6, errorText: 'Too short!')
                    ]),
                  ),

                  TextFieldElectra(
                    labelText: "Type New Password",
                    obscureText: true,
                    controller: _newPswdController,
                    focus: _focusNewPswd,
                    padding: const EdgeInsets.only(top: 12),
                    // validator: MultiValidator([RequiredValidator(errorText: 'Required field'), MinLengthValidator(6, errorText: 'Too short!')]),
                    validator: (String? val) {
                      if (val == null || val.isEmpty) {
                        return 'This field is mandatory';
                      }

                      if (val.length < 6) {
                        return 'Password too short';
                      }

                      if (val.trim().isEmpty) {
                        return 'Enter a valid password';
                      }

                      return null;
                    },
                  ),

                  TextFieldElectra(
                    obscureText: true,
                    labelText: "Re-type Password",
                    // keyboardType: TextInputType.number,
                    controller: _confrmPswdController,
                    padding: const EdgeInsets.only(top: 12),
                    focus: _focusConfirmPswd,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is mandatory';
                      }
                      if (value == _newPswdController.text) {
                        return null;
                      }

                      return 'Password does not match';
                    },
                  ),
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.height/8,
                  // ),
                  // const Spacer(),

                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: controller is PasswordChangeLoading
          ? const Center(
              child: const CircularProgressIndicator(color: HtpTheme.goldenColor),
            )
          : Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 22.0),
              child: RoundedGoldenButton(
                onTap: () {
                  if (_formKeyChangepswd.currentState!.validate()) {
                    ref.read(passwordChangeProvider.notifier).changePassword(
                        _oldPswdTextController.text, _newPswdController.text);
                  }
                },
                text: "Change Password",
              ),
            ),
    );
  }
}

// class ChangePswd extends ConsumerWidget {
//   ChangePswd({super.key});
//
//
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//
//
//     return ;
//   }
// }
