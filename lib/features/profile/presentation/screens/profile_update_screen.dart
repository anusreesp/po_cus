import 'package:change_case/change_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:htp_customer/authentication/controllers/locations_controller.dart';
import 'package:htp_customer/authentication/data/models/city_list.dart';
import 'package:htp_customer/authentication/data/models/country_list.dart';
import 'package:htp_customer/authentication/data/models/state_list.dart';
import 'package:htp_customer/authentication/data/service/auth_service.dart';
import 'package:htp_customer/common/form_validator.dart';
import 'package:htp_customer/common/widgets_common/app_bar_back_button.dart';
import 'package:htp_customer/common/widgets_common/floatingSubmitButton.dart';
import 'package:htp_customer/common/widgets_common/text_field_electra.dart';
import 'package:htp_customer/features/idverification/presentation/pages/selfie/selfie_capture.dart';
import 'package:htp_customer/features/profile/controller/profile_controller.dart';
import 'package:htp_customer/features/profile/data/models/profile_response.dart';
import 'package:htp_customer/features/profile/presentation/widgets/radiobutton.dart';
import 'package:htp_customer/htp_theme.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

import '../../../membership/controller/membership_form_controller.dart';
import '../../controller/profile_update_controller.dart';

class UpdateProfileScreen extends ConsumerWidget {
  static const route = "profile-update";

  UpdateProfileScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  String? countryName;
  String? gender;
  int? countryId;
  int? stateId;
  var fileImg;
  bool countryStatus = false;
  final requiredText = '*This field is required';
  final TextEditingController name = TextEditingController();
  final TextEditingController mobile = TextEditingController();
  final TextEditingController country = TextEditingController();
  final TextEditingController state = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController dob = TextEditingController();
  final TextEditingController club1 = TextEditingController();
  final TextEditingController club2 = TextEditingController();
  final TextEditingController club3 = TextEditingController();
  final TextEditingController instagram = TextEditingController();
  final TextEditingController twitter = TextEditingController();
  final TextEditingController facebook = TextEditingController();
  CityData? _selectedCity;
  CountryData? _selectedCountry;
  StateData? _selectedState;

