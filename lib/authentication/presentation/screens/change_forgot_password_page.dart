import 'package:change_case/change_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/authentication/controllers/update_password_controller.dart';
import 'package:htp_customer/common/widgets_common/rounded_golden_button.dart';

import '../../../common/widgets_common/app_bar_back_button.dart';
import '../../../common/widgets_common/text_field_electra.dart';
import '../../../htp_theme.dart';

class ChangeForgotPasswordPage extends StatelessWidget {
  final String email;
  ChangeForgotPasswordPage({super.key, required this.email});

  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password', style: tenor22LightBlue,),
        leading: const AppbarBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFieldElectra(
                labelText: "New Password",
                obscureText: true,
                controller: _passwordController,
                // focus: _focusNewPswd,
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
                labelText: "Re-type New Password",
                controller: _confirmPasswordController,
                padding: const EdgeInsets.only(top: 12),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is mandatory';
                  }
                  if (value == _passwordController.text) {
                    return null;
                  }

                  return 'Password does not match';
                },
              ),

              const Spacer(),

              Consumer(builder: (context, ref, _){
                ref.listen(updatePasswordProvider, (previous, next) {
                  if(next is UPError){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(next.msg.toTitleCase())));
                  }
                  if(next is UPSuccess){
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Password updated successfully')));
                    Navigator.popUntil(context, (route) => route.isFirst);
                  }
                });
                final controller = ref.watch(updatePasswordProvider);
                if(controller is UPLoading){
                  return const CircularProgressIndicator(color: HtpTheme.goldenColor);
                }

                return RoundedGoldenButton(onTap: (){
                  if(_formKey.currentState!.validate()){
                    FocusManager.instance.primaryFocus?.unfocus();
                    ref.read(updatePasswordProvider.notifier).updatePassword(email, _passwordController.text);
                  }

                }, text: 'Change Password');

              }),


            ],
          ),
        ),
      ),
    );
  }
}
