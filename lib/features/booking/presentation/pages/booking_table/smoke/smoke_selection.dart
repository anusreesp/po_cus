import 'package:change_case/change_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/features/booking/controllers/selection/smoke_controller.dart';
import 'package:htp_customer/features/booking/presentation/widgets/selection_dialog_box_container.dart';

import '../../../../../clubs/data/models/products_model.dart';

class SelectSmokeType extends StatefulWidget {
  final List<ProductModel> smokes;
  SelectSmokeType({super.key, required this.smokes});

  @override
  State<SelectSmokeType> createState() => _SelectSmokeTypeState();
}

class _SelectSmokeTypeState extends State<SelectSmokeType> {

  List<ProductModel> _filteredSmokes = [];

  @override
  void initState() {
    super.initState();
    _filteredSmokes = widget.smokes;
  }

  _filterSmokes(String searchText){
    final result = widget.smokes.where((drink) => drink.name.toLowerCase().startsWith(searchText.toLowerCase())).toList();
    setState(() {
      _filteredSmokes = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SelectionDialogBoxContainer(titleText: 'Select a smoke', child: Column(
      children: [
        Padding(
          padding:
          const EdgeInsets.only(left: 8, right: 8, top: 2),
          child: TextField(
            onChanged: _filterSmokes,
            decoration: InputDecoration(
                hintText: "Search a Smoke",
                focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(
                            255, 207, 207, 207))),
                enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(
                            255, 207, 207, 207))),
                hintStyle: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey.shade500),
                isDense: true,
                contentPadding:
                const EdgeInsets.symmetric(vertical: 12)),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        // if(widget.smokes.isEmpty)
        //   const Center(child: Text('Smokes not available'),),
        // for (int i = 0; i <= drink.length - 1; i++)
        //   _selectedRow(drink[i]),
        if(_filteredSmokes.isEmpty)
          const Center(child: Text('Smokes not available'),),

        ..._filteredSmokes.map((e) => GestureDetector(
          onTap: (() {
            debugPrint("-----------${e.name}--------");
            // ref.read(smokeProvider.notifier).smokeType = e.name;
            Navigator.of(context, rootNavigator: true)
                .pop();
            showDialog(
                context: context,
                builder: (context) => SelectSmokeFlavor(selectedSmoke: e,));
          }),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              color: Colors.black12.withOpacity(0.1),
              padding: const EdgeInsets.only(
                  left: 8, bottom: 12, top: 12),
              child: Text(
                e.name.toTitleCase(),
              ),
            ),
          ),
        ))
      ],
    ));
  }
}

class SelectSmokeFlavor extends StatefulWidget {
  final ProductModel selectedSmoke;
  SelectSmokeFlavor({super.key, required this.selectedSmoke});

  @override
  State<SelectSmokeFlavor> createState() => _SelectSmokeFlavorState();
}

class _SelectSmokeFlavorState extends State<SelectSmokeFlavor> {

  List<Brand> _filteredBrand = [];

  @override
  void initState() {
    super.initState();
    _filteredBrand = widget.selectedSmoke.brands;
  }

  _filterBrands(String searchText){
    final result = widget.selectedSmoke.brands.where((drink) => drink.name.toLowerCase().startsWith(searchText.toLowerCase())).toList();
    setState(() {
      _filteredBrand = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _){
      return SelectionDialogBoxContainer(
          titleText: 'Select a brand',
          child: Column(
            children: [
              Padding(
                padding:
                const EdgeInsets.only(left: 8, right: 8, top: 2),
                child: TextField(
                  onChanged: _filterBrands,
                  decoration: InputDecoration(
                      hintText: "Search Brand",
                      focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(
                                  255, 207, 207, 207))),
                      enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(
                                  255, 207, 207, 207))),
                      hintStyle: TextStyle(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey.shade500),
                      isDense: true,
                      contentPadding:
                      const EdgeInsets.symmetric(vertical: 12)),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              // for (int i = 0; i <= drink.length - 1; i++)
              //   _selectedRow(drink[i]),
              ..._filteredBrand.map((e) => GestureDetector(
                onTap: (() {
                  debugPrint("-----------${e.name}--------");
                  ref.read(smokeProvider.notifier).addSmoke(widget.selectedSmoke.id, widget.selectedSmoke.name, e.name);
                  ref.read(showSmokeFormProvider.notifier).state = false;
                  Navigator.pop(context);
                }),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    color: Colors.black12.withOpacity(0.1),
                    padding: EdgeInsets.only(
                        left: 8, bottom: 12, top: 12),
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
