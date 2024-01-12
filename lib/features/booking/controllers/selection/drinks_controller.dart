import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/features/booking/data/models/demo_drinks_model.dart';

// final drinksProvider =
//     StateNotifierProvider<DrinksController, List<DemoDrinksModel>>(
//         (ref) => DrinksController());
//
// class DrinksController extends StateNotifier<List<DemoDrinksModel>> {
//   DrinksController() : super([]);
//
//   addDrink(DemoDrinksModel drink) {
//     state = [drink, ...state];
//   }
//
//   removeDrink(DemoDrinksModel drink) {
//     final drinks = state.where((element) => element.id != drink.id).toList();
//     state = drinks;
//   }
// }
//
// final brandProvider =
//     StateNotifierProvider<DrinksBrandController, List<DemoDrinksBrandModel>>(
//         (ref) => DrinksBrandController());
//
// class DrinksBrandController extends StateNotifier<List<DemoDrinksBrandModel>> {
//   DrinksBrandController() : super([]);
//
//   addDrink(DemoDrinksBrandModel drink) {
//     state = [drink, ...state];
//   }
// }

//---------------------------------------------------

final showAddDrinkForm = StateProvider<bool>((ref) => true);

class DrinkModel {
  final String tempId;
  final String id;
  final String type;
  final String brand;
  DrinkModel(this.id, this.type, this.brand, this.tempId);

  Map<String, dynamic> toJson(){
    return {
      'category': id,
      'category_name': type,
      'brand_name': brand,
      'product_type': 'drink'
    };
  }
}

final drinkProvider =
    StateNotifierProvider.autoDispose<DrinkController, List<DrinkModel>>(
        (ref) => DrinkController());

class DrinkController extends StateNotifier<List<DrinkModel>> {
  DrinkController() : super([]);

  // String? drinkType;

  addDrink(String id, String drinkName, String brand) {
    state = [...state, DrinkModel(id, drinkName, brand, DateTime.now().toIso8601String())];
  }

  deleteDrink(String tempId){
    state = state.where((element) => element.tempId != tempId).toList();
  }


}
