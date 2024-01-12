// To parse this JSON data, do
//
//     final cityListResponse = cityListResponseFromJson(jsonString);

import 'dart:convert';

CityListResponse cityListResponseFromJson(String str) => CityListResponse.fromJson(json.decode(str));

// String cityListResponseToJson(CityListResponse data) => json.encode(data.toJson());

class CityListResponse {
  final bool success;
  final List<CityData> data;
  final int count;

  CityListResponse({
    required this.success,
    required this.data,
    required this.count,
  });

  factory CityListResponse.fromJson(Map<String, dynamic> json) => CityListResponse(
    success: json["success"],
    data: List<CityData>.from(json["data"].map((x) => CityData.fromJson(x))),
    count: json["count"],
  );

// Map<String, dynamic> toJson() => {
//   "success": success,
//   "data": List<dynamic>.from(data.map((x) => x.toJson())),
//   "count": count,
// };
}

class CityData {
  final int id;
  final String name;
  final String countryName;
  final String stateName;
  final double? latitude;
  final double? longitude;
  final dynamic cityImage;
  final dynamic partyLocation;
  final dynamic popularHometown;
  // final DateTime createdAt;
  // final dynamic updatedAt;
  final int countryId;
  final int stateId;

  CityData({
    required this.id,
    required this.name,
    required this.countryName,
    required this.stateName,
    this.latitude,
    this.longitude,
    this.cityImage,
    this.partyLocation,
    this.popularHometown,
    // required this.createdAt,
    // this.updatedAt,
    required this.countryId,
    required this.stateId,
  });

  factory CityData.fromJson(Map<String, dynamic> json) => CityData(
    id: json["id"],
    name: json["name"],
    countryName: json["country_name"],
    stateName: json["state_name"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    cityImage: json["city_image"],
    partyLocation: json["party_location"],
    popularHometown: json["popular_hometown"],
    // createdAt: DateTime.parse(json["createdAt"]),
    // updatedAt: json["updatedAt"],
    countryId: json["country_id"],
    stateId: json["state_id"],
  );

// Map<String, dynamic> toJson() => {
//   "id": id,
//   "name": name,
//   "country_name": countryName,
//   "state_name": stateName,
//   "latitude": latitude,
//   "longitude": longitude,
//   "city_image": cityImage,
//   "party_location": partyLocation,
//   "popular_hometown": popularHometown,
//   "createdAt": createdAt.toIso8601String(),
//   "updatedAt": updatedAt,
//   "country_id": countryId,
//   "state_id": stateId,
// };
}
