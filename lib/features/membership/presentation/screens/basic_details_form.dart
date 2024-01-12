import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/authentication/controllers/locations_controller.dart';
import 'package:htp_customer/authentication/data/models/city_list.dart';
import 'package:htp_customer/authentication/data/models/country_list.dart';
import 'package:htp_customer/authentication/data/models/state_list.dart';
import 'package:htp_customer/common/form_validator.dart';
import 'package:htp_customer/common/utils/common_links.dart';
import 'package:htp_customer/common/widgets_common/rounded_golden_button.dart';
import 'package:htp_customer/common/widgets_common/text_field_electra.dart';
import 'package:htp_customer/htp_theme.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../authentication/data/service/auth_service.dart';
import '../../../../common/widgets_common/radio_tile.dart';
import '../../../profile/controller/profile_controller.dart';
import '../../controller/membership_form_controller.dart';
import '../../controller/membership_form_index.dart';
import '../../data/model/kyc_requested_data.dart';

class BasicDetailsForm extends ConsumerWidget {
  final KycRequestedData? oldRequest;
  BasicDetailsForm({super.key, this.oldRequest});

  final _formKey = GlobalKey<FormState>();
  final requiredText = '*This field is mandatory';

  final _nameController = TextEditingController();
  final _addressLineController = TextEditingController();
  final _pinCodeController = TextEditingController();
  final _govtIdController = TextEditingController();
  CityData? _selectedCity;
  CountryData? _selectedCountry;
  StateData? _selectedState;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const textFieldBottomPadding = 6.0;
    final profileController = ref.watch(profileControllerProvider);

