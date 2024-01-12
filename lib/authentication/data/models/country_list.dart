// To parse this JSON data, do
//
//     final countryListResponse = countryListResponseFromJson(jsonString);

import 'dart:convert';

CountryListResponse countryListResponseFromJson(String str) => CountryListResponse.fromJson(json.decode(str));

String countryListResponseToJson(CountryListResponse data) => json.encode(data.toJson());

class CountryListResponse {
  final bool success;
  final List<CountryData> data;
  final int count;

  CountryListResponse({
    required this.success,
    required this.data,
    required this.count,
  });

  factory CountryListResponse.fromJson(Map<String, dynamic> json) => CountryListResponse(
    success: json["success"],
    data: List<CountryData>.from(json["data"].map((x) => CountryData.fromJson(x))),
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "count": count,
  };
}

class CountryData {
  final int id;
  final String name;
  final String countryCode;
  final dynamic countryImage;

  CountryData({
    required this.id,
    required this.name,
    required this.countryCode,
    this.countryImage,
  });

  factory CountryData.fromJson(Map<String, dynamic> json) => CountryData(
    id: json["id"],
    name: json["name"],
    countryCode: json["country_code"],
    countryImage: json["country_image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "country_code": countryCode,
    "country_image": countryImage,
  };
}
