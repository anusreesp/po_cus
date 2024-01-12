// import 'package:camera/camera.dart';
// import 'package:change_case/change_case.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:htp_customer/authentication/data/service/firebase_auth_service.dart';
// import 'package:htp_customer/common/form_validator.dart';
// import 'package:htp_customer/common/widgets_common/goldborder_button.dart';
// import 'package:htp_customer/common/widgets_common/rounded_golden_button.dart';
// import 'package:htp_customer/features/idverification/presentation/pages/selfie/selfie_capture.dart';
// import 'package:htp_customer/features/profile/controller/email_update.dart';
// import 'package:htp_customer/features/profile/controller/profile_controller.dart';
// import 'package:htp_customer/features/profile/presentation/changepassword.dart';
// import 'package:htp_customer/features/profile/presentation/favouriteclub.dart';
// import 'package:htp_customer/features/profile/presentation/booking/new/newbooking.dart';
// import 'package:htp_customer/features/profile/presentation/profileupdate.dart';
// import 'package:htp_customer/freshchat/controllers/freshchat_controller.dart';
// import 'package:htp_customer/htp_theme.dart';
// import '../../../authentication/controllers/auth_controller.dart';
// import '../../dashboard/presentation/widgets/custom_app_bar.dart';
// import '../controller/delete_account_controller.dart';
// import 'screens/account_settings.dart';

// class ProfilePage extends ConsumerWidget {
//   static const route = '/profile';
//   ProfilePage({super.key});

//   List icons = [
//     "assets/svg/icons/event_calendar_icon.svg",
//     "assets/svg/icons/heart/goldheart.svg",
//     "assets/svg/icons/bottle_icon.svg",
//     "assets/svg/icons/changepassword-lock.svg"
//   ];
//   List details = [
//     "My Bookings",
//     "My Favourite Clubs",
//     "Support",
//     "Change Password"
//   ];

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//         // extendBodyBehindAppBar: true,
//         // extendBody: true,
//         appBar: CustomAppBar(),
//         body: SingleChildScrollView(
//           child: Container(
//               // decoration: const BoxDecoration(
//               //     image: DecorationImage(
//               //         alignment: Alignment.bottomLeft,
//               //         image: AssetImage(
//               //           "assets/images/icons/mask_group.png",
//               //         ))
//               // ),

//               child: Consumer(
//             builder: (context, ref, child) {
//               final profileController = ref.watch(profileControllerProvider);
//               // ref.read(profileServiceProvider).getBookings();
//               return Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                 child: Column(children: [
//                   // const SizedBox(
//                   //   height: 104,
//                   // ),
//                   Row(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(left: 8.0),
//                         child: Text(
//                           "Profile",
//                           style: HtpTheme.newTitleTextStyle,
//                         ),
//                       ),
//                       const Spacer(),
//                       GestureDetector(
//                         onTap: (() {
//                           Navigator.pushNamed(context, UpdateProfilePage.route);
//                         }),
//                         child: Row(
//                           children: [
//                             // Image(
//                             //   image: AssetImage("assets/images/icons/edit.png"),
//                             //   height: 18,
//                             // ),

