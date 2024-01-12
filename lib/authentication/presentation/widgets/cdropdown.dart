// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:htp_customer/authentication/data/models/country_list.dart';
//
// import '../../../common/widgets_common/needles_widget.dart';
// import '../../../common/widgets_common/text_field_electra.dart';
// import '../../../htp_theme.dart';
// import '../../controllers/locations_controller.dart';
// import '../../controllers/signup_controller.dart';
// import '../../data/models/city_list.dart';
// import '../../data/service/auth_service.dart';
//
// class CountryCityDropDown extends ConsumerStatefulWidget {
//   const CountryCityDropDown({super.key});
//
//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() =>
//       _CountryCityDropDownState();
// }
//
// class _CountryCityDropDownState extends ConsumerState<CountryCityDropDown> {
//   final requiredText = '*This field is required';
//   CityData? cityData;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "What's your Home Country ? *",
//                 style: man12LightGrey,
//               ),
//               Consumer(builder: (context, ref, _) {
//                 final countryController = ref.watch(countryListProvider);
//
//                 return countryController.when(data: (data) {
//                   return DropdownSearchElectra<CountryData>(
//                     padding: const EdgeInsets.only(bottom: 16),
//                     // asyncItems: (String filter) async => await ref.read(authServiceProvider).getCountries(),
//                     itemAsString: (CountryData city) => city.name,
//                     filterFn: (CountryData country, String search) {
//                       return country.name
//                           .toLowerCase()
//                           .contains(search.trim().toLowerCase());
//                     },
//                     items: data,
//                     validator: (country) {
//                       if (country == null) {
//                         return requiredText;
//                       }
//                       return null;
//                     },
//
//                     hintText: 'Select Country',
//
//                     // dropdownDecoratorProps: DropDownDecoratorProps(
//                     //     dropdownSearchDecoration: InputDecoration(
//                     //         hintText: 'Select Country',
//                     //         enabledBorder: InputBorder.none,
//                     //         hintStyle: TextStyle(
//                     //             color: Colors.white.withOpacity(0.4),
//                     //             fontSize: 12))),
//                     // popupProps: const PopupProps.menu(
//                     //     showSearchBox: true,
//                     //     interceptCallBacks: true,
//                     //     isFilterOnline: true,
//                     //     searchFieldProps: TextFieldProps(
//                     //         decoration: InputDecoration(hintText: 'Search'))
//
//                     // ),
//                     onChanged: (value) {
//                       if (value != null) {
//                         ref.read(countryIdProvider.notifier).state = value.id;
//                       }
//                     },
//                   );
//                 }, error: (error, stack) {
//                   return const Text("Error in loading country");
//                 }, loading: () {
//                   return const Center(child: CircularProgressIndicator());
//                 });
//               }),
//             ]),
//
//         //City Selection
//
//         Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "What's your Home City ?*",
//                 style: man12LightGrey,
//               ),
//               Consumer(builder: (context, ref, _) {
//                 // final cityController = ref.watch(cityListProvider);
//                 final countryId = ref.watch(countryIdProvider);
//
//                 // if(cityController.isEmpty){
//                 //   return const SizedBox.shrink();
//                 // }
//
//                 // if (countryId == null) {
//                 //   return const SizedBox.shrink();
//                 // }
//
//                 return DropdownSearchElectra<CityData>(
//                   padding: const EdgeInsets.only(bottom: 16),
//                   asyncItem: (String filter) async => await ref
//                       .read(authServiceProvider)
//                       .getCities(countryId!, name: filter),
//                   itemAsString: (CityData city) => city.name,
//                   validator: (city) {
//                     if (cityData == null) {
//                       return requiredText;
//                     }
//                     return null;
//                   },
//                   // dropdownDecoratorProps: DropDownDecoratorProps(
//                   //     dropdownSearchDecoration: InputDecoration(
//                   hintText: 'Select city',
//                   // enabledBorder: InputBorder.none,
//                   // hintStyle: TextStyle(
//                   //     color: Colors.white.withOpacity(0.4),
//                   //     fontSize: 12))),
//                   // popupProps: const PopupProps.menu(
//                   //     showSearchBox: true,
//                   //     interceptCallBacks: true,
//                   //     isFilterOnline: true,
//                   //     searchFieldProps: TextFieldProps(
//                   //         decoration: InputDecoration(hintText: 'Search'))),
//                   onChanged: (city) {
//                     cityData = city;
//                   },
//                 );
//               }),
//             ]),
//       ],
//     );
//   }
// }
