import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/guest_model.dart';

// final showAddGuestBox = StateProvider.autoDispose<bool>((ref) => true);

// final guestAddProvider = StateNotifierProvider.autoDispose<GuestAddController, List<GuestModel>>((ref) => GuestAddController());
//
// class GuestAddController extends StateNotifier<List<GuestModel>>{
//   GuestAddController(): super([]);
//
//   addGuest(String name, String age, String gender){
//     final newGuest = GuestModel(name, age, DateTime.now().toIso8601String(), gender);
//     state = [
//       ...state,
//       newGuest
//     ];
//   }
//
//   removeGuest(String id){
//     try{
//       state = state.where((element) => element.id != id).toList();
//     }catch(_){
//       state = [];
//     }
//   }
//
//
// }

//-------------------------------- Edit Guest List controller ----------------

final guestEditProvider = StateNotifierProvider.autoDispose<GuestEditController,
    List<GuestEditModel>>((ref) => GuestEditController());

class GuestEditController extends StateNotifier<List<GuestEditModel>> {
  GuestEditController() : super([GuestEditModel()]);

  final formKey = GlobalKey<FormState>();

  addGuest() {
    state = [...state, GuestEditModel()];
  }

  removeGuest(String id) {
    state = [
      for (final guest in state)
        if (guest.id != id) guest
    ];
  }

  List<GuestModel> getGuestList() {
    List<GuestModel> guests = [];
    if (formKey.currentState!.validate()) {
      for (final guest in state) {
        if (guest.gender != null) {
          if (guest.nameController.text == "") {
            guests.add(GuestModel(
                "-", guest.ageController.text, guest.id, guest.gender!));
          } else {
            guests.add(GuestModel(guest.nameController.text,
                guest.ageController.text, guest.id, guest.gender!));
          }
        } else {
          throw 'Select gender: ${guest.nameController.text}';
        }
      }
      return guests;
    } else {
      throw 'Fill all fields.';
    }
  }

  clearGuest() {
    state = [];
  }
}