//                             SvgPicture.asset(
//                                 "assets/svg/icons/update-profile-icon.svg"),
//                             // Image.network(""),
//                             const Padding(
//                               padding: EdgeInsets.all(8.0),
//                               child: Text(
//                                 "Update Profile",
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 8,
//                   ),
//                   Container(
//                     width: 340,
//                     // height: 250,
//                     alignment: Alignment.topCenter,
//                     child: Stack(
//                       // crossAxisAlignment: CrossAxisAlignment.start,
//                       alignment: Alignment.bottomCenter,
//                       children: [
//                         if (profileController is ProfileLoaded)
//                           Padding(
//                             padding: const EdgeInsets.only(bottom: 38.0),
//                             child: ClipRRect(
//                               // borderRadius: BorderRadius.circular(4),
//                               // child: Image(
//                               //     height: 200,
//                               //     width: MediaQuery.of(context).size.width,
//                               //     image: const AssetImage(
//                               //         "assets/images/temp/membership/solitare1.png")),
//                               child:
//                                   profileController.activeMembershipData != null
//                                       ? Image.network(
//                                           profileController
//                                               .activeMembershipData!.flatImage,
//                                           height: 200,
//                                         )
//                                       : const SizedBox.shrink(),
//                             ),
//                           ),
//                         if (profileController is ProfileLoaded)
//                           Padding(
//                             padding:
//                                 const EdgeInsets.only(bottom: 8.0, right: 10),
//                             child: CircleAvatar(
//                               // radius: 48,
//                               radius: 20,
//                               backgroundImage: const AssetImage(
//                                   'assets/images/profile-back.png'),
//                               child: ClipRRect(
//                                   // borderRadius: BorderRadius.circular(53),
//                                   borderRadius: BorderRadius.circular(23),
//                                   child: profileController
//                                               .profileData.profileImage ==
//                                           null
//                                       ? const Image(
//                                           image: AssetImage(
//                                               'assets/images/placeholders/profile_placeholder.png'),
//                                           // height: 85,
//                                           // width: 85,
//                                         )
//                                       : Image(
//                                           image: NetworkImage(profileController
//                                               .profileData.profileImage!),
//                                           // AssetImage(
//                                           //     'assets/images/temp/profile.png'),
//                                           height: 25,
//                                           width: 25,
//                                           fit: BoxFit.cover,
//                                         )),
//                             ),
//                           ),
//                         if (profileController is ProfileLoading)
//                           Padding(
//                             padding:
//                                 const EdgeInsets.only(bottom: 8.0, right: 10),
//                             child: CircleAvatar(
//                               // radius: 48,
//                               radius: 20,
//                               backgroundImage: const AssetImage(
//                                   'assets/images/profile-back.png'),
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(23),
//                                 // child: const CircularProgressIndicator(),
//                               ),
//                             ),
//                           ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 33.0),
//                           child: GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => SelfieCapture(
//                                             onCapture: (XFile file) async {
//                                               debugPrint("Executed");
//                                               debugPrint(
//                                                   "PROFILE IMAGE: ${file.path}");

//                                               // showDialog(
//                                               //     barrierDismissible: false,
//                                               //     context: context, builder: (context) => const Center(child: CircularProgressIndicator(),));
//                                               Navigator.pop(context);
//                                               await ref
//                                                   .read(
//                                                       profileControllerProvider
//                                                           .notifier)
//                                                   .updateProfileImage(file);
//                                             },
//                                           )));
//                             },
//                             child: CircleAvatar(
//                               radius: 15,
//                               child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(50),
//                                   child: const Image(
//                                     image: AssetImage(
//                                         'assets/images/icons/profile-plus.png'),
//                                     height: 50,
//                                     width: 50,
//                                     fit: BoxFit.cover,
//                                   )),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   if (profileController is ProfileLoaded)
//                     Container(
//                       height: 50,
//                       width: 200,
//                       padding: const EdgeInsets.only(top: 4),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Text(
//                             "${profileController.profileData.name}"
//                                 .toTitleCase(),
//                             textAlign: TextAlign.center,
//                             // "Dua Lipa",
//                             style: const TextStyle(
//                               // fontFamily: "OpenSans",
//                               color: Colors.white,
//                               fontWeight: FontWeight.w500,
//                               fontSize: 17,
//                             ),
//                           ),
//                           Text(
//                               "${profileController.profileData.activeMembershipName} member",
//                               textAlign: TextAlign.center,
//                               // "Solitaire Member",
//                               style: const TextStyle(
//                                 color: Color.fromRGBO(245, 245, 245, 0.71),
//                                 fontSize: 12,
//                                 // fontFamily: "OpenSans",
//                               ))
//                         ],
//                       ),
//                     ),
//                   if (profileController is ProfileLoading)
//                     const CircularProgressIndicator(),

//                   const SizedBox(
//                     height: 16,
//                   ),
//                   SizedBox(
//                     // height: 180,
//                     width: 330,
//                     child: Column(
//                       children: [
//                         //---------------------------------My Bookings-------------------------------------
//                         ProfileWidgets(
//                           icon: icons[0],
//                           details: details[0],
//                           onTap: () {
//                             Navigator.pushNamed(context, NewBooking.route);
//                           },
//                         ),
//                         Row(
//                           children: [
//                             const SizedBox(
//                               width: 28,
//                             ),
//                             line()
//                           ],
//                         ),
//                         // const Divider(
//                         //   color: Color.fromARGB(255, 107, 107, 107),
//                         // ),
//                         //---------------------------------My Favourite Clubs-------------------------------------
//                         ProfileWidgets(
//                             icon: icons[1],
//                             details: details[1],
//                             onTap: () {
//                               Navigator.pushNamed(context, FavouriteClub.route);
//                             }),
//                         Row(
//                           children: [
//                             const SizedBox(
//                               width: 28,
//                             ),
//                             line()
//                           ],
//                         ),

//                         ProfileWidgets(
//                             icon: icons[2],
//                             details: details[2],
//                             onTap: () {
//                               ref.read(freshChatProvider).startChat();
//                             }),

