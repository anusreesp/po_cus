import 'package:change_case/change_case.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/authentication/data/service/firebase_auth_service.dart';
import 'package:htp_customer/authentication/presentation/screens/login.dart';
import 'package:htp_customer/common/widgets_common/app_bar_back_button.dart';
import 'package:htp_customer/common/widgets_common/country_code_picker_dialog.dart';
import 'package:htp_customer/common/widgets_common/floatingSubmitButton.dart';
import 'package:htp_customer/common/widgets_common/text_field_electra.dart';
import 'package:htp_customer/htp_theme.dart';
import 'package:htp_customer/startup_page.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../common/form_validator.dart';
import '../../../../common/utils/common_links.dart';
import '../../../../common/widgets_common/radio_tile.dart';
import '../../../controllers/auth_controller.dart';
import '../../../controllers/locations_controller.dart';
import '../../../controllers/signup_controller.dart';
import '../../../controllers/signup_countrycode_controller.dart';
import '../../../data/models/city_list.dart';
import '../../../data/models/country_list.dart';
import '../../../data/models/signup_data.dart';
import '../../../data/models/state_list.dart';
import '../../../data/service/auth_service.dart';

class SignUpPage extends ConsumerWidget {
  final String? name;
  final String? email;
  final bool isWhatsAppNumber;
  final String mobile;
  final bool isSocialReg;

  SignUpPage(
      {required this.mobile,
      required this.isSocialReg,
      this.isWhatsAppNumber = false,
      super.key,
      this.name,
      this.email});

  CityData? cityData;
  CountryData? _selectedCountry;
  StateData? _selectedState;

  final _formKeySignup = GlobalKey<FormState>();
  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _whatsappTextController = TextEditingController();
  final _newPasswordTextController = TextEditingController();
  final _confirmPasswordTextController = TextEditingController();
  final _birthTextController = TextEditingController();

  final _focusName = FocusNode();
  final _focusEmail = FocusNode();
  final _focusWhatsapp = FocusNode();
  final _focusPassword = FocusNode();
  final _focusConfirmPassword = FocusNode();
  final _focusBirth = FocusNode();

  final requiredText = '*This field is required';
  DateTime? pickedData;

  Widget radioButton(String? groupValue, String title, WidgetRef ref) {
    return CustomRadioButton(
        value: title,
        groupValue: groupValue,
        onChanged: (val) {
          if (val != null) {
            ref.read(genderProvider.notifier).state = val;
          }
        },
        title: title);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _emailTextController.text = email ?? '';
    _nameTextController.text = name ?? '';

    // final countryname = ref.watch(countryNameProvider);
    // final cityname = ref.watch(cityNameProvider);

    ref.listen(signupProvider, (previous, next) {
      if (next is SignupError) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(next.msg)));
      }

