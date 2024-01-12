import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../authentication/controllers/locations_controller.dart';
import '../../authentication/controllers/signup_controller.dart';
import '../../authentication/data/models/city_list.dart';
import '../../authentication/data/models/country_list.dart';
import '../../authentication/data/service/auth_service.dart';
import '../../htp_theme.dart';
import 'needles_widget.dart';

class CustomDropDownSearch extends ConsumerStatefulWidget {
  const CustomDropDownSearch({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomDropDownSearchState();
}

class _CustomDropDownSearchState extends ConsumerState<CustomDropDownSearch> {
  final requiredText = '*This field is required';

  FocusNode _node = FocusNode();
  FocusNode _subNode = FocusNode();

  CityData? cityData;

  // activateField(bool textField) {
  //   setState(() {
  //     textField = true;
  //   });
  // }

  // deactivateField(bool textField) {
  //   setState(() {
  //     textField = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final countryController = ref.watch(countryListProvider);
    final countryId = ref.watch(countryIdProvider);

    return Column(
      children: [
        //-------------------------------county name search ----------------------------
        countryController.when(data: (data) {
          return DropdownSearch<CountryData>(
            itemAsString: (CountryData city) => city.name,
            filterFn: (CountryData country, String search) {
              return country.name
                  .toLowerCase()
                  .contains(search.trim().toLowerCase());
            },
            items: data,
            validator: (country) {
              if (country == null) {
                return requiredText;
              }
              return null;
            },
            dropdownDecoratorProps: const DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
              hintText: 'New York',
              hintStyle: man14LightGrey,
              border: InputBorder.none,
            )),
            popupProps: const PopupProps.menu(
                showSearchBox: true,
                interceptCallBacks: true,
                // isFilterOnline: true,
                searchFieldProps: TextFieldProps(
                    decoration: InputDecoration(hintText: 'Search'))),
            onChanged: (value) {
              if (value != null) {
                ref.read(countryIdProvider.notifier).state = value.id;
              }
            },
          );
        }, error: (Object error, StackTrace stackTrace) {
          return const Text("Error in loading ");
        }, loading: () {
          return const Center(child: const CircularProgressIndicator(color: HtpTheme.goldenColor),);
        }),

        const NeedleDoubleSided(
          fullWidth: false,
        ),

        Builder(builder: (BuildContext context) {
          if (countryId == null) {
            return const SizedBox.shrink();
          }

          return DropdownSearch<CityData>(
            asyncItems: (String filter) async => await ref
                .read(authServiceProvider)
                .getCities(countryId, name: filter),
            itemAsString: (CityData city) => city.name,
            validator: (city) {
              if (cityData == null) {
                return requiredText;
              }
              return null;
            },
            dropdownDecoratorProps: const DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
              hintText: 'Select city',
              hintStyle: man14LightGrey,
              border: InputBorder.none,
            )),
            popupProps: const PopupProps.menu(
                showSearchBox: true,
                interceptCallBacks: true,
                isFilterOnline: true,
                searchFieldProps: TextFieldProps(
                    decoration: InputDecoration(hintText: 'Search'))),
            onChanged: (city) {
              cityData = city;
            },
          );
        }),

        if (countryId != null)
          const NeedleDoubleSided(
            fullWidth: false,
          ),
      ],
    );
  }
}