//                         Row(
//                           children: [
//                             const SizedBox(
//                               width: 28,
//                             ),
//                             line()
//                           ],
//                         ),

//                         if (ref
//                                 .read(firebaseAuthServiceProvider)
//                                 .geCurrentUser()
//                                 ?.providerData
//                                 .first
//                                 .providerId ==
//                             'password')
//                           ProfileWidgets(
//                               icon: icons[3],
//                               details: details[3],
//                               onTap: () {
//                                 Navigator.pushNamed(
//                                     context, ChangePassword.route);
//                               }),

//                         // Row(
//                         //   children: [
//                         //     const SizedBox(
//                         //       width: 28,
//                         //     ),
//                         //     line()
//                         //   ],
//                         // ),
//                         //
//                         //   ProfileWidgets(
//                         //       icon: icons[3],
//                         //       details: 'Update Email',
//                         //       onTap: () {
//                         //         showDialog(context: context, builder: (context){
//                         //           return _EmailUpdateDialog();
//                         //         });
//                         //       }),
//                       ],
//                     ),
//                   ),

//                   Center(
//                     child: Padding(
//                       padding: const EdgeInsets.only(bottom: 120.0),
//                       child: Column(
//                         children: [
//                           MaterialButton(
//                             onPressed: () async {
//                               await ref.read(authProvider.notifier).logOut();
//                               if (context.mounted) {
//                                 Navigator.popUntil(
//                                     context, (route) => route.isFirst);
//                               }
//                             },
//                             child: Ink(
//                                 width: 115,
//                                 height: 30,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(25),
//                                     border: Border.all(
//                                         color: const Color.fromARGB(
//                                             255, 226, 226, 226))),
//                                 child: Container(
//                                   alignment: Alignment.center,
//                                   child: const Text(
//                                     "LOGOUT",
//                                     style: TextStyle(
//                                         // fontFamily: "OpenSans",
//                                         fontSize: 10,
//                                         color:
//                                             Color.fromARGB(255, 218, 218, 218)),
//                                   ),
//                                 )),
//                           ),
//                           if (profileController is ProfileLoaded)
//                             MaterialButton(
//                               onPressed: () {
//                                 ref
//                                     .read(deleteAccountProvider.notifier)
//                                     .sendOtp(profileController
//                                         .profileData.contacts.first.phone);

//                                 showDialog(
//                                     context: context,
//                                     useRootNavigator: false,
//                                     builder: (context) {
//                                       return _DeleteAccountDialog(
//                                           mobile: profileController.profileData
//                                               .contacts.first.phone);
//                                     });
//                               },
//                               child: Ink(
//                                   width: 115,
//                                   height: 30,
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(25),
//                                       border: Border.all(color: Colors.red)),
//                                   child: Container(
//                                     alignment: Alignment.center,
//                                     child: const Text(
//                                       "DELETE ACCOUNT",
//                                       style: TextStyle(
//                                           // fontFamily: "OpenSans",
//                                           fontSize: 10,
//                                           color: Color.fromARGB(
//                                               255, 218, 218, 218)),
//                                     ),
//                                   )),
//                             ),
//                           MaterialButton(
//                             onPressed: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) =>
//                                           AccountSettingsPage()));
//                             },
//                             child: Ink(
//                                 width: 115,
//                                 height: 30,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(25),
//                                     border: Border.all(color: Colors.red)),
//                                 child: Container(
//                                   alignment: Alignment.center,
//                                   child: const Text(
//                                     "DELETE ACCOUNT NEW",
//                                     style: TextStyle(
//                                         // fontFamily: "OpenSans",
//                                         fontSize: 10,
//                                         color:
//                                             Color.fromARGB(255, 218, 218, 218)),
//                                   ),
//                                 )),
//                           ),
//                         ],
//                       ),
//                     ),
//                   )
//                 ]),
//               );
//             },
//           )),
//         ));
//   }

//   Widget line() {
//     return Container(
//       height: 0.2,
//       width: 300,
//       color: const Color.fromRGBO(228, 228, 228, 0.86),
//     );
//   }
// }

// class ProfileWidgets extends StatelessWidget {
//   final String icon;
//   final String details;
//   final Function onTap;
//   const ProfileWidgets(
//       {super.key,
//       required this.icon,
//       required this.details,
//       required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: (() {
//         onTap();
//       }),
//       child: SizedBox(
//         height: 42,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             // Image(
//             //   image: AssetImage("assets/images/icons/$icon"),
//             //   height: 19,
//             // ),
//             SizedBox(width: 20, child: SvgPicture.asset(icon)),
//             const SizedBox(
//               width: 12,
//             ),
//             Text(
//               details,
//               style: const TextStyle(
//                 // fontFamily: "OpenSans",
//                 fontSize: 16,
//                 fontWeight: FontWeight.w400,
//                 color: Colors.white,
//               ),
//             ),
//           ],
//         ),
//       ),
//       // ),
//     );
//   }
// }