    if (profileController is ProfileLoaded) {
      final userData = profileController.profileData;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _nameController.text = oldRequest?.name ?? userData.name;
        _addressLineController.text = oldRequest?.permanentAddress ?? '';
        _govtIdController.text = oldRequest?.govtIdNumber ?? '';
        _pinCodeController.text = oldRequest?.zipcode ?? '';
        ref.read(selectedHomeCountryId.notifier).state =
            oldRequest?.homeCountryId ?? userData.homeCountry;
        // ref.read(selectedStateIdProvider.notifier).state = oldRequest?.homeStateId ?? userData.homeState;
        ref.read(clubbingFrequencyProvider.notifier).state =
            oldRequest?.clubFrequency ?? 'Mostly daily';
        ref.read(selectedNationality.notifier).state = oldRequest?.nationality;

        // if(oldRequest?.homeCityId != null && oldRequest?.homeStateId != null && oldRequest?.homeCountryId != null){
        //   _selectedCity = CityData(
        //       id: oldRequest!.homeCityId,
        //       name: oldRequest?.homeCityName ?? '',
        //       countryName: oldRequest?.homeCountryName ?? '',
        //       stateName: oldRequest?.homeStateName ?? '',
        //       countryId: oldRequest!.homeCountryId,
        //       stateId: oldRequest!.homeStateId);
        // }else if(userData.homeCity != null &&
        //     userData.homeState != null &&
        //     userData.homeCountry != null) {
        //   _selectedCity = CityData(
        //       id: userData.homeCity!,
        //       name: userData.homeCityName ?? '',
        //       countryName: userData.homeCountryName ?? '',
        //       stateName: userData.homeStateName ?? '',
        //       countryId: userData.homeCountry!,
        //       stateId: userData.homeState!);
        // }
      });

      return Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 12,
                ),
                const Text(
                  'Please provide the following details and mailing address to receive your membership card.',
                  style: man14LightBlue,
                ),

                const SizedBox(
                  height: 32,
                ),

                TextFieldElectra(
                  labelText: 'Your name on the card  *',
                  hintText: 'Name',
                  controller: _nameController,
                  padding:
                      const EdgeInsets.only(bottom: textFieldBottomPadding),
                  // focus: _nameFocus,
                  validator: MultiValidator([
                    RequiredValidatorWithTrim(errorText: requiredText),
                    MinLengthValidator(3, errorText: 'Name too short'),
                    MaxLengthValidator(24,
                        errorText: 'Name too long, max 24 characters allowed'),
                    NonNumberValidator(
                        errorText: 'Numeric values are not allowed')
                  ]),
                ),

                Consumer(builder: (context, ref, _) {
                  final countryController = ref.watch(countryListProvider);
                  return countryController.when(data: (data) {
                    return DropdownSearchElectra<CountryData>(
                      labelText: 'Nationality  *',
                      hintText: oldRequest?.nationality ?? 'Nationality',
                      activeHint: oldRequest?.nationality != null,
                      padding:
                          const EdgeInsets.only(bottom: textFieldBottomPadding),
                      itemAsString: (CountryData data) => data.name,
                      filterFn: (CountryData country, String search) {
                        return country.name
                            .toLowerCase()
                            .contains(search.trim().toLowerCase());
                      },
                      items: data,
                      onChanged: (country) {
                        ref.read(selectedNationality.notifier).state =
                            country?.name;
                      },
                      validator: (country) {
                        final nationality =
                            ref.read(selectedNationality.notifier).state;
                        if (nationality == null && country == null) {
                          return requiredText;
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

                // Text('Residency', style: man12LightGrey,),
                // const SizedBox(height: 12,),
                //
                // Consumer(builder: (context, ref, _){
                //   final residencyController = ref.watch(residencyProvider);
                //   return Wrap(
                //     runSpacing: 12,
                //     crossAxisAlignment: WrapCrossAlignment.start,
                //     children: [
                //       SizedBox(
                //           width: 180,
                //           child: CustomRadioButton(value: 'Resident', groupValue: residencyController, onChanged: (val){
                //             ref.read(residencyProvider.notifier).state = val;
                //           }, title: 'Resident',)),
                //       SizedBox(
                //           width: 180,
                //           child: CustomRadioButton(value: 'Non Resident', groupValue: residencyController, onChanged: (val){
                //             ref.read(residencyProvider.notifier).state = val;
                //           }, title: 'Non-Resident',)),
                //       SizedBox(
                //           width: 180,
                //           child: CustomRadioButton(value: 'Foreign National', groupValue: residencyController, onChanged: (val){
                //             ref.read(residencyProvider.notifier).state = val;
                //           }, title: 'Foreign National',)),
                //     ],
                //   );
                // }),

                // const SizedBox(height: 24,),

                Consumer(builder: (context, ref, _) {
                  final countryController = ref.watch(countryListProvider);
                  return countryController.when(data: (data) {
                    return DropdownSearchElectra<CountryData>(
                      labelText: 'Country  *',
                      activeHint: oldRequest?.homeCountryName != null ||
                          userData.homeCountryName != null,
                      hintText: oldRequest?.homeCountryName ??
                          userData.homeCountryName ??
                          'Country',
                      padding:
                          const EdgeInsets.only(bottom: textFieldBottomPadding),
                      onChanged: (val) {
                        _selectedCountry = val;
                        ref.read(selectedHomeCountryId.notifier).state = null;
                        //Used this to refresh the state field
                        Future.delayed(const Duration(milliseconds: 100))
                            .then((value) {
                          ref.read(selectedHomeCountryId.notifier).state =
                              val?.id;
                        });

                        ref.read(showDefaultSelection.notifier).state = false;

                        _selectedCity = null;
                        ref.read(selectedStateIdProvider.notifier).state = null;
                      },
                      itemAsString: (CountryData data) => data.name,
                      filterFn: (CountryData country, String search) {
                        return country.name
                            .toLowerCase()
                            .contains(search.trim().toLowerCase());
                      },
                      items: data,
                      // validator: (country){
                      //   if(country == null){
                      //     return requiredText;
                      //   }
                      //   return null;
                      // },
                    );
                  }, error: (error, stack) {
                    return const SizedBox.shrink();
                  }, loading: () {
                    return const SizedBox.shrink();
                  });
                }),

                Consumer(builder: (context, ref, _) {
                  final selectedCountryId = ref.watch(selectedHomeCountryId);
                  // final showHint = ref.watch(showDefaultSelection);
                  if (selectedCountryId != null) {
                    return DropdownSearchElectra<StateData>(
                      labelText: 'State  *',
                      // activeHint: userData.homeStateName != null && showHint,
                      // hintText: (userData.homeStateName != null && showHint)
                      //     ? userData.homeStateName
                      //     : 'State',
                      hintText: 'State',
                      padding:
                          const EdgeInsets.only(bottom: textFieldBottomPadding),
                      itemAsString: (StateData data) => data.name,
                      asyncItem: (String filter) async {
                        final stateList = await ref
                            .read(authServiceProvider)
                            .getStates(selectedCountryId, name: filter);
                        if (filter.isEmpty) {
                          if (stateList.isEmpty) {
                            return [
                              StateData(
                                  id: _selectedCountry?.id ?? userData?.homeCountry ?? 0,
                                  name: _selectedCountry?.name ?? userData?.homeCountryName ?? '',
                                  countryId:  _selectedCountry?.id ?? userData?.homeCountry ?? 0,
                                  countryName: _selectedCountry?.name ?? userData?.homeCountryName ?? '',
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
                        ref.read(selectedStateIdProvider.notifier).state =
                            val?.id;
                        ref.read(showDefaultSelection.notifier).state = false;
                      },
                      // validator: (val){
                      //   if(val == null){
                      //     return requiredText;
                      //   }
                      //   return null;
                      // },
                    );
                  }

                  return const SizedBox.shrink();
                }),

                Consumer(builder: (context, ref, _) {
                  final selectedCountryId = ref.watch(selectedHomeCountryId);
                  final selectedStateId = ref.watch(selectedStateIdProvider);
                  // final showHint = ref.watch(showDefaultSelection);
                  if (selectedCountryId != null && selectedStateId != null) {
                    return DropdownSearchElectra<CityData>(
                      labelText: 'City  *',
                      // activeHint: userData.homeCityName != null && showHint,
                      // hintText: (userData.homeCityName != null && showHint)
                      //     ? userData.homeCityName
                      //     : 'City',
                      padding:
                          const EdgeInsets.only(bottom: textFieldBottomPadding),
                      itemAsString: (CityData data) => data.name,
                      asyncItem: (String filter) async {
                        final cityList = await ref
                            .read(authServiceProvider)
                            .getCitiesV3(selectedCountryId, selectedStateId,
                            name: filter);
                        if(filter.isEmpty){
                          if(cityList.isEmpty){
                            return [CityData(id: _selectedState?.id ?? userData.homeState ?? 0, name: _selectedState?.name ?? userData?.homeCityName ?? '', countryId: _selectedState?.countryId ?? userData.homeCountry ?? 0, countryName: _selectedState?.countryName ?? userData.homeCountryName ?? '', stateName: _selectedState?.name ?? userData.homeStateName ?? '', stateId: _selectedState?.id ?? userData.homeState ?? 0)];
                          }else{
                            return cityList;
                          }
                        }else {
                          return cityList;
                        }
                      },
                      // validator: (val){
                      //   if(val == null){
                      //     return requiredText;
                      //   }
                      //   return null;
                      // },
                      onChanged: (city) {
                        _selectedCity = city;
                      },
                    );
                  }
                  return const SizedBox.shrink();
                }),

                TextFieldElectra(
                  controller: _addressLineController,
                  labelText: 'Mailing address  *',
                  hintText: 'Address line 1',
                  padding:
                      const EdgeInsets.only(bottom: textFieldBottomPadding),
                  validator: RequiredValidatorWithTrim(errorText: requiredText),
                ),
                TextFieldElectra(
                  controller: _pinCodeController,
                  keyboardType: TextInputType.number,
                  padding:
                      const EdgeInsets.only(bottom: textFieldBottomPadding),
                  labelText: 'Zipcode  *',
                  hintText: 'Eg. 737101',
                  validator: RequiredValidatorWithTrim(errorText: requiredText),
                ),
                TextFieldElectra(
                  controller: _govtIdController,
                  labelText: 'Government ID number  *',
                  obscureText: true,
                  hintText: 'ID number',
                  padding:
                      const EdgeInsets.only(bottom: textFieldBottomPadding),
                  validator: RequiredValidatorWithTrim(errorText: requiredText),
                ),

                Text(
                  'Frequency of clubbing  *',
                  style: man12LightGrey,
                ),
                const SizedBox(
                  height: 12,
                ),
                Consumer(builder: (context, ref, _) {
                  final clubbingController =
                      ref.watch(clubbingFrequencyProvider);
                  return Wrap(
                    spacing: 16,
                    children: [
                      CustomRadioButton(
                          value: 'Regularly',
                          groupValue: clubbingController,
                          onChanged: (val) {
                            ref.read(clubbingFrequencyProvider.notifier).state =
                                val;
                          },
                          title: 'Regularly'),
                      CustomRadioButton(
                          value: 'Weekends Only',
                          groupValue: clubbingController,
                          onChanged: (val) {
                            ref.read(clubbingFrequencyProvider.notifier).state =
                                val;
                          },
                          title: 'Weekends Only'),
                      CustomRadioButton(
                          value: 'Occasionally',
                          groupValue: clubbingController,
                          onChanged: (val) {
                            ref.read(clubbingFrequencyProvider.notifier).state =
                                val;
                          },
                          title: 'Occasionally'),
                    ],
                  );
                }),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Consumer(builder: (context, ref, _) {
                      final controller = ref.watch(tAndACheck);
                      return Transform.translate(
                        offset: const Offset(-10, 0),
                        child: Checkbox(
                            activeColor: Colors.black,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            value: controller,
                            onChanged: (val) {
                              if (val != null) {
                                ref.read(tAndACheck.notifier).state = val;
                              }
                            }),
                      );
                    }),
                    Expanded(
                      child: RichText(
                          text: TextSpan(
                              style: man10LightBlue,
                              text: 'I confirm my age is 21 years & above and ',
                              children: [
                            TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    launchUrl(Uri.parse(supportLink));
                                  },
                                text: 'I agree to the terms and conditions.',
                                style: const TextStyle(
                                    color: Colors.white,
                                    decoration: TextDecoration.underline,
                                    decorationThickness: 2))
                          ])),
                    )
                  ],
                ),

                const SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.only(bottom: 24),
          child: RoundedGoldenButton(
            onTap: () {
              if (_formKey.currentState!.validate()) {
                final nationality =
                    ref.read(selectedNationality.notifier).state;
                // final residency = ref.read(residencyProvider.notifier).state;
                final tAndC = ref.read(tAndACheck.notifier).state;
                final clubFrequency =
                    ref.read(clubbingFrequencyProvider.notifier).state;

                // if(residency == null){
                //   _showError('Select your residency', context);
                //   return;
                // }

                if (clubFrequency == null) {
                  _showError('Select your club frequency', context);
                  return;
                }

                if (tAndC == false) {
                  _showError(
                      'Agree to terms and conditions to continue', context);
                  return;
                }

                if (_selectedCity == null) {
                  _showError('Select your country, state and city', context);
                  return;
                }

                ref.read(membershipFormDataProvider.notifier).saveFormData(
                    name: _nameController.text,
                    nationality: nationality!,
                    permanentAddress: _addressLineController.text,
                    city: _selectedCity!,
                    clubbingFrequency: clubFrequency,
                    govtId: _govtIdController.text,
                    pinCode: _pinCodeController.text,
                    residency: 'NA');

                FocusManager.instance.primaryFocus?.unfocus();
                ref.read(membershipFormIndexProvider.notifier).state =
                    MembershipTab.idVerification;
              }
            },
            text: 'Continue',
          ),
        ),
      );
    } else {
      return const Scaffold(
        body: Center(
          child: const CircularProgressIndicator(color: HtpTheme.goldenColor),
        ),
      );
    }
  }

  _showError(String msg, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
