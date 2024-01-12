// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:htp_customer/common/form_validator.dart';
// import 'package:htp_customer/features/profile/controller/profile_controller.dart';
// import 'package:htp_customer/features/profile/controller/profile_update_controller.dart';
// import 'package:htp_customer/features/profile/data/models/profile_response.dart';
// import 'package:htp_customer/features/profile/presentation/widgets/radiobutton.dart';
// import 'package:htp_customer/htp_theme.dart';
// import 'package:htp_customer/common/widgets_common/rounded_golden_button.dart';
// import '../../../../authentication/theme.dart';
// import '../../dashboard/presentation/widgets/custom_app_bar.dart';
//
// class UpdateProfilePage extends ConsumerWidget {
//   static const route = '/updateprofile';
//
//   final _formKeyProfile = GlobalKey<FormState>();
//
//   final _nameTextController = TextEditingController();
//   final _cityTextController = TextEditingController();
//   final _favouriteClubController = TextEditingController();
//   final _fbTextController = TextEditingController();
//   final _twitterController = TextEditingController();
//   final _instaTextController = TextEditingController();
//
//   // final _usernameTextController = TextEditingController();
//   // final _emailTextController = TextEditingController();
//   // final _phoneTextController = TextEditingController();
//   // final _whatsappTextController = TextEditingController();
//
//   // final _birthTextController = TextEditingController();
//
//   final _focusName = FocusNode();
//   // final _focusUserName = FocusNode();
//   final _focusEmail = FocusNode();
//   final _focusPhone = FocusNode();
//   // final _focusWhatsappPhone = FocusNode();
//   final _focusCity = FocusNode();
//   final _focusBirth = FocusNode();
//   final _focusFavourite = FocusNode();
//   final _focusFb = FocusNode();
//   final _focusTwitter = FocusNode();
//   final _focusInsta = FocusNode();
//
//   var colorTheme = AuthTheme.colorTheme();
//
//   TextStyle textStyling = const TextStyle(
//       height: 0.4,
//       // fontFamily: 'Montserrat',
//       fontSize: 13,
//       color: Color.fromRGBO(255, 255, 255, 0.96));
//
//   InputDecoration inputDecorations(String? hintText) {
//     return InputDecoration(
//         enabledBorder: UnderlineInputBorder(
//           borderSide: BorderSide(
//             width: 0.6,
//             //  color: Colors.yellow
//             color: colorTheme.primaryColor,
//           ),
//         ),
//         focusedBorder: UnderlineInputBorder(
//             borderSide: BorderSide(color: colorTheme.primaryColor)),
//         focusedErrorBorder: const UnderlineInputBorder(
//           borderSide: BorderSide(color: Colors.red),
//         ),
//         hintText: hintText,
//         hintStyle:
//             textStyling.apply(color: const Color.fromRGBO(255, 255, 255, 0.40))
//         //  TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 12),
//
//         );
//   }
//
//   // var _gendervalue = 1;
//   Widget buildBody(BuildContext context, WidgetRef ref) {
//     return Container(
//         // margin: const EdgeInsets.only(bottom: 100),
//         //   height: MediaQuery.of(context).size.height,
//         decoration: const BoxDecoration(
//             image: DecorationImage(
//                 opacity: 0.3,
//                 alignment: Alignment.bottomLeft,
//                 image: AssetImage(
//                   "assets/images/mask_group.png",
//                 ))),
//         // color: colorTheme.backgroundColor,
//
//         child: SingleChildScrollView(
//             padding: const EdgeInsets.only(bottom: 36),
//             child: Column(children: [
//               Form(
//                   key: _formKeyProfile,
//                   child: Column(
//                     children: [
//                       // const SizedBox(
//                       //   height: 5,
//                       // ),
//                       // Container(
//                       //   padding: const EdgeInsets.only(
//                       //       left: 24, right: 60.0, bottom: 24),
//                       //   child: const Align(
//                       //       alignment: Alignment.centerLeft,
//                       //       child: Text(
//                       //         "Update your profile for personalised experience",
//                       //         style: TextStyle(
//                       //
//                       //             color: Colors.white,
//                       //             fontSize: 18,
//                       //             fontWeight: FontWeight.w400),
//                       //       )),
//                       // ),
//                       const SizedBox(
//                         height: 15,
//                       ),
//
//                       //------------------------------name---------------------------------------
//                       part1(),
//                       //-----------------------------------Gender-------------------------------------
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 24.0),
//                         child: Consumer(
//                           builder: (context, ref, _) {
//                             final selectedGender = ref.watch(genderProvider);
//                             return Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "Sex",
//                                   style: textStyling,
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.only(bottom: 22.0),
//                                   child: Column(
//                                     children: [
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.start,
//                                         children: [
//                                           MyRadioListTile(
//                                             value: GenderSelection.male,
//                                             groupValue: selectedGender,
//                                             onChanged: (value) {
//                                               ref
//                                                   .read(genderProvider.notifier)
//                                                   .state = GenderSelection.male;
//                                             },
//                                             title: 'Male',
//                                           ),
//                                           MyRadioListTile(
//                                               value: GenderSelection.female,
//                                               groupValue: selectedGender,
//                                               onChanged: (value) {
//                                                 ref
//                                                         .read(genderProvider
//                                                             .notifier)
//                                                         .state =
//                                                     GenderSelection.female;
//                                               },
//                                               title: 'Female'),
//                                           MyRadioListTile(
//                                               value: GenderSelection.other,
//                                               groupValue: selectedGender,
//                                               onChanged: (value) {
//                                                 print(selectedGender?.desc);
//                                                 ref
//                                                         .read(genderProvider
//                                                             .notifier)
//                                                         .state =
//                                                     GenderSelection.other;
//                                               },
//                                               title: 'Non-Binary')
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             );
//                           },
//                         ),
//                       ),
//                       Container(
//                         height: 8,
//                         width: double.infinity,
//                         color: const Color.fromRGBO(255, 255, 255, 0.11),
//                       ),
//                       const SizedBox(
//                         height: 28,
//                       ),
//                       Prefrences(ref),
//                       //-----------------------------------------Home city-----------------------------------------
//
//                       Container(
//                         height: 8,
//                         width: double.infinity,
//                         color: const Color.fromRGBO(255, 255, 255, 0.11),
//                       ),
//                       const SizedBox(
//                         height: 24,
//                       ),
//                       //---------------------------------Social media-------------------
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 24.0),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Social media handle",
//                               style: textStyling,
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(bottom: 6.0),
//                               child: TextFormField(
//                                   style:
//                                       TextStyle(color: colorTheme.primaryColor),
//                                   controller: _fbTextController,
//                                   focusNode: _focusFb,
//                                   // validator: (value) => Validator.validateName(
//                                   //   name: value,
//                                   // ),
//                                   decoration: inputDecorations("Facebook")),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(bottom: 7.0),
//                               child: TextFormField(
//                                   style:
//                                       TextStyle(color: colorTheme.primaryColor),
//                                   controller: _twitterController,
//                                   focusNode: _focusTwitter,
//                                   // validator: (value) => Validator.validateName(
//                                   //   name: value,
//                                   // ),
//                                   decoration: inputDecorations("Twitter")),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(bottom: 6.0),
//                               child: TextFormField(
//                                   style:
//                                       TextStyle(color: colorTheme.primaryColor),
//                                   controller: _instaTextController,
//                                   focusNode: _focusInsta,
//                                   // validator: (value) => Validator.validateName(
//                                   //   name: value,
//                                   // ),
//                                   decoration: inputDecorations("Instagram")),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 50,
//                       ),
//                       //-------------------
//                     ],
//                   )),
//               Consumer(
//                 builder: (context, ref, _) {
//                   final controller = ref.watch(profileUpdatedProvider);
//
//                   ref.listen(profileUpdatedProvider, (previous, next) {
//                     if (next is ProfileUpdateError) {
//                       ScaffoldMessenger.of(context)
//                           .showSnackBar(SnackBar(content: Text(next.msg)));
//                     }
//                   });
//
//                   if (controller is ProfileUpdateLoading) {
//                     return const Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   }
//
//                   return RoundedGoldenButton(
//                     onTap: () async {
//                       if (!_formKeyProfile.currentState!.validate()) {
//                         return;
//                       }
//                       await ref
//                           .read(profileUpdatedProvider.notifier)
//                           .updateProfile(UserEditModel(
//                               name: _nameTextController.text,
//                               socialHandle: SocialHandle(
//                                   facebook: _fbTextController.text,
//                                   instagram: _instaTextController.text,
//                                   twitter: _twitterController.text),
//                               gender:
//                                   ref.read(genderProvider.notifier).state?.desc,
//                               favClub: [_favouriteClubController.text],
//                               favCities: _cityTextController.text,
//                               smokingHabit:
//                                   ref.read(smokeProvider.notifier).state,
//                               drinkingHabit:
//                                   ref.read(alcoholProvider.notifier).state,
//                               clubbing:
//                                   ref.read(clubbingProvider.notifier).state,
//                               drivingHabit:
//                                   ref.read(driveProvider.notifier).state));
//                       ref.read(profileControllerProvider.notifier).getProfile();
//                       if (context.mounted) {
//                         Navigator.of(context).pop();
//                       }
//                     },
//                     text: "UPDATE",
//                     textStyle: const TextStyle(
//                         color: HtpTheme.cardBlackColor,
//                         fontWeight: FontWeight.w600),
//                   );
//                 },
//               )
//             ])));
//   }
//
//   Widget part1() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 24.0),
//       child: Column(
//         children: [
//           Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Full name",
//                 style: textStyling,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 32.0),
//                 child: TextFormField(
//                     style: TextStyle(color: colorTheme.primaryColor),
//                     controller: _nameTextController,
//                     focusNode: _focusName,
//                     // validator: MultiValidator([RequiredValidator(errorText: 'Required field'), MinLengthValidator(3, errorText: 'Name too short!')]),
//                     validator: (val) {
//                       if (val == null || val.trim().isEmpty) {
//                         return 'Enter valid name';
//                       }
//
//                       if (val.length <= 3) {
//                         return 'Name too short';
//                       }
//
//                       return null;
//                     },
//                     decoration: inputDecorations("Full name")),
//               ),
//             ],
//           ),
//           //------------------------------username---------------------------------------
//           Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: const [
//               // Text(
//               //   "User Name",
//               //   style: textStyling,
//               // ),
//               // Padding(
//               //   padding: const EdgeInsets.only(bottom: 32.0),
//               //   child: TextFormField(
//               //       style: TextStyle(color: colorTheme.primaryColor),
//               //       controller: _usernameTextController,
//               //       focusNode: _focusUserName,
//               //       validator: (value) => Validator.validateName(
//               //             name: value,
//               //           ),
//               //       decoration: inputDecorations("User Name")),
//               // ),
//             ],
//           ),
//           //-----------------------------------------email--------------------------------------------
//           // Column(
//           //   mainAxisAlignment: MainAxisAlignment.start,
//           //   crossAxisAlignment: CrossAxisAlignment.start,
//           //   children: [
//           //     Text(
//           //       "Email",
//           //       style: textStyling,
//           //     ),
//           //     Padding(
//           //       padding: const EdgeInsets.only(bottom: 32.0),
//           //       child: TextFormField(
//           //           style: TextStyle(color: colorTheme.primaryColor),
//           //           controller: _emailTextController,
//           //           focusNode: _focusEmail,
//           //           validator: (value) => Validator.validateEmail(
//           //                 email: value,
//           //               ),
//           //           decoration: inputDecorations("email@example.com")),
//           //     ),
//           //   ],
//           // ),
//
//           //-------------------------- phone number---------------------------------------
//
//           // Column(
//           //   mainAxisAlignment: MainAxisAlignment.start,
//           //   crossAxisAlignment: CrossAxisAlignment.start,
//           //   children: [
//           //     Text(
//           //       "Phone",
//           //       style: textStyling,
//           //     ),
//           //     Consumer(
//           //       builder: (context, ref, _) {
//           //         final codeController = ref.watch(countryCodeProvider);
//           //         return Padding(
//           //             padding: const EdgeInsets.only(bottom: 18.0),
//           //             child: Row(
//           //               children: [
//           //                 CountryPickerDropdown(
//           //                     onValuePicked: (value) {
//           //                       ref.read(countryCodeProvider.notifier).state =
//           //                           "+${value.phoneCode}";
//           //                     },
//           //                     initialValue: 'IN',
//           //                     dropdownColor: Colors.black54,
//           //                     iconDisabledColor: Colors.white,
//           //                     iconEnabledColor: Colors.white,
//           //                     itemBuilder: (country) {
//           //                       return CountryPickerUtils.getDefaultFlagImage(
//           //                           country);
//           //                     }),
//           //                 // CountryListPick(
//           //                 //   onChanged: (Value) {},
//           //                 //   initialSelection: 'US',
//           //                 //   theme: CountryTheme(
//           //                 //       labelColor:
//           //                 //           colorTheme.primaryColor,
//           //                 //       isShowCode: false,
//           //                 //       isShowTitle: false),
//           //                 // ),
//           //
//           //                 Expanded(
//           //                   child: TextFormField(
//           //                       keyboardType: TextInputType.number,
//           //                       style:
//           //                           TextStyle(color: colorTheme.primaryColor),
//           //                       controller: _phoneTextController,
//           //                       focusNode: _focusPhone,
//           //                       validator: (value) =>
//           //                           Validator.validatePhoneNumber(
//           //                             phoneNumber: value,
//           //                           ),
//           //                       decoration: inputDecorations("Phone")),
//           //                 ),
//           //               ],
//           //             ));
//           //       },
//           //     ),
//           //     Column(
//           //       mainAxisAlignment: MainAxisAlignment.start,
//           //       crossAxisAlignment: CrossAxisAlignment.start,
//           //       children: [
//           //         Text(
//           //           "Whatsapp",
//           //           style: textStyling,
//           //         ),
//           //         Container(
//           //           padding: const EdgeInsets.only(bottom: 26),
//           //           child: Row(
//           //             children: [
//           //               // CountryPickerDropdown(
//           //               //   onValuePicked: (value) {},
//           //               //   initialValue: 'US',
//           //               // ),
//           //               //---------------------------------------------
//           //               // CountryListPick(
//           //               //   onChanged: (Value) {},
//           //               //   initialSelection: 'US',
//           //               //   theme: CountryTheme(
//           //               //       labelColor:
//           //               //           colorTheme.primaryColor,
//           //               //       isShowCode: false,
//           //               //       isShowTitle: false),
//           //               // ),
//           //               Expanded(
//           //                 child: TextFormField(
//           //                     keyboardType: TextInputType.number,
//           //                     style: TextStyle(color: colorTheme.primaryColor),
//           //                     controller: _whatsappTextController,
//           //                     focusNode: _focusWhatsappPhone,
//           //                     validator: (value) =>
//           //                         Validator.validatePhoneNumber(
//           //                           phoneNumber: value,
//           //                         ),
//           //                     decoration: inputDecorations("Mobile")),
//           //               ),
//           //             ],
//           //           ),
//           //         ),
//           //       ],
//           //     ),
//           //   ],
//           // ),
//           //-----------------------------------DOB----------------------------------------
//           // Column(
//           //   mainAxisAlignment: MainAxisAlignment.start,
//           //   crossAxisAlignment: CrossAxisAlignment.start,
//           //   children: [
//           //     Text(
//           //       "Date of Birth",
//           //       style: textStyling,
//           //     ),
//           //     Padding(
//           //       padding: const EdgeInsets.only(bottom: 32.0),
//           //       child: TextFormField(
//           //           onTap: () async {
//           //             final pickedData = await showDatePicker(
//           //                 context: context,
//           //                 initialDate:
//           //                     DateTime.now().subtract(const Duration(days: 1)),
//           //                 firstDate: DateTime(1950),
//           //                 lastDate: DateTime.now());
//           //             if (pickedData != null) {
//           //               _birthTextController.text =
//           //                   DateFormat('MM/dd/yyyy').format(pickedData);
//           //             }
//           //           },
//           //           style: TextStyle(color: colorTheme.primaryColor),
//           //           controller: _birthTextController,
//           //           readOnly: true,
//           //           decoration: inputDecorations("MM/DD/YYYY")),
//           //     ),
//           //   ],
//           // ),
//         ],
//       ),
//     );
//   }
//
//   Widget Prefrences(WidgetRef ref) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 24.0),
//       child: Column(
//         children: [
//           Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "One of your favourite club",
//                 style: textStyling,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 6.0),
//                 child: TextFormField(
//                     style: TextStyle(color: colorTheme.primaryColor),
//                     controller: _favouriteClubController,
//                     focusNode: _focusFavourite,
//                     // validator: (value) => Validator.validateName(
//                     //       name: value,
//                     //     ),
//                     decoration: inputDecorations("Favourite club ")),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 32.0),
//                 child: TextFormField(
//                     style: TextStyle(color: colorTheme.primaryColor),
//                     controller: _cityTextController,
//                     focusNode: _focusCity,
//                     // validator: (value) => Validator.validateName(
//                     //       name: value,
//                     //     ),
//                     decoration: inputDecorations("Favourite city")),
//               ),
//             ],
//           ),
//           //---------------radiobutton
//           Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Do you smoke ?",
//                 style: textStyling,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 6.0, top: 15.0),
//                 child: Consumer(builder: (context, ref, _) {
//                   final selection = ref.watch(smokeProvider);
//                   return Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       MyRadioListTile(
//                           value: true,
//                           groupValue: selection,
//                           onChanged: (value) {
//                             ref.read(smokeProvider.notifier).state = true;
//                           },
//                           title: "Yes"),
//                       const SizedBox(
//                         width: 33,
//                       ),
//                       MyRadioListTile(
//                           value: false,
//                           groupValue: selection,
//                           onChanged: (value) {
//                             ref.read(smokeProvider.notifier).state = false;
//                           },
//                           title: "No")
//                     ],
//                   );
//                 }),
//               ),
//             ],
//           ),
//           const SizedBox(
//             height: 17,
//           ),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Do you drink alcohol ?",
//                 style: textStyling,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 17.0, top: 11.0),
//                 child: Column(
//                   children: [
//                     Consumer(builder: (context, ref, _) {
//                       final selection = ref.watch(alcoholProvider);
//                       return Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           MyRadioListTile(
//                               value: true,
//                               groupValue: selection,
//                               onChanged: (value) {
//                                 ref.read(alcoholProvider.notifier).state = true;
//                               },
//                               title: "Yes"),
//                           const SizedBox(
//                             width: 33,
//                           ),
//                           MyRadioListTile(
//                               value: false,
//                               groupValue: selection,
//                               onChanged: (value) {
//                                 ref.read(alcoholProvider.notifier).state =
//                                     false;
//                               },
//                               title: "No")
//                         ],
//                       );
//                     }),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//
//           Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "How often do you go clubbing/ to a bar ?",
//                 style: textStyling,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 22.0, top: 11.0),
//                 child: Consumer(
//                   builder: (context, ref, _) {
//                     final selection = ref.watch(clubbingProvider);
//                     return Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         MyRadioListTile(
//                           value: 'Daily',
//                           groupValue: selection,
//                           onChanged: (value) {
//                             ref.read(clubbingProvider.notifier).state = 'Daily';
//                           },
//                           title: 'Daily',
//                         ),
//                         const SizedBox(
//                           width: 33,
//                         ),
//                         MyRadioListTile(
//                             value: 'Weekly',
//                             groupValue: selection,
//                             onChanged: (value) {
//                               ref.read(clubbingProvider.notifier).state =
//                                   'Weekly';
//                             },
//                             title: 'Weekly'),
//                         const SizedBox(
//                           width: 33,
//                         ),
//                         MyRadioListTile(
//                             value: 'Monthly',
//                             groupValue: selection,
//                             onChanged: (value) {
//                               ref.read(clubbingProvider.notifier).state =
//                                   'Monthly';
//                             },
//                             title: 'Monthly')
//                       ],
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//
//           Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Do you usually drive ?",
//                 style: textStyling,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 17.0, top: 11.0),
//                 child: Column(
//                   children: [
//                     Consumer(builder: (context, ref, _) {
//                       final selection = ref.watch(driveProvider);
//                       return Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           MyRadioListTile(
//                               value: true,
//                               groupValue: selection,
//                               onChanged: (value) {
//                                 ref.read(driveProvider.notifier).state = true;
//                               },
//                               title: "Yes"),
//                           const SizedBox(
//                             width: 33,
//                           ),
//                           MyRadioListTile(
//                               value: false,
//                               groupValue: selection,
//                               onChanged: (value) {
//                                 ref.read(driveProvider.notifier).state = false;
//                               },
//                               title: "No")
//                         ],
//                       );
//                     }),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final profileController = ref.watch(profileControllerProvider);
//
//     if (profileController is ProfileLoaded) {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         _nameTextController.text = profileController.profileData.name ?? '';
//         _fbTextController.text =
//             profileController.userEditModel.socialHandle?.facebook ?? "";
//         _instaTextController.text =
//             profileController.userEditModel.socialHandle?.instagram ?? "";
//         _twitterController.text =
//             profileController.userEditModel.socialHandle?.twitter ?? "";
//         ref.read(genderProvider.notifier).state =
//             profileController.userEditModel.getGenderEnum();
//         _favouriteClubController.text =
//             (profileController.userEditModel.favClub ?? []) as String;
//         _cityTextController.text =
//             profileController.userEditModel.favCities ?? "";
//         ref.read(smokeProvider.notifier).state =
//             profileController.userEditModel.smokingHabit;
//         ref.read(alcoholProvider.notifier).state =
//             profileController.userEditModel.drinkingHabit;
//         ref.read(clubbingProvider.notifier).state =
//             profileController.userEditModel.clubbing;
//         ref.read(driveProvider.notifier).state =
//             profileController.userEditModel.drivingHabit;
//       });
//     }
//
//     return GestureDetector(
//         onTap: () {
//           _focusName.unfocus();
//           _focusEmail.unfocus();
//           _focusPhone.unfocus();
//           _focusCity.unfocus();
//           _focusBirth.unfocus();
//         },
//         child: SafeArea(
//           child: Scaffold(
//             appBar: CustomAppBar(
//               // height: 30,
//               child: Text(
//                 'Update profile',
//                 style: HtpTheme.newTitleTextStyle,
//               ),
//             ),
//             body: buildBody(context, ref),
//
//             // floatingActionButton: Container(
//             //   padding: const EdgeInsets.only(left: 40, right: 6),
//             //   margin: const EdgeInsets.only(bottom: 80),
//             //   child: Consumer(
//             //     builder: (context, ref, _){
//             //      final controller = ref.watch(profileUpdatedProvider);
//             //
//             //      ref.listen(profileUpdatedProvider, (previous, next) {
//             //        if(next is ProfileUpdateError){
//             //          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(next.msg)));
//             //        }
//             //      });
//             //
//             //      if(controller is ProfileUpdateLoading){
//             //        return const Center(child: CircularProgressIndicator(),);
//             //      }
//             //
//             //       return RoundedGoldenButton(
//             //         onTap: () async{
//             //           if(!_formKeyProfile.currentState!.validate()){
//             //             return;
//             //           }
//             //           await ref.read(profileUpdatedProvider.notifier).updateProfile(UserEditModel(
//             //               name: _nameTextController.text,
//             //               socialHandle: SocialHandle(facebook: _fbTextController.text, instagram: _instaTextController.text, twitter: _twitterController.text),
//             //               gender: ref.read(genderProvider.notifier).state?.desc,
//             //               favClub: _favouriteClubController.text,
//             //               favCities: _cityTextController.text,
//             //               smokingHabit: ref.read(smokeProvider.notifier).state,
//             //               drinkingHabit: ref.read(alcoholProvider.notifier).state,
//             //               clubbing: ref.read(clubbingProvider.notifier).state,
//             //               drivingHabit: ref.read(driveProvider.notifier).state
//             //           ));
//             //           ref.read(profileControllerProvider.notifier).getProfile();
//             //         },
//             //         text: "UPDATE",
//             //         textStyle: const TextStyle(
//             //             color: HtpTheme.cardBlackColor,
//             //             fontWeight: FontWeight.w600),
//             //       );
//             //     },
//             //   ),
//             // ),
//           ),
//         ));
//   }
// }
