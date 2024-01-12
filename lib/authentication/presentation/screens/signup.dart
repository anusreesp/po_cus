// import 'package:country_pickers/country_picker_dropdown.dart';
// import 'package:country_pickers/utils/utils.dart';
// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:htp_customer/authentication/controllers/auth_controller.dart';
// import 'package:htp_customer/authentication/controllers/locations_controller.dart';
// import 'package:htp_customer/authentication/controllers/signup_controller.dart';
// import 'package:htp_customer/authentication/data/models/city_list.dart';
// import 'package:htp_customer/authentication/data/models/country_list.dart';
// import 'package:htp_customer/authentication/data/service/auth_service.dart';
// import 'package:htp_customer/authentication/data/service/firebase_auth_service.dart';
// import 'package:htp_customer/authentication/presentation/screens/login.dart';
// import 'package:htp_customer/authentication/theme.dart';
// import 'package:htp_customer/common/form_validator.dart';
// import 'package:htp_customer/common/widgets_common/radio_tile.dart';
// import 'package:htp_customer/common/widgets_common/rounded_golden_button.dart';
// import 'package:htp_customer/htp_theme.dart';
// import 'package:htp_customer/router.dart';
// import 'package:htp_customer/startup_page.dart';
// import 'package:intl/intl.dart';
// import 'package:url_launcher/url_launcher.dart';

// import '../../data/models/signup_data.dart';
// import '../widgets/dialogbox.dart';

// final countryCodeProviderWA = StateProvider<String>((ref) => '+91');

// class SignupPage extends ConsumerWidget {
//   static const route = '/signup';
//   final String mobile;
//   final bool isWhatsAppNumber;
//   final String? name;
//   final String? email;
//   // final bool emailLogin;
//   // final bool emailReg;
//   final bool isSocialReg;
//   SignupPage(
//       {super.key,
//       required this.mobile,
//       this.isWhatsAppNumber = false,
//       required this.isSocialReg,
//       this.name,
//       this.email});

//   final _formKeySignup = GlobalKey<FormState>();
//   final _nameTextController = TextEditingController();
//   final _emailTextController = TextEditingController();
//   final _passwordTextController = TextEditingController();
//   final _confirmPasswordTextController = TextEditingController();
//   final _phoneTextController = TextEditingController();
//   final _whatsappTextController = TextEditingController();
//   final _stateTextController = TextEditingController();
//   // final _cityTextController = SingleValueDropDownController();
//   final _birthTextController = TextEditingController();

//   CityData? cityData;

//   final _focusName = FocusNode();
//   final _focusEmail = FocusNode();
//   final _focusPassword = FocusNode();
//   final _focusPhone = FocusNode();
//   final _focusWhatsappPhone = FocusNode();
//   final _focusCity = FocusNode();
//   final _focusBirth = FocusNode();
//   final _focusGender = FocusNode();

//   // final bool _isPasswordVisible = false;
//   // bool onToggleButton = true;
//   // int value = 0;
//   // bool _agreeTandC = false;
//   // var toggleButton;

//   // String? genders;
//   final List<String> gender = ["Male", "Female", "Non-Binary"];
//   // List homeCity = [
//   //   "New York",
//   //   "Benguluru",
//   //   "Kolkatta",
//   //   "Tokyo",
//   //   "Califormia",
//   //   "Doha"
//   // ];

//   DateTime? pickedData;
//   var colorTheme = AuthTheme.colorTheme();

//   // String? select;
//   String verificationId = "";
//   // String phoneNumber = "";
//   // late AuthCredential phoneAuthCredential;

//   final requiredText = '*This field is required';

//   Widget _addRadioButton(String title, String? groupValue, WidgetRef ref) {
//     return RadioTile(
//         value: title,
//         groupValue: groupValue,
//         onChanged: (value) {
//           if (value != null) {
//             ref.read(genderProvider.notifier).state = value;
//           }
//         },
//         title: title);
//     // return Row(
//     //   mainAxisAlignment: MainAxisAlignment.start,
//     //   children: <Widget>[
//     //     Radio(
//     //       activeColor: colorTheme.primaryColor,
//     //       fillColor: MaterialStateProperty.all(HtpTheme.goldenColor),
//     //       value: title,
//     //       groupValue: groupValue,
//     //       onChanged: (value) {
//     //         if(value != null){
//     //           ref.read(genderProvider.notifier).state = value;
//     //         }
//     //       },
//     //     ),
//     //     GestureDetector(
//     //       onTap: (){
//     //         ref.read(genderProvider.notifier).state = title;
//     //       },
//     //       child: Text(
//     //         title,
//     //         style: TextStyle(color: colorTheme.primaryColor),
//     //       ),
//     //     )
//     //   ],
//     // );
//   }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     _emailTextController.text = email ?? '';
//     _nameTextController.text = name ?? '';

