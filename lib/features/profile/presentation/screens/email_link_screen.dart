import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/authentication/data/service/firebase_auth_service.dart';
import 'package:htp_customer/common/widgets_common/app_bar_back_button.dart';
import 'package:htp_customer/common/widgets_common/outlined_black_button.dart';
import 'package:htp_customer/common/widgets_common/rounded_golden_button.dart';
import 'package:htp_customer/common/widgets_common/text_field_electra.dart';
import 'package:htp_customer/features/dashboard/controllers/email_verification_controller.dart';
import 'package:htp_customer/features/profile/controller/profile_controller.dart';

import '../../../../common/form_validator.dart';
import '../../../../htp_theme.dart';
import '../../controller/email_link_controller.dart';

class EmailLinkScreen extends ConsumerWidget {
  final String providerId;
  EmailLinkScreen({super.key, required this.providerId});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(emailLinkProvider, (previous, next) {
      if (next is EmailLinkError) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(next.msg)));
      }
      if (next is EmailLinkSuccess) {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        ref.read(firebaseAuthServiceProvider).reloadUser();
        ref.read(profileControllerProvider.notifier).getProfile();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Your email and password is updated!')));
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'UNLINK ACCOUNT',
          style: man14LightBlue,
        ),
        leading: const AppbarBackButton(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                TextFieldElectra(
                  labelText: 'Email address*',
                  hintText: 'Email address',
                  controller: _emailController,
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'Email required'),
                    EmailValidator(errorText: 'Enter a valid email address')
                  ]),
                ),
                TextFieldElectra(
                  labelText: 'New Password*',
                  hintText: 'password',
                  obscureText: true,
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'Password required'),
                    MinLengthValidator(6, errorText: 'Password too short')
                  ]),
                  controller: _passwordController,
                ),
                Text(
                  "Once ${providerId == 'apple.com' ? 'Apple' : 'Google'} account is unlinked from the profile, logging in via ${providerId == 'apple.com' ? 'Apple' : 'Google'} won't be available.",
                  style: man14LightBlue,
                ),
                const SizedBox(
                  height: 16,
                ),
                Consumer(builder: (context, ref, _) {
                  final controller = ref.watch(emailLinkProvider);
                  if (controller is EmailLinkLoading) {
                    return const Center(
                      child: const CircularProgressIndicator(
                          color: HtpTheme.goldenColor),
                    );
                  }

                  return OutlinedBlackButton(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        FocusManager.instance.primaryFocus?.unfocus();
                        ref
                            .read(emailLinkProvider.notifier)
                            .linkEmail(_emailController.text,
                                _passwordController.text, providerId)
                            .then((value)  {
                              ref.invalidate(emailLinkProvider);
                              ref.read(emailVerificationProvider.notifier).isEmailVerify();


                            });
                      }
                    },
                    // text: 'Unlink ${providerId == 'apple.com' ? 'Apple' : 'Google'}'
                    text: 'Unlink Account',
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
