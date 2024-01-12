// // To parse this JSON data, do
// //
// //     final locationListResponse = locationListResponseFromJson(jsonString);
//
// import 'dart:convert';
//
// LocationListResponse locationListResponseFromJson(String str) =>
//     LocationListResponse.fromJson(json.decode(str));
//
// String locationListResponseToJson(LocationListResponse data) =>
//     json.encode(data.toJson());
//
// class LocationListResponse {
//   LocationListResponse({
//     required this.success,
//     required this.data,
//     required this.count,
//   });
//
//   final bool success;
//   final List<LocationData> data;
//   final int count;
//
//   factory LocationListResponse.fromJson(Map<String, dynamic> json) =>
//       LocationListResponse(
//         success: json["success"],
//         data: List<LocationData>.from(
//             json["data"].map((x) => LocationData.fromJson(x))),
//         count: json["count"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "success": success,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//         "count": count,
//       };
// }

import 'package:json_annotation/json_annotation.dart';

part 'location_list_response.g.dart';

@JsonSerializable()
class LocationData {
  LocationData({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    this.cityImage,
    this.partyLocation,
    this.popularHometown,
    this.countryName
  });

  final String id;
  final String name;
  final double latitude, longitude;
  @JsonKey(name: 'city_image')
  final String? cityImage;
  @JsonKey(name: 'party_location')
  final bool? partyLocation;
  @JsonKey(name: 'popular_hometown')
  final bool? popularHometown;
  @JsonKey(name: 'country_name')
  final String? countryName;


  factory LocationData.fromJson(Map<String, dynamic> json) => _$LocationDataFromJson(json);

  Map<String, dynamic> toJson() => _$LocationDataToJson(this);

}