//     ref.listen(signupProvider, (previous, next) {
//       if (next is SignupError) {
//         ScaffoldMessenger.of(context)
//             .showSnackBar(SnackBar(content: Text(next.msg)));
//       }

//       if (next is SignupSuccess) {
//         print('Success');
//         if (isSocialReg) {
//           ref.read(authProvider.notifier).checkUser().then((_) {
//             // Navigator.popUntil(context, (route) => route.isFirst);
//             Navigator.pushReplacement(context,
//                 MaterialPageRoute(builder: (context) => StartupPage()));
//           });
//         } else {
//           ref.read(authProvider.notifier).checkUser();
//           Navigator.popUntil(context, (route) => route.isFirst);
//         }

//         // mainNavigatorKey.currentState?.pushReplacement(MaterialPageRoute(builder: (context) => const StartupPage()));
//       }
//     });

//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//           decoration: const BoxDecoration(
//               image: DecorationImage(
//                   image: AssetImage('assets/images/mask_group.png'),
//                   fit: BoxFit.fitWidth,
//                   opacity: 0.3,
//                   alignment: Alignment.bottomLeft)),
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: Form(
//               key: _formKeySignup,
//               child: Column(children: [
//                 const SizedBox(
//                   height: 100,
//                 ),

//                 Image.asset(
//                   "assets/images/logos/party_onebottom.png",
//                   // scale: 6.0,
//                   height: 88,
//                 ),

//                 const SizedBox(
//                   height: 12,
//                 ),

//                 Container(
//                   padding: const EdgeInsets.symmetric(vertical: 12),
//                   alignment: Alignment.topLeft,
//                   child: const Text(
//                     "Get lit.",
//                     style: TextStyle(
//                         fontFamily: "Montserrat",
//                         fontWeight: FontWeight.w400,
//                         fontSize: 23),
//                   ),
//                 ),

//                 const SizedBox(
//                   height: 25,
//                 ),

//                 _CustomTextField(
//                   controller: _nameTextController,
//                   focusNode: _focusName,
//                   labelText: 'Your Full Name *',
//                   hintText: 'Full Name',
//                   validator: MultiValidator([
//                     RequiredValidator(errorText: requiredText),
//                     MinLengthValidator(3, errorText: 'Name too short!')
//                   ]),
//                 ),

//                 _CustomTextField(
//                   controller: _emailTextController,
//                   focusNode: _focusEmail,
//                   labelText: 'Email *',
//                   hintText: 'Email',
//                   validator: MultiValidator([
//                     RequiredValidator(errorText: requiredText),
//                     EmailValidator(errorText: 'Enter a valid email')
//                   ]),
//                 ),

//                 //-------------------------- phone number---------------------------------------

//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     if (!isWhatsAppNumber)
//                       Padding(
//                         padding: const EdgeInsets.only(bottom: 32.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "WhatsApp Number *",
//                               style: TextStyle(
//                                   color: colorTheme.primaryColor, height: 0.4),
//                             ),
//                             Consumer(builder: (context, ref, _) {
//                               final codeController =
//                                   ref.watch(countryCodeProviderWA);
//                               return Padding(
//                                   padding: const EdgeInsets.only(right: 12),
//                                   child: Row(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       CountryPickerDropdown(
//                                         onValuePicked: (value) {
//                                           ref
//                                               .read(countryCodeProviderWA
//                                                   .notifier)
//                                               .state = "+${value.phoneCode}";
//                                         },
//                                         initialValue: 'IN',
//                                         dropdownColor: Colors.black54,
//                                         iconDisabledColor: Colors.white,
//                                         iconEnabledColor: Colors.white,
//                                         itemBuilder: (country) {
//                                           return SizedBox(
//                                             width: 80,
//                                             child: Row(
//                                               mainAxisSize: MainAxisSize.min,
//                                               children: [
//                                                 CountryPickerUtils
//                                                     .getDefaultFlagImage(
//                                                         country),
//                                                 const SizedBox(
//                                                   width: 4,
//                                                 ),
//                                                 Expanded(
//                                                     child: FittedBox(
//                                                         child:
//                                                             Text(country.name)))
//                                               ],
//                                             ),
//                                           );
//                                         },
//                                       ),
//                                       Expanded(
//                                         child: Column(
//                                           children: [
//                                             TextFormField(
//                                                 keyboardType:
//                                                     TextInputType.number,
//                                                 style: const TextStyle(
//                                                     color: Colors.white),
//                                                 controller:
//                                                     _whatsappTextController,
//                                                 validator: (val) {
//                                                   if (val == null) {
//                                                     return requiredText;
//                                                   }
//                                                   if (val.isEmpty) {
//                                                     return requiredText;
//                                                   }
//                                                   // if(val == '${(ref.read(countryCodeProviderWA))}${_whatsappTextController.text}'){
//                                                   //   return 'Your calling number cannot be same as WhatsApp';
//                                                   // }
//                                                   //
//                                                   return null;
//                                                 },
//                                                 decoration: InputDecoration(
//                                                     prefixIcon: Padding(
//                                                         padding: const EdgeInsets
//                                                                 .only(
//                                                             top: 14, left: 12),
//                                                         child: Text(
//                                                           codeController,
//                                                           style:
//                                                               const TextStyle(
//                                                                   color: Colors
//                                                                       .white,
//                                                                   fontSize: 14),
//                                                         )),
//                                                     enabledBorder:
//                                                         const UnderlineInputBorder(
//                                                       borderSide: BorderSide(
//                                                         width: 0.6,
//                                                         //  color: Colors.yellow
//                                                         color: Colors.white,
//                                                       ),
//                                                     ),
//                                                     focusedBorder:
//                                                         const UnderlineInputBorder(
//                                                             borderSide:
//                                                                 BorderSide(
//                                                                     color: Colors
//                                                                         .white)),
//                                                     focusedErrorBorder:
//                                                         const UnderlineInputBorder(
//                                                       borderSide: BorderSide(
//                                                           color: Colors.red),
//                                                     ),
//                                                     hintText:
//                                                         'WhatsApp Number *',
//                                                     hintStyle: TextStyle(
//                                                         // color: Color.fromARGB(255, 161, 161, 161),
//                                                         color: Colors.white
//                                                             .withOpacity(0.4),
//                                                         fontSize: 12))),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ));
//                             }),
//                           ],
//                         ),
//                       ),

//                     // Consumer(builder: (context, ref, _) {
//                     //   final codeController = ref.watch(countryCodeProvider);
//                     //   return Padding(
//                     //       padding: const EdgeInsets.only(bottom: 8.0),
//                     //       child: Row(
//                     //         children: [
//                     //           CountryPickerDropdown(
//                     //             onValuePicked: (value) {
//                     //               ref.read(countryCodeProvider.notifier).state =
//                     //               "+${value.phoneCode}";
//                     //             },
//                     //             initialValue: 'IN',
//                     //             dropdownColor: Colors.black54,
//                     //             iconDisabledColor: Colors.white,
//                     //             iconEnabledColor: Colors.white,
//                     //             itemBuilder: (country) {
//                     //               return CountryPickerUtils.getDefaultFlagImage(
//                     //                   country);
//                     //               // return Row(
//                     //               //   mainAxisSize: MainAxisSize.min,
//                     //               //   children: [
//                     //               //     CountryPickerUtils.getDefaultFlagImage(country),
//                     //               //     Text(" +${country.phoneCode}", style: const TextStyle(color: Colors.white),),
//                     //               //   ],
//                     //               // );
//                     //             },
//                     //           ),
//                     //           Expanded(
//                     //             child: TextFormField(
//                     //                 keyboardType: TextInputType.number,
//                     //                 style:
//                     //                 TextStyle(color: colorTheme.primaryColor),
//                     //                 controller: _phoneTextController,
//                     //                 focusNode: _focusPhone,
//                     //                 validator: MultiValidator([RequiredValidator(errorText: 'This field is mandatory'), PhoneValidator(errorText: 'Enter a valid phone number')]),
//                     //                 decoration: InputDecoration(
//                     //                     prefixIcon: Padding(
//                     //                         padding: const EdgeInsets.only(
//                     //                             top: 14, left: 12),
//                     //                         child: Text(
//                     //                           codeController,
//                     //                           style: const TextStyle(
//                     //                               color: Colors.white,
//                     //                               fontSize: 14),
//                     //                         )),
//                     //                     enabledBorder: UnderlineInputBorder(
//                     //                       borderSide: BorderSide(
//                     //                         width: 0.6,
//                     //                         //  color: Colors.yellow
//                     //                         color: colorTheme.primaryColor,
//                     //                       ),
//                     //                     ),
//                     //                     focusedBorder: UnderlineInputBorder(
//                     //                         borderSide: BorderSide(
//                     //                             color: colorTheme.primaryColor)),
//                     //                     focusedErrorBorder:
//                     //                     const UnderlineInputBorder(
//                     //                       borderSide: BorderSide(color: Colors.red),
//                     //                     ),
//                     //                     hintText: 'Phone',
//                     //                     hintStyle: TextStyle(
//                     //                       // color: Color.fromARGB(255, 161, 161, 161),
//                     //                         color: Colors.white.withOpacity(0.4),
//                     //                         fontSize: 12))),
//                     //           ),
//                     //         ],
//                     //       ));
//                     // }),

//                     // Container(
//                     //   padding: const EdgeInsets.only(bottom: 8),
//                     //   child: Row(
//                     //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     //     children: [
//                     //       const Text(
//                     //         "This is my Whatsapp Number",
//                     //         style: TextStyle(
//                     //           color: Color.fromARGB(255, 161, 161, 161),
//                     //         ),
//                     //       ),
//                     //
//                     //       Consumer(builder: (context, ref, _){
//                     //         final wController = ref.watch(whatsAppToggleValueProvider);
//                     //         return Switch(value: wController, onChanged: (value){
//                     //           ref.read(whatsAppToggleValueProvider.notifier).state = value;
//                     //         });
//                     //
//                     //         // return AnimatedToggleSwitch<int>.rolling(
//                     //         //   indicatorColor: colorTheme.primaryColor,
//                     //         //   borderColor: colorTheme.primaryColor,
//                     //         //   borderWidth: 1.0,
//                     //         //   indicatorSize: const Size(20, double.infinity),
//                     //         //   height: 22,
//                     //         //   current: wController,
//                     //         //   values: const [1, 0],
//                     //         //   onChanged: (i) async {
//                     //         //     print(i);
//                     //         //     ref.read(whatsAppToggleValueProvider.notifier).state = i;
//                     //         //     // setState(() {
//                     //         //     //   value = i;
//                     //         //     //   toggleButton = value;
//                     //         //     // });
//                     //         //   },
//                     //         // );
//                     //
//                     //
//                     //       })
//                     //
//                     //
//                     //     ],
//                     //   ),
//                     // ),

//                     // const SizedBox(height: 30,),

//                     //     toggleButton == 1
//                     //         ? Container(
//                     //       padding: const EdgeInsets.only(bottom: 26),
//                     //       child: Row(
//                     //         children: [
//                     //           CountryPickerDropdown(
//                     //             onValuePicked: (value) {},
//                     //             initialValue: 'US',
//                     //           ),
//                     //           Expanded(
//                     //             child: TextFormField(
//                     //                 keyboardType: TextInputType.number,
//                     //                 style:
//                     //                 TextStyle(color: colorTheme.primaryColor),
//                     //                 controller: _whatsappTextController,
//                     //                 focusNode: _focusWhatsappPhone,
//                     //                 validator: (value) =>
//                     //                     Validator.validatePhoneNumber(
//                     //                       phoneNumber: value,
//                     //                     ),
//                     //                 decoration:
//                     //                 inputDecorations("Whatsapp number")),
//                     //           ),
//                     //         ],
//                     //       ),
//                     //     )
//                     //         : const Padding(
//                     //       padding: EdgeInsets.only(bottom: 16),
//                     //     ),
//                     //   ],
//                     // ),

//                     //-----------------------------------------Home city-----------------------------------------
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Which country are you from ? *",
//                           style: TextStyle(
//                               color: colorTheme.primaryColor, height: 0.4),
//                         ),

//                         Consumer(builder: (context, ref, _) {
//                           final countryController =
//                               ref.watch(countryListProvider);

//                           return countryController.when(data: (data) {
//                             return DropdownSearch<CountryData>(
//                               // asyncItems: (String filter) async => await ref.read(authServiceProvider).getCountries(),
//                               itemAsString: (CountryData city) => city.name,
//                               filterFn: (CountryData country, String search) {
//                                 return country.name
//                                     .toLowerCase()
//                                     .contains(search.trim().toLowerCase());
//                               },
//                               items: data,
//                               validator: (country) {
//                                 if (country == null) {
//                                   return requiredText;
//                                 }
//                                 return null;
//                               },
//                               // dropdownButtonProps: DropdownButtonProps(
//                               //   style: ButtonStyle(
//                               //     side: MaterialStateProperty.resolveWith((states) => const BorderSide(width: 0.6, color: Colors.red)),
//                               //     shape: MaterialStateProperty.resolveWith<OutlinedBorder>((states) => RoundedRectangleBorder(side: BorderSide(color: Colors.red)))
//                               //   )
//                               // ),
//                               dropdownDecoratorProps: DropDownDecoratorProps(
//                                   dropdownSearchDecoration: InputDecoration(
//                                       hintText: 'Select Country',
//                                       hintStyle: TextStyle(
//                                           color: Colors.white.withOpacity(0.4),
//                                           fontSize: 12))),
//                               popupProps: const PopupProps.menu(
//                                   showSearchBox: true,
//                                   interceptCallBacks: true,
//                                   isFilterOnline: true,
//                                   searchFieldProps: TextFieldProps(
//                                       decoration:
//                                           InputDecoration(hintText: 'Search'))),
//                               onChanged: (value) {
//                                 if (value != null) {
//                                   ref.read(countryIdProvider.notifier).state =
//                                       value.id;
//                                 }
//                               },
//                             );
//                           }, error: (error, stack) {
//                             return const Text("Error in loading country");
//                           }, loading: () {
//                             return const Center(
//                                 child: CircularProgressIndicator());
//                           });
//                         }),

//                         // Consumer(builder: (context, ref, _){
//                         //   final countryController = ref.watch(countryListProvider);
//                         //   return countryController.when(
//                         //       data: (data){
//                         //         return DropDownTextField(
//                         //             clearOption: false,
//                         //             enableSearch: true,
//                         //             controller: _countryTextController,
//                         //             onChanged: (value){
//                         //               ref.read(countryIdProvider.notifier).state = value.value;
//                         //             },
//                         //             clearIconProperty:
//                         //             IconProperty(color: colorTheme.primaryColor),
//                         //             dropDownIconProperty:
//                         //             IconProperty(color: colorTheme.primaryColor),
//                         //             searchDecoration: const InputDecoration(
//                         //               hintText: "Search country",
//                         //             ),
//                         //             validator: RequiredValidator(errorText: 'This field is mandatory'),
//                         //             dropDownItemCount: 6,
//                         //             textStyle: const TextStyle(color: Colors.white),
//                         //             textFieldDecoration: InputDecoration(
//                         //               hintText: 'Select country',
//                         //               hintStyle: TextStyle(
//                         //                   color: Colors.white.withOpacity(0.4),
//                         //                   fontSize: 12),
//                         //               enabledBorder: UnderlineInputBorder(
//                         //                 borderSide: BorderSide(
//                         //                   width: 0.6,
//                         //                   //  color: Colors.yellow
//                         //                   color: colorTheme.primaryColor,
//                         //                 ),
//                         //               ),
//                         //             ),
//                         //           dropDownList: data.map((e) => DropDownValueModel(name: e.name, value: e.id)).toList(),
//                         //         );
//                         //       },
//                         //       error: (error, stack) => Text(error.toString()),
//                         //       loading: () => const Text('Country Loading...'));
//                         // }),

//                         //City Selection
//                         Consumer(builder: (context, ref, _) {
//                           // final cityController = ref.watch(cityListProvider);
//                           final countryId = ref.watch(countryIdProvider);

//                           // if(cityController.isEmpty){
//                           //   return const SizedBox.shrink();
//                           // }

//                           if (countryId == null) {
//                             return const SizedBox.shrink();
//                           }

//                           return DropdownSearch<CityData>(
//                             asyncItems: (String filter) async => await ref
//                                 .read(authServiceProvider)
//                                 .getCities(countryId, name: filter),
//                             itemAsString: (CityData city) => city.name,
//                             validator: (city) {
//                               if (cityData == null) {
//                                 return requiredText;
//                               }
//                               return null;
//                             },
//                             dropdownDecoratorProps: DropDownDecoratorProps(
//                                 dropdownSearchDecoration: InputDecoration(
//                                     hintText: 'Select city',
//                                     hintStyle: TextStyle(
//                                         color: Colors.white.withOpacity(0.4),
//                                         fontSize: 12))),
//                             popupProps: const PopupProps.menu(
//                                 showSearchBox: true,
//                                 interceptCallBacks: true,
//                                 isFilterOnline: true,
//                                 searchFieldProps: TextFieldProps(
//                                     decoration:
//                                         InputDecoration(hintText: 'Search'))),
//                             onChanged: (city) {
//                               cityData = city;
//                             },
//                           );

//                           // return DropDownTextField(
//                           //   clearOption: false,
//                           //   enableSearch: true,
//                           //   controller: _cityTextController,
//                           //   onChanged: (value){
//                           //
//                           //   },
//                           //   clearIconProperty:
//                           //   IconProperty(color: colorTheme.primaryColor),
//                           //   dropDownIconProperty:
//                           //   IconProperty(color: colorTheme.primaryColor),
//                           //   searchDecoration: const InputDecoration(
//                           //     hintText: "Search city",
//                           //   ),
//                           //   validator: RequiredValidator(errorText: 'This field is mandatory'),
//                           //   dropDownItemCount: 6,
//                           //   textStyle: const TextStyle(color: Colors.white),
//                           //   textFieldDecoration: InputDecoration(
//                           //     hintText: 'Select city',
//                           //     hintStyle: TextStyle(
//                           //         color: Colors.white.withOpacity(0.4),
//                           //         fontSize: 12),
//                           //     enabledBorder: UnderlineInputBorder(
//                           //       borderSide: BorderSide(
//                           //         width: 0.6,
//                           //         //  color: Colors.yellow
//                           //         color: colorTheme.primaryColor,
//                           //       ),
//                           //     ),
//                           //   ),
//                           //   dropDownList: cityController.map((e) => DropDownValueModel(name: e.name, value: e.id)).toList(),
//                           // );

//                           // return cityController.when(
//                           //     data: (data){
//                           //
//                           //     },
//                           //     error: (error, stack) => Text(error.toString()),
//                           //     loading: () => const Text('City Loading...'));
//                         })
//                       ],
//                     ),

//                     const SizedBox(
//                       height: 30,
//                     ),

//                     if (email ==
//                         null) //Email not null indicates that it is a social reg
//                       _CustomTextField(
//                           controller: _passwordTextController,
//                           focusNode: _focusPassword,
//                           obscureText: true,
//                           labelText: 'Password *',
//                           validator: (String? val) {
//                             if (val == null || val.isEmpty) {
//                               return requiredText;
//                             }

//                             if (val.length < 6) {
//                               return 'Password too short';
//                             }

//                             if (val.trim().isEmpty) {
//                               return 'Enter a valid password';
//                             }

//                             return null;
//                           },
//                           hintText: 'Password'),

//                     if (email ==
//                         null) //Email not null indicates that it is a social reg
//                       _CustomTextField(
//                           controller: _confirmPasswordTextController,
//                           // focusNode: _focusPassword,
//                           obscureText: true,
//                           labelText: 'Confirm Password *',
//                           validator: (val) {
//                             if (val == null || val.isEmpty) {
//                               return 'This field is mandatory';
//                             }
//                             if (val != _passwordTextController.text) {
//                               return 'Password does not match';
//                             }
//                             return null;
//                           },
//                           hintText: 'Confirm Password'),

//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 22.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Gender *",
//                             style: TextStyle(color: colorTheme.primaryColor),
//                           ),
//                           Consumer(
//                             builder: (context, ref, _) {
//                               final selection = ref.watch(genderProvider);
//                               return Column(
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: <Widget>[
//                                       // Expanded(child: RadioTile(value: 'Male', groupValue: 'Male', onChanged: (val){})),
//                                       _addRadioButton('Male', selection, ref),
//                                       _addRadioButton('Female', selection, ref),
//                                       _addRadioButton(
//                                           'Non-Binary', selection, ref),
//                                     ],
//                                   ),
//                                 ],
//                               );
//                             },
//                           ),
//                         ],
//                       ),
//                     ),

//                     Consumer(builder: (context, ref, _) {
//                       final smokeController =
//                           ref.watch(smokePreferenceProvider);
//                       return Padding(
//                         padding: const EdgeInsets.only(bottom: 22.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text('Do you smoke ? *'),
//                             Row(
//                               children: [
//                                 RadioTile(
//                                     value: true,
//                                     groupValue: smokeController,
//                                     onChanged: (val) {
//                                       ref
//                                           .read(
//                                               smokePreferenceProvider.notifier)
//                                           .state = val;
//                                     },
//                                     title: 'Yes'),
//                                 RadioTile(
//                                     value: false,
//                                     groupValue: smokeController,
//                                     onChanged: (val) {
//                                       ref
//                                           .read(
//                                               smokePreferenceProvider.notifier)
//                                           .state = val;
//                                     },
//                                     title: 'No'),
//                               ],
//                             ),
//                           ],
//                         ),
//                       );
//                     }),

//                     Consumer(builder: (context, ref, _) {
//                       final drinkController =
//                           ref.watch(drinkPreferenceProvider);
//                       return Padding(
//                         padding: const EdgeInsets.only(bottom: 32.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text('Do you drink alcohol ? *'),
//                             Row(
//                               children: [
//                                 RadioTile(
//                                     value: true,
//                                     groupValue: drinkController,
//                                     onChanged: (val) {
//                                       ref
//                                           .read(
//                                               drinkPreferenceProvider.notifier)
//                                           .state = val;
//                                     },
//                                     title: 'Yes'),
//                                 RadioTile(
//                                     value: false,
//                                     groupValue: drinkController,
//                                     onChanged: (val) {
//                                       ref
//                                           .read(
//                                               drinkPreferenceProvider.notifier)
//                                           .state = val;
//                                     },
//                                     title: 'No'),
//                               ],
//                             ),
//                           ],
//                         ),
//                       );
//                     }),

//                     //-----------------------------------DOB----------------------------------------

//                     _CustomTextField(
//                         onTap: () async {
//                           pickedData = await showDatePicker(
//                               initialDatePickerMode: DatePickerMode.year,
//                               context: context,
//                               initialDate: DateTime.now()
//                                   .subtract(const Duration(days: 365 * 21)),
//                               firstDate: DateTime(1950),
//                               lastDate: DateTime.now()
//                                   .subtract(const Duration(days: 365 * 21)));
//                           if (pickedData != null) {
//                             _birthTextController.text =
//                                 DateFormat('MM/dd/yyyy').format(pickedData!);
//                           }
//                         },
//                         readOnly: true,
//                         controller: _birthTextController,
//                         focusNode: _focusBirth,
//                         validator: RequiredValidator(errorText: requiredText),
//                         labelText: 'Date of Birth *',
//                         hintText: 'MM/DD/YYYY'),

//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         Consumer(builder: (context, ref, _) {
//                           final tcController =
//                               ref.watch(termsAndConditionProvider);
//                           return Checkbox(
//                             value: tcController,
//                             onChanged: ((value) {
//                               // setState(() {
//                               //   _agreeTandC = value ?? false;
//                               // });
//                               if (value == true) {
//                                 showDialog(
//                                     context: context,
//                                     builder: (context) {
//                                       return DialogBox.signupDialog(
//                                           context, ref);
//                                     });
//                               } else {
//                                 ref
//                                     .read(termsAndConditionProvider.notifier)
//                                     .state = false;
//                               }
//                             }),
//                             activeColor: colorTheme.primaryColor,
//                             checkColor: colorTheme.backgroundColor,
//                             side: BorderSide(
//                                 color: colorTheme.primaryColor, width: 1.6),
//                           );
//                         }),
//                         Expanded(
//                           child: Padding(
//                             padding: const EdgeInsets.only(bottom: 4),
//                             child: RichText(
//                                 softWrap: true,
//                                 text: TextSpan(
//                                     text:
//                                         "I confirm that my age is 21 years & above ",
//                                     style: TextStyle(
//                                       fontSize: 13,
//                                       color: colorTheme.primaryColor,
//                                     ),
//                                     children: [
//                                       TextSpan(
//                                           text:
//                                               "I agree to the terms and conditions",
//                                           recognizer: TapGestureRecognizer()
//                                             ..onTap = () {
//                                               launchUrl(Uri.parse(
//                                                   'https://party.one/terms-and-conditions/'));
//                                             },
//                                           style: const TextStyle(
//                                               decoration:
//                                                   TextDecoration.underline))
//                                     ])),
//                           ),
//                         ),
//                       ],
//                     ),

//                     Consumer(builder: (context, ref, _) {
//                       final controller = ref.watch(signupProvider);

//                       if (controller is SignupLoading) {
//                         return const Center(
//                           child: CircularProgressIndicator(),
//                         );
//                       }

//                       return Container(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 8, vertical: 12),
//                         margin: const EdgeInsets.only(top: 6),
//                         child: Center(
//                           child: RoundedGoldenButton(
//                             onTap: () async {
//                               if (_formKeySignup.currentState?.validate() ??
//                                   false) {
//                                 final tAndCController = ref
//                                     .read(termsAndConditionProvider.notifier)
//                                     .state;
//                                 if (!tAndCController) {
//                                   showDialog(
//                                       context: context,
//                                       builder: (context) {
//                                         return DialogBox.signupDialog(
//                                             context, ref);
//                                       });
//                                   return;
//                                 }

//                                 if (ref.read(genderProvider.notifier).state ==
//                                     null) {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                       const SnackBar(
//                                           content: Text('Select gender')));
//                                   return;
//                                 }

//                                 final smokePrefs = ref
//                                     .read(smokePreferenceProvider.notifier)
//                                     .state;
//                                 final drinkPrefs = ref
//                                     .read(drinkPreferenceProvider.notifier)
//                                     .state;

//                                 if (smokePrefs == null) {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                       const SnackBar(
//                                           content: Text(
//                                               'Select your smoke preference')));
//                                   return;
//                                 }

//                                 if (drinkPrefs == null) {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                       const SnackBar(
//                                           content: Text(
//                                               'Select your drink preference')));
//                                   return;
//                                 }

//                                 final whatsAppNumber =
//                                     '${(ref.read(countryCodeProviderWA))}${_whatsappTextController.text}';
//                                 final data = SignupData(
//                                   id: '',
//                                   name: _nameTextController.text,
//                                   gender:
//                                       ref.read(genderProvider.notifier).state!,
//                                   cityName: cityData?.name ?? '',
//                                   city: cityData?.id.toString() ?? '',
//                                   countryId:
//                                       cityData?.countryId.toString() ?? '',
//                                   countryName: cityData?.countryName ?? '',
//                                   dob: DateFormat('dd-MM-yyyy')
//                                       .format(pickedData!),
//                                   email: _emailTextController.text,
//                                   password: _passwordTextController.text,
//                                   drinkPreference: drinkPrefs,
//                                   smokePreference: smokePrefs,
//                                   profileImage: null,
//                                   contacts: [
//                                     if (whatsAppNumber != mobile)
//                                       Contact(
//                                           contactNo: mobile,
//                                           isWhatsapp: isWhatsAppNumber,
//                                           isActive: true),
//                                     if (!isWhatsAppNumber)
//                                       Contact(
//                                           contactNo: whatsAppNumber,
//                                           isWhatsapp: true,
//                                           isActive: true)
//                                   ],
//                                 );

//                                 if (isSocialReg) {
//                                   ref
//                                       .read(signupProvider.notifier)
//                                       .updateData(data);
//                                 } else {
//                                   ref
//                                       .read(signupProvider.notifier)
//                                       .emailSignup(data);
//                                 }
//                               }
//                             },
//                             text: "SIGN UP",
//                             // textStyle: TextStyle(
//                             //     fontWeight: FontWeight.w700,
//                             //     // fontSize: 18,
//                             //     color: colorTheme.backgroundColor),
//                           ),
//                         ),
//                       );
//                     }),

//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 56),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             "Already have an account ? ",
//                             style: TextStyle(
//                                 color: colorTheme.primaryColor, fontSize: 16),
//                           ),
//                           TextButton(
//                               onPressed: () {
//                                 final user = ref
//                                     .read(firebaseAuthServiceProvider)
//                                     .geCurrentUser();
//                                 if (user == null) {
//                                   // Navigator.maybePop(context);
//                                   // ref.read(authProvider.notifier).checkUser();
//                                   Navigator.popUntil(
//                                       context, (route) => route.isFirst);
//                                 } else {
//                                   ref.read(authProvider.notifier).logOut();
//                                   // Navigator.push(
//                                   //     context,
//                                   //     MaterialPageRoute(
//                                   //         builder: (context) => LoginPage()));
//                                 }
//                               },
//                               child: const Text(
//                                 "Sign In",
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.w300,
//                                     color: Colors.yellow,
//                                     fontSize: 16),
//                               ))
//                         ],
//                       ),
//                     ),

//                     //-------------------
//                   ],
//                 )
//               ])),
//         ),
//       ),
//     );
//   }
// }

// class _CustomTextField extends StatelessWidget {
//   final TextEditingController controller;
//   final FocusNode? focusNode;
//   final String? Function(String?)? validator;
//   final String labelText;
//   final String hintText;
//   final bool obscureText;
//   final void Function()? onTap;
//   final bool readOnly;
//   const _CustomTextField({
//     Key? key,
//     required this.controller,
//     this.focusNode,
//     this.validator,
//     required this.labelText,
//     this.obscureText = false,
//     required this.hintText,
//     this.onTap,
//     this.readOnly = false,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           labelText,
//           style: const TextStyle(color: Colors.white, height: 0.4),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(bottom: 32.0),
//           child: TextFormField(
//               style: const TextStyle(color: Colors.white),
//               controller: controller,
//               focusNode: focusNode,
//               validator: validator,
//               obscureText: obscureText,
//               onTap: onTap,
//               readOnly: readOnly,
//               decoration: InputDecoration(
//                 enabledBorder: const UnderlineInputBorder(
//                   borderSide: BorderSide(
//                     width: 0.6,
//                     //  color: Colors.yellow
//                     color: Colors.white60,
//                   ),
//                 ),
//                 focusedBorder: const UnderlineInputBorder(
//                     borderSide: BorderSide(color: Colors.white)),
//                 focusedErrorBorder: const UnderlineInputBorder(
//                   borderSide: BorderSide(color: Colors.red),
//                 ),
//                 hintText: hintText,

//                 hintStyle: TextStyle(
//                     // color: Color.fromARGB(255, 161, 161, 161),
//                     color: Colors.white.withOpacity(0.4),
//                     fontSize: 12),
//                 // hoverColor: const Color.fromARGB(255, 71, 71, 71),
//               )),
//         ),
//       ],
//     );
//   }
// }
