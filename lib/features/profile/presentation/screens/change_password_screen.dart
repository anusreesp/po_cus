// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:htp_customer/common/form_validator.dart';
// import 'package:htp_customer/common/widgets_common/app_bar_back_button.dart';
// import 'package:htp_customer/common/widgets_common/rounded_golden_button.dart';
// import 'package:htp_customer/common/widgets_common/text_field_electra.dart';
// import 'package:htp_customer/features/profile/controller/password_change_controller.dart';
// import 'package:htp_customer/htp_theme.dart';
//
// class ChangePasswordScreen extends ConsumerWidget {
//    ChangePasswordScreen({Key? key}) : super(key: key);
//
//   final _formKeyChangepswd = GlobalKey<FormState>();
//   final _focusOldPswd = FocusNode();
//   final _focusNewPswd = FocusNode();
//   final _focusConfirmPswd = FocusNode();
//   final TextEditingController _oldPswdTextController = TextEditingController();
//   final TextEditingController _newPswdController = TextEditingController();
//   @override
//   Widget build(BuildContext context,WidgetRef ref) {
//     final passwordChange = ref.watch(passwordChangeProvider);
//     return Scaffold(
//       appBar: AppBar(title: Text("CHANGE PASSWORD",style: man14LightBlue),
//         leading: AppbarBackButton()),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         child: Column(
//           children: [
//             Container(
//               padding: EdgeInsets.only(right: 24,top: 32),
//               width: MediaQuery.of(context).size.width,
//               child: Text("You’ll be logged out of all devices except this one to protect your account if anyone is trying to gain access.",style: man14LightBlue,textAlign: TextAlign.start,),
//             ),
//             SizedBox(
//               height: 42,
//             ),
//             TextFieldElectra(
//               labelText: 'Current password',
//               obscureText: true,
//               focus: _focusOldPswd,
//               validator: (String? val){
//                 if (val == null || val.isEmpty) {
//                   return 'This field is mandatory';
//                 }
//
//                 if (val.length < 6) {
//                   return 'Password too short';
//                 }
//
//                 if (val.trim().isEmpty) {
//                   return 'Enter a valid password';
//                 }
//
//                 return null;
//               },
//             ),
//             TextFieldElectra(
//               labelText: 'New password',
//               obscureText: true,
//               focus: _focusNewPswd,
//               validator: MultiValidator([
//                 RequiredValidator(errorText: "This field cannot be empty"),
//                 MinLengthValidator(6, errorText: "Too short")
//               ]),
//             ),
//             TextFieldElectra(
//               labelText: 'ReEnter New password',
//               obscureText: true,
//               focus: _focusConfirmPswd,
//             ),
//             Expanded(child: Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 RoundedGoldenButton(onTap: (){
//                   if (_formKeyChangepswd.currentState!.validate()) {
//                     ref
//                         .read(passwordChangeProvider.notifier)
//                         .changePassword(_oldPswdTextController.text,
//                         _newPswdController.text);
//                   }
//                 }, text: "Change Password"),
//                 SizedBox(height: 48,)
//               ],
//             ))
//           ],
//         ),
//       ),
//     );
//   }
// }