// class _EmailUpdateDialog extends ConsumerWidget {
//   _EmailUpdateDialog({super.key});

//   final _formKey = GlobalKey<FormState>();
//   final _emailController = TextEditingController();

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final controller = ref.watch(emailUpdateProvider);

//     ref.listen(emailUpdateProvider, (previous, next) {
//       if (next is EmailUpdateSuccess) {
//         if (context.mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text('Email updated successfully')));
//           Navigator.pop(context);
//         }
//       }

//       if (next is EmailUpdateError) {
//         if (context.mounted) {
//           Navigator.pop(context);
//         }
//         ScaffoldMessenger.of(context)
//             .showSnackBar(SnackBar(content: Text(next.msg)));
//       }
//     });

//     return Dialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//       elevation: 16,
//       child: Padding(
//         padding: const EdgeInsets.all(18),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text('Enter your new email'),
//               TextFormField(
//                 controller: _emailController,
//                 validator: MultiValidator([
//                   RequiredValidator(errorText: 'Enter a valid email'),
//                   EmailValidator(errorText: 'Enter a valid email')
//                 ]),
//                 decoration: InputDecoration(hintText: 'example@email.com'),
//               ),
//               const SizedBox(
//                 height: 12,
//               ),
//               controller is EmailUpdateLoading
//                   ? const CircularProgressIndicator()
//                   : RoundedGoldenButton(
//                       height: 42,
//                       onTap: () {
//                         if (_formKey.currentState!.validate()) {
//                           ref
//                               .read(emailUpdateProvider.notifier)
//                               .updateEmail(_emailController.text);
//                         }
//                       },
//                       text: 'Update')
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _DeleteAccountDialog extends ConsumerWidget {
//   final String mobile;
//   _DeleteAccountDialog({Key? key, required this.mobile}) : super(key: key);

//   final otpController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final controller = ref.watch(deleteAccountProvider);

//     ref.listen(deleteAccountProvider, (previous, next) {
//       if (next is DeleteAccountErrorState) {
//         ScaffoldMessenger.of(context)
//             .showSnackBar(SnackBar(content: Text(next.msg)));
//       }

//       if (next is DeleteSuccessState) {
//         ref.read(authProvider.notifier).logOut();
//       }
//     });

//     return Dialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         child: Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Icon(
//                 Icons.delete_forever_outlined,
//                 color: Colors.red,
//                 size: 40,
//               ),
//               const Text(
//                 'Enter OTP sent your registered mobile number to delete your account',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
//               ),
//               Form(
//                   key: _formKey,
//                   child: TextFormField(
//                     controller: otpController,
//                     keyboardType: TextInputType.number,
//                     textAlign: TextAlign.center,
//                     decoration: const InputDecoration(hintText: 'Enter OTP'),
//                     validator: (String? value) {
//                       if (value == null || value.isEmpty) {
//                         return 'OTP required';
//                       }
//                       if (value.length < 4) {
//                         return 'Not a valid OTP';
//                       }
//                       return null;
//                     },
//                   )),
//               const SizedBox(
//                 height: 12,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   TextButton(
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                       child: const Text(
//                         'CANCEL',
//                       )),
//                   if (controller is DeleteAccountLoading)
//                     const SizedBox(
//                       width: 120,
//                       child: Center(child: CircularProgressIndicator()),
//                     ),
//                   if (controller is! DeleteAccountLoading)
//                     SizedBox(
//                       width: 120,
//                       child: GoldBorderButton(
//                         height: 32,
//                         onTap: () async {
//                           if (_formKey.currentState!.validate()) {
//                             await ref
//                                 .read(deleteAccountProvider.notifier)
//                                 .deleteAccount(
//                                   mobile,
//                                 );
//                             if (context.mounted) {
//                               Navigator.popUntil(
//                                   context, (route) => route.isFirst);
//                             }
//                           }
//                         },
//                         text: 'DELETE',
//                         textStyle: const TextStyle(
//                             fontSize: 14,
//                             color: Colors.red,
//                             fontWeight: FontWeight.w500),
//                       ),
//                     )
//                 ],
//               ),
//             ],
//           ),
//         ));
//   }
// }
