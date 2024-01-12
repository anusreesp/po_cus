import 'package:change_case/change_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/features/booking/controllers/selection/drinks_controller.dart';

import '../../../../../clubs/data/models/products_model.dart';
import '../../../widgets/selection_dialog_box_container.dart';

class SelectDrinkType extends StatefulWidget {
  final List<ProductModel> drinks;
  const SelectDrinkType({super.key, required this.drinks});

  @override
  State<SelectDrinkType> createState() => _SelectDrinkTypeState();
}

class _SelectDrinkTypeState extends State<SelectDrinkType> {
  List<ProductModel> _filteredDrinks = [];

  @override
  void initState() {
    super.initState();
    _filteredDrinks = widget.drinks;
  }

  _filterDrinks(String searchText) {
    final result = widget.drinks
        .where((drink) =>
            drink.name.toLowerCase().startsWith(searchText.toLowerCase()))
        .toList();
    setState(() {
      _filteredDrinks = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      return SelectionDialogBoxContainer(
          titleText: 'Select a drink',
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 2),
                child: TextField(
                  onChanged: _filterDrinks,
                  decoration: InputDecoration(
                      hintText: "Search a drink",
                      focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 207, 207, 207))),
                      enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 207, 207, 207))),
                      hintStyle: TextStyle(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey.shade500),
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12)),
                ),
              ),
              const SizedBox(
                height: 8,
              ),

              // if(widget.drinks.isEmpty)
              //   const Center(child: Text('Drinks not available'),),
              // for (int i = 0; i <= drink.length - 1; i++)
              //   _selectedRow(drink[i]),

              if (_filteredDrinks.isEmpty) const Text('Drinks not available'),

              ..._filteredDrinks.map((e) => GestureDetector(
                    onTap: (() {
                      // ref.read(drinkProvider.notifier).drinkType = e.name;
                      Navigator.of(context, rootNavigator: true).pop();
                      showDialog(
                          context: context,
                          builder: (context) => SelectDrinkBrand(
                                selectedProduct: e,
                              ));
                    }),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        color: Colors.black12.withOpacity(0.1),
                        padding:
                            const EdgeInsets.only(left: 8, bottom: 12, top: 12),
                        child: Text(
                          e.name.toTitleCase(),
                        ),
                      ),
                    ),
                  ))
            ],
          ));
    });
  }
}

class SelectDrinkBrand extends StatefulWidget {
  final ProductModel selectedProduct;
  SelectDrinkBrand({super.key, required this.selectedProduct});

  @override
  State<SelectDrinkBrand> createState() => _SelectDrinkBrandState();
}

class _SelectDrinkBrandState extends State<SelectDrinkBrand> {
  List<Brand> _filteredBrand = [];

  @override
  void initState() {
    super.initState();
    _filteredBrand = widget.selectedProduct.brands;
  }

  _filterBrands(String searchText) {
    final result = widget.selectedProduct.brands
        .where((smoke) =>
            smoke.name.toLowerCase().startsWith(searchText.toLowerCase()))
        .toList();
    setState(() {
      _filteredBrand = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      return SelectionDialogBoxContainer(
          titleText: 'Select a brand',
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 2),
                child: TextField(
                  onChanged: _filterBrands,
                  decoration: InputDecoration(
                      hintText: "Search Brand / Flavors",
                      focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 207, 207, 207))),
                      enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 207, 207, 207))),
                      hintStyle: TextStyle(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey.shade500),
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12)),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              // for (int i = 0; i <= drink.length - 1; i++)
              //   _selectedRow(drink[i]),
              ..._filteredBrand.map((e) => GestureDetector(
                    onTap: (() {
                      Navigator.pop(context);
                      ref.read(drinkProvider.notifier).addDrink(
                          widget.selectedProduct.id,
                          widget.selectedProduct.name,
                          e.name);
                      ref.read(showAddDrinkForm.notifier).state = false;
                    }),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        color: Colors.black12.withOpacity(0.1),
                        padding:
                            const EdgeInsets.only(left: 8, bottom: 12, top: 12),
                        child: Text(
                          e.name.toTitleCase(),
                        ),
                      ),
                    ),
                  ))
            ],
          ));
    });
  }
}
