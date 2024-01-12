// To parse this JSON data, do
//
//     final clubsListResponse = clubsListResponseFromJson(jsonString);

// import 'dart:convert';
//
// ClubsListResponse clubsListResponseFromJson(String str) =>
//     ClubsListResponse.fromJson(json.decode(str));
//
// String clubsListResponseToJson(ClubsListResponse data) =>
//     json.encode(data.toJson());
//
// class ClubsListResponse {
//   ClubsListResponse({
//     required this.success,
//     required this.data,
//     required this.count,
//   });
//
//   final bool success;
//   final List<ClubData> data;
//   final int count;
//
//   factory ClubsListResponse.fromJson(Map<String, dynamic> json) =>
//       ClubsListResponse(
//         success: json["success"],
//         data:
//             List<ClubData>.from(json["data"].map((x) => ClubData.fromJson(x))),
//         count: json["count"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "success": success,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//         "count": count,
//       };
// }

import 'package:cloud_firestore/cloud_firestore.dart';

class ClubData {
  ClubData({
    required this.id,
    required this.name,
    this.featured,
    this.address,
    this.profileImage,
    this.rating,
    this.latitude,
    this.longitude,
    // this.stateName,
    this.city,
    // this.countryName,
    this.distance,
    this.websiteUrl,
    // this.cityRef
  });

  final String id;
  final String name;
  final bool? featured;
  final String? address;
  final String? profileImage;
  final dynamic rating;
  final double? latitude;
  final double? longitude;
  // final String? stateName;
  final DocumentReference? city;
  // final String? countryName;
  final String? distance;
  final String? websiteUrl;
  // final dynamic cityRef;

  factory ClubData.fromJson(Map<String, dynamic> json) => ClubData(
        id: json["id"],
        name: json["name"],
        featured: json["featured"],
        address: json["address"],
        profileImage: json["profile_image"],
        rating: json["rating"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        // stateName: json["state_name"],
        city: json["city"] == null ? null : json["city"] as DocumentReference,
        // countryName: json["country_name"],
        distance: json["distance"],
    websiteUrl: json["website_url"],
    // cityRef: json["city"]
      );

  // Map<String, dynamic> toJson() => {
  //       "id": id,
  //       "name": name,
  //       "featured": featured,
  //       "address": address,
  //       "profile_image": profileImage,
  //       "rating": rating,
  //       "latitude": latitude,
  //       "longitude": longitude,
  //       "state_name": stateName,
  //       "city_name": cityName,
  //       "country_name": countryName,
  //       "distance": distance,
  //     };
}