      if (next is SignupSuccess) {
        if (isSocialReg) {
          ref.read(authProvider.notifier).checkUser().then((_) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => StartupPage()));
          });
        } else {
          ref.read(authProvider.notifier).checkUser();
          Navigator.popUntil(context, (route) => route.isFirst);
        }
      }
    });

    return Scaffold(
      appBar: AppBar(
        leading: AppbarBackButton(onTap: () {
          final user = ref.read(firebaseAuthServiceProvider).geCurrentUser();
          if (isSocialReg == true || user == null) {
            if (user == null) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
              return;
            } else {
              ref.read(authProvider.notifier).logOut().then((_) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => StartupPage()));
                return;
              });
            }
            // Navigator.pushReplacement(context,
            //     MaterialPageRoute(builder: (context) => LoginPage()));
          } else {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => LoginPage()));
          }
        }),
        title: Text(
          "Sign Up",
          style: tenor22White
              .merge(TextStyle(color: HtpTheme.whiteColor.withOpacity(0.7))),
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: buildBody(context))),
      bottomNavigationBar: Consumer(builder: (context, ref, _) {
        final controller = ref.watch(signupProvider);

        if (controller is SignupLoading) {
          return const Center(
            child: const CircularProgressIndicator(color: HtpTheme.goldenColor),
          );
        }

        //------------------------------  Sign Up Button  ------------------------------------
        return Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 20),
          child: FloatingSubmitButton(
              text: "Register",
              onTap: () async {
                if (_formKeySignup.currentState?.validate() ?? false) {
                  final tAndCController =
                      ref.read(termsAndConditionProvider.notifier).state;
                  if (!tAndCController) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            'Please accept the terms and conditions to proceed')));
                    return;
                  }

                  if (ref.read(genderProvider.notifier).state == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Select gender')));
                    return;
                  }

                  final whatsAppNumber =
                      '${(ref.read(signupCountryCodeProvider))}${_whatsappTextController.text}';

                  if(cityData == null){
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Select city')));
                    return;
                  }

                  final data = SignupData(
                    id: '',
                    name: _nameTextController.text.toTitleCase(),
                    gender: ref.read(genderProvider.notifier).state!,
                    cityName: cityData?.name.toLowerCase() ?? '',
                    city: cityData?.id ?? 0,
                    countryId: cityData?.countryId ?? 0,
                    countryName: cityData?.countryName.toLowerCase() ?? '',
                    homeState: cityData?.stateId,
                    homeStateName: cityData?.stateName.toLowerCase(),
                    dob: DateFormat('dd-MM-yyyy').format(pickedData!),
                    email: _emailTextController.text.toLowerCase(),
                    password: _newPasswordTextController.text,
                    // drinkPreference: drinkPrefs,
                    // smokePreference: smokePrefs,
                    profileImage: null,
                    contacts: [
                      Contact(
                          contactNo: mobile,
                          isVerified: true,
                          isActive: true,
                          mode: 'phone'),
                      isWhatsAppNumber
                          ? Contact(
                              contactNo: mobile,
                              isVerified: true,
                              isActive: true,
                              mode: 'whatsapp')
                          : Contact(
                              contactNo: whatsAppNumber,
                              isVerified: false,
                              isActive: true,
                              mode: 'whatsapp')
                    ],
                  );

                  debugPrint(
                      "-----------------------------------${data.contacts}");

                  if (isSocialReg) {
                    ref.read(signupProvider.notifier).updateData(data);
                  } else {
                    ref.read(signupProvider.notifier).emailSignup(data);
                  }
                }
              }),
        );
      }),
    );
  }

  Widget buildBody(BuildContext context) {
    return Form(
        key: _formKeySignup,
        child: Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            TextFieldElectra(
              controller: _nameTextController,
              labelText: 'Full Name *',
              hintText: 'Enter your full name',
              focus: _focusName,
              validator: MultiValidator([
                RequiredValidator(errorText: 'This field is mandatory'),
                MinLengthValidator(3, errorText: 'Name too short!'),
                NonNumberValidator(errorText: 'Numeric values are not allowed')
              ]),
              padding: const EdgeInsets.only(bottom: 4),
            ),
            TextFieldElectra(
              controller: _emailTextController,
              hintText: 'Enter an email address ',
              labelText: 'Email address *',
              focus: _focusEmail,
              validator: MultiValidator([
                RequiredValidator(errorText: requiredText),
                EmailValidator(errorText: 'Enter a valid email address')
              ]),
              padding: const EdgeInsets.only(bottom: 4),
            ),

            //--------------------------------- WhatsAppNumber -----------------------------------

            if (!isWhatsAppNumber)
              Consumer(
                builder: (context, ref, _) {
                  final codeController = ref.watch(signupCountryCodeProvider);

                  return TextFieldElectra(
                    keyboardType: TextInputType.number,
                    controller: _whatsappTextController,
                    padding: const EdgeInsets.only(bottom: 2, top: 2),
                    hintText: 'WhatsApp Number',
                    labelText: 'WhatsApp Number *',
                    focus: _focusWhatsapp,
                    prefixWidget: Padding(
                      padding: const EdgeInsets.only(bottom: 2, right: 6),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: CountryCodePickerDialog(
                                selectedCountryCode:
                                    ref.watch(selectedCountryCodeProvider),
                                onValuePicked: (val) {
                                  ref
                                      .read(signupCountryCodeProvider.notifier)
                                      .state = "+${val.phoneCode}";

                                  ref
                                      .read(
                                          selectedCountryCodeProvider.notifier)
                                      .state = val.isoCode;
                                }),
                          ),
                          Text(codeController)
                        ],
                      ),
                    ),
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'This field is mandatory'),
                      MaxLengthValidator(11,
                          errorText: 'Please enter a valid phone number')
                    ]),
                  );
                },
              ),

            // //-----------------------------------Home Country & Home City----------------------------------------

            // CountryCityDropDown(),

            Consumer(builder: (context, ref, _) {
              final countryController = ref.watch(countryListProvider);
              return countryController.when(data: (data) {
                return DropdownSearchElectra<CountryData>(
                  labelText: "Country of Residence *",
                  hintText: 'Select your Country',
                  onChanged: (val) {
                    ref.read(countryIdProvider.notifier).state = val?.id;
                    ref.read(selectedStateIdProvider.notifier).state = null;
                    cityData = null;
                    _selectedCountry = val;
                  },
                  itemAsString: (CountryData data) => data.name,
                  padding: const EdgeInsets.only(bottom: 0),
                  betweenSpace: -12,
                  filterFn: (CountryData country, String search) {
                    return country.name
                        .toLowerCase()
                        .contains(search.trim().toLowerCase());
                  },
                  items: data,
                  validator: (country) {
                    if (country == null) {
                      // return requiredText;
                      return "This field is mandatory";
                    }
                    return null;
                  },
                );
              }, error: (error, stack) {
                return const SizedBox.shrink();
              }, loading: () {
                return const SizedBox.shrink();
              });
            }),

            Consumer(builder: (context, ref, _) {
              final selectedCountryId = ref.watch(countryIdProvider);
              if (selectedCountryId != null) {
                return DropdownSearchElectra<StateData>(
                  labelText: "State *",
                  hintText: 'Select state',
                  betweenSpace: -12,
                  padding: const EdgeInsets.only(bottom: 0),
                  itemAsString: (StateData data) => data.name,
                  asyncItem: (String filter) async {
                    final stateList = await ref
                        .read(authServiceProvider)
                        .getStates(selectedCountryId, name: filter);
                    if (filter.isEmpty) {
                      if (stateList.isEmpty) {
                        return [
                          StateData(
                              id: _selectedCountry?.id ?? 0,
                              name: _selectedCountry?.name ?? '',
                              countryId: _selectedCountry?.id ?? 0,
                              countryName: _selectedCountry?.name ?? '',
                              latitude: 0,
                              longitude: 0)
                        ];
                      } else {
                        return stateList;
                      }
                    } else {
                      return stateList;
                    }
                  },
                  onChanged: (val) {
                    ref.read(selectedStateIdProvider.notifier).state = val?.id;
                    _selectedState = val;
                  },
                  validator: (state) {
                    if (state == null) {
                      // return requiredText;
                      return "This field is mandatory";
                    }
                    return null;
                  },
                );
              }

              return const SizedBox.shrink();
            }),

            Consumer(builder: (context, ref, _) {
              final selectedCountryId = ref.watch(countryIdProvider);
              final selectedStateId = ref.watch(selectedStateIdProvider);
              if (selectedCountryId != null && selectedStateId != null) {
                return DropdownSearchElectra<CityData>(
                  // labelText: 'What\'s your Home City ? *',
                  labelText: 'City *',
                  hintText: 'Select city',
                  itemAsString: (CityData data) => data.name,
                  padding: const EdgeInsets.only(bottom: 0),
                  betweenSpace: -12,
                  asyncItem: (String filter) async {
                    final cityList = await ref
                        .read(authServiceProvider)
                        .getCitiesV3(selectedCountryId, selectedStateId,
                            name: filter);
                    if (filter.isEmpty) {
                      if (cityList.isEmpty) {
                        return [
                          CityData(
                              id: _selectedState?.id ?? 0,
                              name: _selectedState?.name ?? '',
                              countryName: _selectedState?.countryName ?? '',
                              stateName: _selectedState?.name ?? '',
                              countryId: _selectedState?.countryId ?? 0,
                              stateId: _selectedState?.id ?? 0)
                        ];
                      } else {
                        return cityList;
                      }
                    } else {
                      return cityList;
                    }
                  },
                  validator: (val) {
                    if (val == null) {
                      return requiredText;
                    }
                    return null;
                  },
                  onChanged: (city) {
                    cityData = city;
                  },
                );
              }
              return const SizedBox.shrink();
            }),

            // Column(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Text(
            //       "What's your Home City ?",
            //       style: man12LightGrey,
            //     ),
            //     const CustomDropDownSearch(),
            //     const SizedBox(
            //       height: 24,
            //     ),
            //   ],
            // ),

            //-----------------------------------DOB----------------------------------------
            TextFieldElectra(
              onTap: () async {
                // pickedData = await showDatePicker(
                //   initialDatePickerMode: DatePickerMode.year,
                //   initialDate:
                //       DateTime.now().subtract(const Duration(days: 365 * 21)),
                //   firstDate: DateTime(1950),
                //   lastDate:
                //       DateTime.now().subtract(const Duration(days: 365 * 21)),
                //   context: context,
                // );

                DateTime defaultDate = DateTime.now()
                    .subtract(const Duration(days: (365 * 21) + 8));

                await showCupertinoModalPopup(
                    context: context,
                    builder: (context) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: double.infinity,
                            color: Theme.of(context).scaffoldBackgroundColor,
                            child: Align(
                              alignment: Alignment.topRight,
                              child: TextButton(onPressed: (){
                                print("Tapp");
                                Navigator.of(context).pop();
                              }, child: Text('Done', style: man14Gold,)),
                            ),
                          ),
                          SizedBox(
                            height: 240,
                            width: double.infinity,
                            child: SafeArea(
                              top: false,
                              child: CupertinoPageScaffold(
                                child: CupertinoDatePicker(
                                  mode: CupertinoDatePickerMode.date,
                                  initialDateTime: pickedData ?? defaultDate,
                                  maximumDate: defaultDate,
                                  minimumYear: 1950,
                                  onDateTimeChanged: (dateTime) {
                                    pickedData = dateTime;
                                    if (pickedData != null) {
                                      _birthTextController.text =
                                          DateFormat('dd/MM/yyyy')
                                              .format(pickedData!);
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    });

                if (_birthTextController.text.isEmpty) {
                  _birthTextController.text =
                      DateFormat('dd/MM/yyyy').format(defaultDate);

                  pickedData = defaultDate;
                }
              },
              readOnly: true,
              // calenderIon: true,
              controller: _birthTextController,
              hintText: 'DD/MM/YYYY',
              labelText: 'Date of Birth *',
              focus: _focusBirth,
              validator: RequiredValidator(errorText: requiredText),
              padding: const EdgeInsets.only(bottom: 4),
            ),

            //----------------------------------Gender---------------------------------------------
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Gender *",
                    style: man12LightGrey,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Consumer(
                    builder: (context, ref, _) {
                      final selection = ref.watch(genderProvider);
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              // Expanded(child: RadioTile(value: 'Male', groupValue: 'Male', onChanged: (val){})),
                              radioButton(selection, 'Male', ref),
                              radioButton(selection, 'Female', ref),
                              radioButton(selection, 'Rather not say', ref),

                              // _addRadioButton('Male', selection, ref),
                              // _addRadioButton('Female', selection, ref),
                              // _addRadioButton('Non-Binary', selection, ref),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.12,
                              )
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),

            //-----------------------------------Password----------------------------------------
            if (email == null)
              TextFieldElectra(
                controller: _newPasswordTextController,
                hintText: '⬤ ⬤ ⬤ ⬤ ⬤ ⬤ ⬤ ⬤',
                labelText: 'Password *',
                obscureText: true,
                focus: _focusPassword,
                validator: (String? val) {
                  if (val == null || val.isEmpty) {
                    return "Password required";
                  }

                  if (val.length < 6) {
                    return 'Password too short';
                  }

                  if (val.trim().isEmpty) {
                    return 'Enter a valid password';
                  }

                  return null;
                },
                padding: const EdgeInsets.only(bottom: 4),
              ),
            if (email == null)
              TextFieldElectra(
                controller: _confirmPasswordTextController,
                hintText: '⬤ ⬤ ⬤ ⬤ ⬤ ⬤ ⬤ ⬤',
                labelText: 'Confirm password *',
                obscureText: true,
                focus: _focusConfirmPassword,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Re-enter password';
                  }
                  if (val != _newPasswordTextController.text) {
                    return 'Password does not match';
                  }
                  return null;
                },
                padding: const EdgeInsets.only(bottom: 4),
              ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Consumer(builder: (context, ref, _) {
                  final tcController = ref.watch(termsAndConditionProvider);
                  return Transform.translate(
                    offset: const Offset(-10, 0),
                    child: Checkbox(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      value: tcController,
                      onChanged: ((value) {
                        // setState(() {
                        //   _agreeTandC = value ?? false;
                        // });
                        if (value == true) {
                          // showDialog(
                          //     context: context,
                          //     builder: (context) {
                          //       return DialogBox.signupDialog(context, ref);
                          //     });

                          ref.read(termsAndConditionProvider.notifier).state =
                              true;
                        } else {
                          ref.read(termsAndConditionProvider.notifier).state =
                              false;
                        }
                      }),
                      // fillColor:
                      //     const MaterialStatePropertyAll(HtpTheme.darkBlue1Color),
                      activeColor: HtpTheme.darkBlue1Color,
                      checkColor: HtpTheme.whiteColor,
                      side: BorderSide(color: HtpTheme.goldColor, width: 1.6),
                    ),
                  );
                }),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: RichText(
                        softWrap: true,
                        text: TextSpan(
                            text:
                                " I confirm that my age is 21 years & above. ",
                            style: man10LightBlue
                                .merge(const TextStyle(wordSpacing: 1)),
                            children: [
                              TextSpan(
                                text: "I agree to the Terms and Conditions",
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    launchUrl(Uri.parse(
                                        '${supportLink}terms-and-conditions/'));
                                  },
                                style: man10LightBlue.merge(const TextStyle(
                                    wordSpacing: 1,
                                    decoration: TextDecoration.underline,
                                    decorationThickness: 3,
                                    fontWeight: FontWeight.w700)),
                              ),
                            ])),
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 60,
            ),
          ],
        ));
  }
}
