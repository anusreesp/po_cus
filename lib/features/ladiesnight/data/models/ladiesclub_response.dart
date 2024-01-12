// To parse this JSON data, do
//
//     final ladiesNightClubListResponse = ladiesNightClubListResponseFromJson(jsonString);

import 'dart:convert';

LadiesNightClubListResponse ladiesNightClubListResponseFromJson(String str) =>
    LadiesNightClubListResponse.fromJson(json.decode(str));

// String ladiesNightClubListResponseToJson(LadiesNightClubListResponse data) =>
//     json.encode(data.toJson());

class LadiesNightClubListResponse {
  LadiesNightClubListResponse({
    required this.success,
    // required this.data,
    required this.message,
    required this.count,
  });

  final bool success;
  // final List<LadiesNightData> data;
  final List<LadiesNightData> message;
  final int count;

  factory LadiesNightClubListResponse.fromJson(Map<String, dynamic> json) =>
      LadiesNightClubListResponse(
        success: json["success"],
        // data: json["data"] == null
        message: json["message"] == null
            ? []
            : List<LadiesNightData>.from(
                json["message"].map((x) => LadiesNightData.fromJson(x))),
        count: json["count"],
      );

  // Map<String, dynamic> toJson() => {
  //       "success": success,
  //       "message": List<dynamic>.from(message.map((x) => x.toJson())),
  //       "count": count,
  //     };
}

class LadiesNightData {
  LadiesNightData({
    required this.id,
    required this.name,
    required this.featured,
    required this.address,
    this.profileImage,
    // this.rating,
    this.distance,
    required this.stateName,
    required this.cityName,
    required this.countryName,
    this.logo,
    this.displayImage,
  });

  final String id;
  final String name;
  final bool featured;
  final String address;
  final String? profileImage;
  // final double? rating;
  // final String? distance;
  final double? distance;
  final String stateName;
  final String cityName;
  final String countryName;
  final String? logo;
  final String? displayImage;

  factory LadiesNightData.fromJson(Map<String, dynamic> json) =>
      LadiesNightData(
          id: json["id"],
          name: json["name"],
          featured: json["featured"],
          address: json["address"],
          profileImage: json["profile_image"],
          // rating: json["rating"]?.toDouble(),
          distance: json["distance"]?.toDouble(),
          displayImage: json["display_image"],
          stateName: json["state_name"],
          cityName: json["city_name"],
          countryName: json["country_name"],
          logo: json["logo"]);

  // Map<String, dynamic> toJson() => {
  //       "id": id,
  //       "name": name,
  //       "featured": featured,
  //       "address": address,
  //       "profile_image": profileImage,
  //       // "rating": rating,
  //       "distance": distance,
  //       "logo": logo,
  //       "display_image": displayImage,
  //       "state_name": stateNameValues.reverse[stateName],
  //       "city_name": cityNameValues.reverse[cityName],
  //       "country_name": countryNameValues.reverse[countryName],
  //     };
}
