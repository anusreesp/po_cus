import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dialog.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';

class CountryCodePickerDialog extends StatefulWidget {
  final String? selectedCountryCode;
  final Function(Country) onValuePicked;
  const CountryCodePickerDialog(
      {super.key, this.selectedCountryCode, required this.onValuePicked});

  @override
  State<CountryCodePickerDialog> createState() =>
      _CountryCodePickerDialogState();
}

class _CountryCodePickerDialogState extends State<CountryCodePickerDialog> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return CountryPickerDialog(
                isSearchable: true,
                itemBuilder: _buildDialogItem,
                searchInputDecoration:
                    const InputDecoration(hintText: 'Search country'),
                title: const SizedBox.shrink(),
                // searchInputDecoration: InputDecoration(hintText: 'Search...'),
                onValuePicked: widget.onValuePicked,
                searchEmptyView: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // SizedBox(width: 12),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: const Text(
                          'Incorrect country, please check and try again '),
                    ),
                  ],
                ),
              );
            });
      },
      child: Row(
        children: [
          CountryPickerUtils.getDefaultFlagImage(
              CountryPickerUtils.getCountryByIsoCode(
                  widget.selectedCountryCode ?? 'SG')),
          const Icon(Icons.arrow_drop_down)
        ],
      ),
    );
  }

  Widget _buildDialogItem(Country country) => Row(
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          const SizedBox(width: 8.0),
          Expanded(child: Text(country.name)),
          // const Spacer(),
          Text("+${country.phoneCode}"),
        ],
      );
}
