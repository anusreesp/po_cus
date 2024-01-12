import 'package:flutter_riverpod/flutter_riverpod.dart';

final showSmokeFormProvider = StateProvider<bool>((ref) => true);

class SmokeModel {
  final String id;
  final String type;
  final String brand;
  final String tempId;
  SmokeModel(this.id, this.type, this.brand, this.tempId);

  Map<String, dynamic> toJson(){
    return {
      'category': id,
      'category_name': type,
      'brand_name': brand,
      'product_type': 'smoke'
    };
  }
}

final smokeProvider =
    StateNotifierProvider.autoDispose<SmokeAddedController, List<SmokeModel>>((ref) {
  return SmokeAddedController();
});

class SmokeAddedController extends StateNotifier<List<SmokeModel>> {
  SmokeAddedController() : super([]);

  // String smokeType = '';

  addSmoke(String id, String smokeType, String brand) {
    final newSmoke = SmokeModel(id, smokeType, brand, DateTime.now().toIso8601String());

    state = [...state, newSmoke];
  }

  removeSmoke(String id){
    try{
      state = state.where((element) => element.tempId != id).toList();
    }catch(_){
      state = [];
    }
  }
}
