import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:htp_customer/features/booking/controllers/booking_selection_controller.dart';
import 'package:htp_customer/features/booking/controllers/selection/drinks_controller.dart';
import 'package:htp_customer/features/booking/presentation/pages/booking_table/drinks/drink_detail_box.dart';
import 'package:htp_customer/features/booking/presentation/pages/booking_table/drinks/drink_selection.dart';

import 'package:htp_customer/features/booking/presentation/widgets/buttons/options_widget.dart';
import 'package:htp_customer/features/booking/presentation/widgets/buttons/nextback_button.dart';
import 'package:htp_customer/htp_theme.dart';
import 'package:htp_customer/common/widgets_common/rounded_golden_button.dart';

import '../../../../../clubs/data/models/products_model.dart';

class AddDrinks extends ConsumerWidget {
  final List<ProductModel> drinks;
  const AddDrinks({super.key, required this.drinks});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final drinksController = ref.watch(drinkProvider);
    return Container(
      padding: const EdgeInsets.symmetric(
          // horizontal: 18,
          vertical: 18),
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          if (drinksController.isEmpty) _infoText(),

          drinksController.isEmpty
              ? DrinkSelectionButton(
                  drinks: drinks,
                )
              : Column(
                  children: [
                    for (int i = 0; i < drinksController.length; i++)
                      DrinkSmokeBox(
                          type: drinksController[i].type,
                          brand: drinksController[i].brand,
                          count: i + 1,
                          onDeleteClick: () {
                            ref
                                .read(drinkProvider.notifier)
                                .deleteDrink(drinksController[i].tempId);
                          }),
                  ],
                ),

          if (drinksController.isNotEmpty)
            DrinkSelectionButton(
              drinks: drinks,
            ),

          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                  onTap: () {
                    ref.read(selectionProvider.notifier).state =
                        SelectionType.date;
                  },
                  child: const Text('BACK')),
              const SizedBox(
                width: 24,
              ),
              SizedBox(
                  width: 160,
                  height: 44,
                  child: RoundedGoldenButton(
                      onTap: () {
                        ref.read(selectionProvider.notifier).state =
                            SelectionType.smokes;
                      },
                      text: 'Next'))
            ],
          )

          // NextBackButtons(
          //   onTap: () {
          //     ref.read(selectionProvider.notifier).state = SelectionType.smokes;
          //     // ref.read(showAddDrinkBox.notifier).state = true;
          //     ref.read(drinkDonetickProvider.notifier).state = true;
          //   },
          //   isInsideBox: false,
          // )
        ],
      ),
    );
  }

  Widget _infoText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Preferred Drinks",
          style: TextStyle(
              fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 4,
        ),
        Row(
          children: [
            Icon(
              Icons.info,
              size: 14,
              color: Colors.grey.shade500.withOpacity(0.5),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              "Add upto any number of drinks.",
              softWrap: true,
              style: TextStyle(
                  fontSize: 12, color: Colors.grey.shade500.withOpacity(0.6)),
            ),
          ],
        ),
      ],
    );
  }
}

class DrinkSelectionButton extends ConsumerWidget {
  final List<ProductModel> drinks;
  const DrinkSelectionButton({Key? key, required this.drinks})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // return DrinkDetailBox(type: 'type', brand: 'brand', count: 1,);
    final addedDrinks = ref.watch(drinkProvider);
    final bool showAddDrink = ref.watch(showAddDrinkForm);

    if (!showAddDrink && addedDrinks.isNotEmpty) {
      return const AddMoreDrinks();
    }

    return Column(
      children: [
        Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(top: 18),
            decoration: BoxDecoration(
                // color: Colors.white,
                color: Colors.white.withOpacity(0.08),
                borderRadius: BorderRadius.circular(8)),
            child: Column(children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Drink ",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
              OptionWidget(
                  hint: 'Select a drink',
                  onclick: () => showDialog(
                      context: context,
                      builder: (context) => SelectDrinkType(drinks: drinks))),
              const SizedBox(
                height: 12,
              )
              // OptionWidget(
              //     hint: "Select the brand",
              //     onclick: () {
              //       showDialog(
              //           context: context,
              //           builder: (context) => SelectDrinkType(drinks: drinks));
              //           // builder: (context) => SelectDrinkBrand());
              //     }),
              // NextBackButtons(
              //   onTap: () {
              //     // ref.read(selectionProvider.notifier).state =
              //     //     SelectionType.smokes;
              //     ref.read(drinkProvider.notifier).addDrink(DrinkModel(DateTime.now().toString(), 'type', 'brand'));
              //     ref.read(showAddDrinkBox.notifier).state = false;
              //   },
              //   isInsideBox: true,
              // )
            ])),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }
}

//
// class DrinksList extends ConsumerWidget {
//   const DrinksList({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             height: 24,
//           ),
//
//           // NextBackButtons(
//           //   onTap: () {
//           //     ref.read(selectionProvider.notifier).state = SelectionType.smokes;
//
//           //     ref.read(drinkDonetickProvider.notifier).state = true;
//           //   },
//           //   isInsideBox: false,
//           // )
//         ],
//       ),
//     );
//
//   }
//
// }
