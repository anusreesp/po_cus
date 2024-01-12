// To parse this JSON data, do
//
//     final clubDetailsResponse = clubDetailsResponseFromJson(jsonString);

import 'dart:convert';

ClubDetailsResponse clubDetailsResponseFromJson(String str) =>
    ClubDetailsResponse.fromJson(json.decode(str));

String clubDetailsResponseToJson(ClubDetailsResponse data) =>
    json.encode(data.toJson());

class ClubDetailsResponse {
  ClubDetailsResponse({
    required this.success,
    required this.data,
    required this.count,
  });

  final bool success;
  final List<ClubDetailData> data;
  final int count;

  factory ClubDetailsResponse.fromJson(Map<String, dynamic> json) =>
      ClubDetailsResponse(
        success: json["success"],
        data: List<ClubDetailData>.from(
            json["data"].map((x) => ClubDetailData.fromJson(x))),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "count": count,
      };
}

class ClubDetailData {
  ClubDetailData({
    required this.id,
    required this.name,
    required this.featured,
    this.profileImage,
    required this.address,
    required this.dress,
    required this.rating,
    this.yearOfOpening,
    required this.websiteUrl,
    required this.country,
    required this.state,
    required this.city,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
    required this.updatedAt,
    required this.clubToClubContactRel,
    required this.stateName,
    required this.cityName,
    required this.countryName,
    required this.policies,
    required this.schedule,
    required this.photos,
  });

  final String id;
  final String name;
  final bool featured;
  final String? profileImage;
  final String? address;
  final String? dress;
  final double rating;
  final String? yearOfOpening;
  final String? websiteUrl;
  final String country;
  final String state;
  final String city;
  final double? latitude;
  final double? longitude;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<ClubToClubContactRel> clubToClubContactRel;
  final String stateName;
  final String cityName;
  final String countryName;
  final List<dynamic> policies;
  final List<Schedule> schedule;
  final List<String> photos;

  factory ClubDetailData.fromJson(Map<String, dynamic> json) => ClubDetailData(
        id: json["id"],
        name: json["name"],
        featured: json["featured"],
        profileImage: json["profile_image"],
        address: json["address"],
        dress: json["dress"],
        rating: json["rating"]?.toDouble(),
        yearOfOpening: json["year_of_opening"],
        websiteUrl: json["website_url"],
        country: json["country"],
        state: json["state"],
        city: json["city"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        clubToClubContactRel: List<ClubToClubContactRel>.from(
            json["club_to_club_contact_rel"]
                .map((x) => ClubToClubContactRel.fromJson(x))),
        stateName: json["state_name"],
        cityName: json["city_name"],
        countryName: json["country_name"],
        policies: List<dynamic>.from(json["policies"].map((x) => x)),
        schedule: List<Schedule>.from(
            json["schedule"].map((x) => Schedule.fromJson(x))),
        photos: List<String>.from(json["photos"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "featured": featured,
        "profile_image": profileImage,
        "address": address,
        "dress": dress,
        "rating": rating,
        "year_of_opening": yearOfOpening,
        "website_url": websiteUrl,
        "country": country,
        "state": state,
        "city": city,
        "latitude": latitude,
        "longitude": longitude,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "club_to_club_contact_rel":
            List<dynamic>.from(clubToClubContactRel.map((x) => x.toJson())),
        "state_name": stateName,
        "city_name": cityName,
        "country_name": countryName,
        "policies": List<dynamic>.from(policies.map((x) => x)),
        "schedule": List<dynamic>.from(schedule.map((x) => x.toJson())),
        "photos": List<dynamic>.from(photos.map((x) => x)),
      };
}

class ClubToClubContactRel {
  ClubToClubContactRel({
    required this.id,
    required this.contactPerson,
    required this.emailId,
    required this.contactNo,
  });

  final String id;
  final String contactPerson;
  final String emailId;
  final String contactNo;

  factory ClubToClubContactRel.fromJson(Map<String, dynamic> json) =>
      ClubToClubContactRel(
        id: json["id"],
        contactPerson: json["contact_person"],
        emailId: json["email_id"],
        contactNo: json["contact_no"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "contact_person": contactPerson,
        "email_id": emailId,
        "contact_no": contactNo,
      };
}

class Schedule {
  Schedule({
    required this.id,
    required this.days,
    required this.fromTime,
    required this.toTime,
  });

  final String id;
  final String days;
  final String fromTime;
  final String toTime;

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        id: json["id"],
        days: json["days"],
        fromTime: json["from_time"],
        toTime: json["to_time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "days": days,
        "from_time": fromTime,
        "to_time": toTime,
      };
}
