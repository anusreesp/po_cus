// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:htp_customer/authentication/controllers/auth_controller.dart';
// import 'package:htp_customer/common/form_validator.dart';
// import 'package:htp_customer/common/widgets_common/app_bar_back_button.dart';
// import 'package:htp_customer/common/widgets_common/text_field_electra.dart';
// import 'package:htp_customer/features/clubs/presentation/widgets/new/floatingButtons.dart';
// import 'package:htp_customer/features/profile/controller/delete_account_controller.dart';
// import 'package:htp_customer/features/profile/controller/profile_controller.dart';
// import 'package:htp_customer/htp_theme.dart';
//
// class DeleteAccountScreen extends ConsumerWidget {
//   static String route = 'delete-acc';
//   DeleteAccountScreen({Key? key}) : super(key: key);
//
//   @override
//   final TextEditingController _passwordTextController = TextEditingController();
//   final _formDeleteAcc= GlobalKey<FormState>();
//   Widget build(BuildContext context, WidgetRef ref) {
//     final deleteAcc = ref.watch(deleteAccountProvider);
//     final profileData = ref.watch(profileControllerProvider);
//     ref.listen(deleteAccountProvider, (previous, next) {
//       if (next is DeleteSuccessState) {
//         ref.read(authProvider.notifier).logOut();
//         Navigator.popUntil(context, (route) => route.isFirst);
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text(next.successMsg),
//           duration: Duration(seconds: 5),
//         ));
//       } else if (next is DeleteAccountErrorState) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text(next.msg),
//           duration: Duration(seconds: 2),
//         ));
//       }
//     });
//     return Scaffold(
//       appBar: AppBar(
//           title: const Text("DELETE ACCOUNT", style: man14LightBlue),
//           leading: const AppbarBackButton()),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               "Delete your account",
//               style: tenor22LightBlue,
//             ),
//             Container(
//               padding: const EdgeInsets.symmetric(vertical: 16),
//               width: MediaQuery.of(context).size.width,
//               child: const Text(
//                 "When you delete your account, your personal data like photos, booking history, documents, membership plan is erased permanently from your profile.",
//                 style: man14LightBlue,
//                 textAlign: TextAlign.start,
//               ),
//             ),
//             const SizedBox(
//               height: 24,
//             ),
//             Form(
//               key: _formDeleteAcc,
//               child: TextFieldElectra(
//                 labelText: 'Enter your password',
//                 // padding: const EdgeInsets.only(bottom: 22,left: 12),
//                 obscureText: true,
//                 controller: _passwordTextController,
//                 // focus: _focusPassword,
//                 validator: MultiValidator([
//                   MinLengthValidator(6, errorText: 'Password too short'),
//                   RequiredValidator(errorText: "Password is empty")
//                 ]),
//               ),
//             ),
//             Expanded(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   // if(deleteAcc is DeleteAccountLoading)
//                   // Center(child: CircularProgressIndicator()),
//                   // if(deleteAcc is DeleteSuccessState || deleteAcc is DeleteAccountInitialState || deleteAcc is DeleteAccountErrorState)
//                   RoundedGreyButton(
//                     onTap: () {
//                       if (deleteAcc is DeleteAccountLoading) {
//                         const Center(child: CircularProgressIndicator());
//                       } else {
//                         if(_formDeleteAcc.currentState?.validate() ?? false )
//                         showModalBottomSheet(
//                             context: context,
//                             backgroundColor: Colors.transparent,
//                             builder: (context) {
//                               return deleteDialog(context, ref, () {
//                                 Navigator.pop(context);
//                                 ref
//                                     .read(deleteAccountProvider.notifier)
//                                     .deleteAccount(
//                                       _passwordTextController.text,
//                                     );
//                               });
//                             });
//                       }
//                     },
//                     text: "Delete Account",
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget deleteDialog(context, WidgetRef ref, GestureTapCallback onTap) {
//     return Container(
//       height: 194,
//       width: MediaQuery.of(context).size.width,
//       decoration: const BoxDecoration(
//         color: HtpTheme.darkBlue2Color,
//         borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(20), topRight: Radius.circular(20)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(
//             height: 26,
//           ),
//           Container(
//               margin: const EdgeInsets.only(left: 16),
//               width: 300,
//               child: const Text(
//                 "Are you sure you want to delete your account?",
//                 style: man16LightBlue,
//                 textAlign: TextAlign.left,
//               )),
//           const SizedBox(
//             height: 62,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Flexible(
//                     flex: 1,
//                     child: FloatingBlackButton(
//                       onTap: () {
//                         Navigator.pop(context);
//                       },
//                       text: "Cancel",
//                     )),
//                 const SizedBox(
//                   width: 16,
//                 ),
//                 Flexible(
//                   flex: 1,
//                   child: RoundedGoldenButtonWithChild(
//                     onTap: onTap,
//                     child: const Center(
//                       child: Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 48),
//                         child: Text(
//                           "Yes",
//                           style: man16DarkBlue,
//                         ),
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
//
// class RoundedGreyButton extends StatelessWidget {
//   final VoidCallback onTap;
//   final String text;
//   final TextStyle textStyle;
//   final double? height;
//   final EdgeInsetsGeometry childPadding;
//   const RoundedGreyButton(
//       {Key? key,
//       required this.onTap,
//       required this.text,
//       this.textStyle = const TextStyle(
//           fontFamily: manrope,
//           fontSize: 18,
//           fontWeight: FontWeight.w500,
//           color: Colors.black),
//       this.height,
//       this.childPadding = const EdgeInsets.all(12.0)})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         height: height ?? 50,
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(8),
//             color: HtpTheme.darkGrey3Color),
//         child: Padding(
//           padding: childPadding,
//           child: Center(
//               child: Text(
//             text,
//             style: man16DarkBlue,
//           )),
//         ),
//       ),
//     );
//   }
// }
//
// class RoundedGoldenButtonWithChild extends StatelessWidget {
//   final VoidCallback onTap;
//   final Widget child;
//   final double? height;
//   final bool isActive;
//   const RoundedGoldenButtonWithChild({
//     Key? key,
//     required this.onTap,
//     required this.child,
//     this.height,
//     this.isActive = true,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: isActive ? onTap : null,
//       child: Container(
//         height: height ?? 50,
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(12), color: HtpTheme.goldenColor
//             // gradient: LinearGradient(
//             //   colors: isActive
//             //       ? const <Color>[
//             //     Color.fromARGB(255, 247, 206, 115,),
//             //     Color.fromARGB(255, 219, 166, 17),
//             //   ]
//             //       : const <Color>[
//             //     Color.fromARGB(255, 105, 105, 105),
//             //     Color.fromARGB(255, 109, 109, 109),
//             //   ],
//             // )
//             // color: HtpTheme.goldenColor
//             ),
//         child: child,
//       ),
//     );
//   }
// }
