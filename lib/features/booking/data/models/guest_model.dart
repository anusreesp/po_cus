import 'dart:convert';

import 'package:flutter/cupertino.dart';

String guestModelToJson(List<GuestModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GuestModel {
  GuestModel(this.name, this.age, this.id, this.gender);

  final String id;
  final String name;
  final String age;
  final String gender;

  // factory GuestModel.fromJson(Map<String, dynamic> json) => GuestModel(
  //   name: json["name"],
  //   age: json["age"],
  // );

  Map<String, dynamic> toJson() => {"name": name, "age": age, "gender": gender};
}

class GuestEditModel {
  TextEditingController nameController;
  TextEditingController ageController;
  String? gender;
  String id;

  GuestEditModel()
      : nameController = TextEditingController(),
        ageController = TextEditingController(),
        id = DateTime.now().microsecondsSinceEpoch.toString();
}