  int? _lastCityId;
  int? _lastCountryId;
  int? _lastStateId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countryStatus = ref.watch(isChooseCountry);
    final isSelectedState = ref.watch(isChooseState);
    final cityStatus = ref.watch(isChooseCity);
    final selectedCountryId = ref.watch(homeCountryID);
    ref.listen(profileUpdatedProvider, (previous, next) {
      if (next is ProfileUpdatedInitial) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Profile Updation Successful.')));
        Navigator.of(context).pop();
        ref.invalidate(profileControllerProvider);
      }
      if (next is ProfileUpdateError) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Profile Updation Failed.')));
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text("UPDATE PROFILE"),
        leading: const AppbarBackButton(),
      ),
      floatingActionButton: Consumer(
        builder: (context, ref, _) {
          final profileController = ref.watch(profileUpdatedProvider);

          return profileController is ProfileUpdateLoading
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const CircularProgressIndicator(
                          color: HtpTheme.goldenColor),
                    ],
                  ),
                )
              : FloatingSubmitButton(
                  text: "Done",
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      debugPrint(country.text);
                      await ref
                          .read(profileUpdatedProvider.notifier)
                          .updateProfile(UserEditModel(
                            name: name.text,
                            socialHandle: SocialHandle(
                              facebook: facebook.text,
                              instagram: instagram.text,
                              twitter: twitter.text,
                            ),
                            // dob: dob.text,
                            favClub: club1.text != "" &&
                                    club3.text != "" &&
                                    club3.text != ""
                                ? [club1.text, club2.text, club3.text]
                                : ["", "", ""],
                            drivingHabit: ref.read(driveProvider),
                            clubbing: ref.read(clubbingProvider) == "1"
                                ? "Mostly Daily"
                                : ref.read(clubbingProvider) == "2"
                                    ? "Once in a week"
                                    : "Occasionally",
                            // countryID: _selectedCountry?.id,
                            countryID: _lastCountryId ?? countryId ?? 0,
                            countryName: _selectedCountry?.name ?? country.text,
                            // cityID: _selectedCity?.stateId,
                            stateName: _selectedState?.name ?? state.text,
                            stateId: _lastStateId ?? stateId ?? 0,
                            gender: gender,
                            cityID: _lastCityId,
                            cityName: _selectedCity?.name ?? city.text,
                          ));
                    }
                  },
                );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Consumer(builder: (context, ref, _) {
              final profileController = ref.watch(profileControllerProvider);
              if (profileController is ProfileLoaded) {
                _lastCityId = profileController.profileData.homeCity;
                // _lastCountryId = profileController.profileData.homeCountry;

                final String dobRes = profileController.profileData.dob ?? "";
                debugPrint("----------$dobRes");
                final dateFormat = DateFormat("dd MMM yyyy");
                final inputFormat = DateFormat('dd-MM-yyyy');
                final date = inputFormat.parse(dobRes);
                final formattedDate = dateFormat.format(date);
                name.text = profileController.profileData.name;
                dob.text = formattedDate;
                instagram.text =
                    profileController.userEditModel.socialHandle?.instagram ??
                        "";
                facebook.text =
                    profileController.userEditModel.socialHandle?.facebook ??
                        "";
                twitter.text =
                    profileController.userEditModel.socialHandle?.twitter ?? "";
                club1.text = profileController.userEditModel.favClub.isNotEmpty
                    ? profileController.userEditModel.favClub[0]
                    : "";
                club2.text = profileController.userEditModel.favClub.isNotEmpty
                    ? profileController.userEditModel.favClub[1]
                    : "";
                club3.text = profileController.userEditModel.favClub.isNotEmpty
                    ? profileController.userEditModel.favClub[2]
                    : "";
                country.text = profileController.userEditModel.countryName
                        ?.toTitleCase() ??
                    "";
                state.text =
                    profileController.userEditModel.stateName?.toTitleCase() ??
                        "";
                city.text =
                    profileController.userEditModel.cityName?.toTitleCase() ??
                        "";
                countryId = profileController.userEditModel.countryID ?? 0;
                stateId = profileController.userEditModel.stateId ?? 0;
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  if (profileController.userEditModel.clubbing ==
                      "Mostly Daily") {
                    ref.read(clubbingProvider.notifier).state = "1";
                  } else if (profileController.userEditModel.clubbing ==
                      "Once in a week") {
                    ref.read(clubbingProvider.notifier).state = "2";
                  } else if (profileController.userEditModel.clubbing ==
                      "Occasionally") {
                    ref.read(clubbingProvider.notifier).state = "3";
                  }

                  if (profileController.userEditModel.drivingHabit == true) {
                    ref.read(driveProvider.notifier).state = true;
                  } else if (profileController.userEditModel.drivingHabit ==
                      false) {
                    ref.read(driveProvider.notifier).state = false;
                  }
                  countryName =
                      profileController.userEditModel.countryName ?? "";

                  gender = profileController.userEditModel.gender ?? "";
                  debugPrint("...................................$gender");

                  ref.read(homeCountryID.notifier).state =
                      profileController.userEditModel.countryID;
                  // countryId = profileController.userEditModel.countryID;
                  print(
                      ">>>>>>>>>>${profileController.userEditModel.toJson()}");
                });
              }
              return Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  if (profileController is ProfileLoading)
                    const Center(
                      child: const CircularProgressIndicator(
                          color: HtpTheme.goldenColor),
                    ),
                  if (profileController is ProfileLoaded)
                    ProfilePicIcon(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SelfieCapture(
                                      onCapture: (XFile file) async {
                                        debugPrint("Executed");
                                        debugPrint(
                                            "PROFILE IMAGE: ${file.path.runtimeType}");
                                        fileImg = file.path;
                                        // showDialog(
                                        //     barrierDismissible: false,
                                        //     context: context, builder: (context) => const Center(child: CircularProgressIndicator(),));
                                        Navigator.pop(context);
                                        await ref
                                            .read(profileControllerProvider
                                                .notifier)
                                            .updateProfileImage(file);
                                      },
                                    )));
                      },
                      img: profileController.profileData.profileImage ?? '',
                    ),
                  const SizedBox(
                    height: 36,
                  ),
                  if (profileController is ProfileLoaded)
                    TextFieldElectra(
                        readOnly:
                            profileController.profileData.hasActiveMembership,
                        labelText: "Full Name *",
                        hintText: "Enter your full name",
                        controller: name,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp("[a-zA-z ]*"))
                        ],
                        validator: RequiredValidator(errorText: requiredText)),
                  if (profileController is ProfileLoaded)
                    countryStatus == true
                        ? Consumer(builder: (context, ref, _) {
                            final countryController =
                                ref.watch(countryListProvider);
                            print("........${ref.read(homeCountryID)}");
                            return countryController.when(data: (data) {
                              if (data.isNotEmpty) {
                                return DropdownSearchElectra<CountryData>(
                                  labelText: "Country of Residence",
                                  hintText: 'Select your Country',
                                  onChanged: (val) {
                                    _lastCountryId = val?.id;
                                    ref.read(homeCountryID.notifier).state =
                                        val?.id;
                                    _selectedCountry = val;
                                    ref.read(isChooseState.notifier).state =
                                        true;
                                    ref.read(isChooseCity.notifier).state =
                                        true;
                                  },
                                  itemAsString: (CountryData data) => data.name,
                                  filterFn:
                                      (CountryData country, String search) {
                                    return country.name
                                        .toLowerCase()
                                        .contains(search.trim().toLowerCase());
                                  },
                                  items: data,
                                );
                              } else {
                                return Expanded(
                                  child: Center(
                                    child: const CircularProgressIndicator(
                                        color: HtpTheme.goldenColor),
                                  ),
                                );
                              }
                            }, error: (error, stack) {
                              return const Center(
                                child: const CircularProgressIndicator(
                                    color: HtpTheme.goldenColor),
                              );
                            }, loading: () {
                              return const Center(
                                child: const CircularProgressIndicator(
                                    color: HtpTheme.goldenColor),
                              );
                            });
                          })
                        : TextFieldElectra(
                            labelText: "Country of Residence",
                            hintText: 'Select your Country',
                            controller: country,
                            readOnly: true,
                            onTap: () {
                              ref.read(isChooseCountry.notifier).state = true;
                            },
                          ),
                  if (profileController is ProfileLoaded)
                    Consumer(builder: (context, ref, _) {
                      return isSelectedState
                          ? DropdownSearchElectra<StateData>(
                              labelText: "State ",
                              hintText: 'Select your State',
                              padding: const EdgeInsets.only(bottom: 6),
                              itemAsString: (StateData data) => data.name,
                              asyncItem: (String filter) async {
                                final stateList = await ref
                                    .read(authServiceProvider)
                                    .getStates(
                                        _lastCountryId ?? selectedCountryId!,
                                        name: filter);
                                if (filter.isEmpty) {
                                  if (stateList.isEmpty) {
                                    return [
                                      StateData(
                                          id: _selectedCountry?.id ?? 0,
                                          name: _selectedCountry?.name ?? '',
                                          countryId: _selectedCountry?.id ?? 0,
                                          countryName:
                                              _selectedCountry?.name ?? '',
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
                                ref.read(homeStateID.notifier).state = val?.id;
                                _selectedState = val;
                                _lastStateId = val?.id ?? 0;
                              },
                            )
                          : TextFieldElectra(
                              labelText: "State",
                              hintText: "Select your State",
                              controller: state,
                              readOnly: true,
                              onTap: () {
                                ref.read(isChooseState.notifier).state = true;
                              },
                            );
                    }),
                  cityStatus == true
                      ? Consumer(builder: (context, ref, _) {
                          final selectedCountryId = ref.watch(homeCountryID);
                          final selectedStateId =
                              ref.watch(selectedStateIdProvider);
                          // if(selectedCountryId != null){
                          print(
                              ">>>>>>>>>>>>${selectedCountryId}$selectedStateId");
                          return DropdownSearchElectra<CityData>(
                            labelText: 'City',
                            hintText: 'Select your City',
                            itemAsString: (CityData data) => data.name,
                            asyncItem: (String filter) async {
                              final cityList = await ref
                                  .read(authServiceProvider)
                                  .getCitiesV3(
                                      _selectedCountry?.id ??
                                          selectedCountryId!,
                                      _selectedState?.id ??
                                          selectedStateId ??
                                          stateId!,
                                      name: filter);
                              if (filter.isEmpty) {
                                if (cityList.isEmpty) {
                                  return [
                                    CityData(
                                        id: _selectedState?.id ?? 0,
                                        name: _selectedState?.name ?? '',
                                        countryId:
                                            _selectedState?.countryId ?? 0,
                                        countryName:
                                            _selectedState?.countryName ?? '',
                                        stateName: _selectedState?.name ?? '',
                                        stateId: _selectedState?.id ?? 0)
                                  ];
                                } else {
                                  return cityList;
                                }
                              } else {
                                return cityList;
                              }
                            },
                            onChanged: (city) {
                              _lastCityId = city?.id;
                              _selectedCity = city;
                            },
                          );
                          // }
                          return const SizedBox.shrink();
                        })
                      : TextFieldElectra(
                          labelText: 'City',
                          hintText: 'Select your City',
                          controller: city,
                          readOnly: true,
                          onTap: () {
                            ref.read(isChooseCity.notifier).state = true;
                          },
                        ),
                  TextFieldElectra(
                    labelText: "Date of Birth",
                    hintText: "DOB",
                    controller: dob,
                    readOnly: true,
                  ),
                  TextFieldElectra(
                    labelText: "List your Favorite Clubs",
                    hintText: "Club 1",
                    controller: club1,
                  ),
                  TextFieldElectra(
                    hintText: "Club 2",
                    controller: club2,
                  ),
                  TextFieldElectra(
                    hintText: "Club 3",
                    controller: club3,
                  ),
                  Row(
                    children: [
                      Text(
                        "How often do you go clubbing/to a bar",
                        style: man12White,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Consumer(builder: (context, ref, _) {
                    final selection = ref.watch(clubbingProvider);
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyRadioListTile(
                            value: "1",
                            groupValue: selection,
                            onChanged: (value) {
                              ref.read(clubbingProvider.notifier).state = "1";
                            },
                            title: "Regularly"),
                        MyRadioListTile(
                            value: "2",
                            groupValue: selection,
                            onChanged: (value) {
                              ref.read(clubbingProvider.notifier).state = "2";
                            },
                            title: "Weekends Only"),
                        MyRadioListTile(
                            value: "3",
                            groupValue: selection,
                            onChanged: (value) {
                              ref.read(clubbingProvider.notifier).state = "3";
                            },
                            title: "Occasionally"),
                      ],
                    );
                  }),
                  SizedBox(
                    height: 22,
                  ),
                  Row(
                    children: [
                      Text(
                        "Do you usually drive?",
                        style: man12White,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Consumer(builder: (context, ref, _) {
                    final selection = ref.watch(driveProvider);
                    return Row(
                      children: [
                        MyRadioListTile(
                            value: true,
                            groupValue: selection,
                            onChanged: (value) {
                              ref.read(driveProvider.notifier).state = true;
                            },
                            title: "Yes"),
                        const SizedBox(
                          width: 33,
                        ),
                        MyRadioListTile(
                            value: false,
                            groupValue: selection,
                            onChanged: (value) {
                              ref.read(driveProvider.notifier).state = false;
                            },
                            title: "No")
                      ],
                    );
                  }),
                  SizedBox(
                    height: 18,
                  ),
                  Row(
                    children: [
                      Text(
                        "Add your social media handles",
                        style: tenor22White,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  TextFieldElectra(
                    hintText: "Instagram username",
                    controller: instagram,
                    contentPadding: const EdgeInsets.fromLTRB(8, 2, 8, 8),
                  ),
                  TextFieldElectra(
                    hintText: "Twitter username",
                    controller: twitter,
                    contentPadding: const EdgeInsets.fromLTRB(8, 2, 8, 8),
                  ),
                  TextFieldElectra(
                    hintText: "Facebook username",
                    controller: facebook,
                    contentPadding: const EdgeInsets.fromLTRB(8, 2, 8, 8),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}

class ProfilePicIcon extends StatelessWidget {
  final GestureTapCallback onTap;
  final String img;
  const ProfilePicIcon({Key? key, required this.onTap, required this.img})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            // height: 145,
            // width: 145,
            decoration: BoxDecoration(
                border: Border.all(width: 3, color: HtpTheme.whiteColor),
                borderRadius: BorderRadius.circular(100)),
            child: CircleAvatar(
              radius: 52,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(70),
                  child: img == '' || img == null
                      ? Image.asset(
                          "assets/images/placeholders/profile_placeholder.png")
                      : Image(
                          image: NetworkImage(
                            img,
                          ),
                          fit: BoxFit.cover,
                          height: 140,
                          width: 140,
                        )),
              backgroundImage:
                  const AssetImage('assets/images/profile-back.png'),
              // child: ClipRRect(
              //     borderRadius: BorderRadius.circular(70),
              //     child:Image.network(img,fit: BoxFit.cover,)),
            ),
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.only(left: 77.0, top: 77.0),
            child: CircleAvatar(
              radius: 15,
              child: SvgPicture.asset(
                  "assets/svg/icons/profile/changeprofileimage.svg"),
            ),
          ),
        ),
      ],
    );
  }
}
