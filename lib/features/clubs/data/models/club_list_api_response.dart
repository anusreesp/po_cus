// To parse this JSON data, do
//
//     final clubListApiResponse = clubListApiResponseFromJson(jsonString);

// import 'dart:convert';
//
// ClubListApiResponse clubListApiResponseFromJson(String str) => ClubListApiResponse.fromJson(json.decode(str));

// String clubListApiResponseToJson(ClubListApiResponse data) => json.encode(data.toJson());

class ClubListApiResponse {
  ClubListApiResponse({
    required this.success,
    required this.message,
    required this.count,
  });

  final bool success;
  final List<ClubDataNew> message;
  final int count;

  factory ClubListApiResponse.fromJson(Map<String, dynamic> json) =>
      ClubListApiResponse(
        success: json["success"],
        message: json["message"] == null
            ? []
            : List<ClubDataNew>.from(
                json["message"].map((x) => ClubDataNew.fromJson(x))),
        count: json["count"],
      );

  // Map<String, dynamic> toJson() => {
  //   "success": success,
  //   "message": List<dynamic>.from(message.map((x) => x.toJson())),
  //   "count": count,
  // };
}

class ClubDataNew {
  ClubDataNew({
    required this.id,
    // this.dress,
    required this.featured,
    // this.yearOfOpening,
    this.latitude,
    this.rating,
    // required this.createdAt,
    required this.cityName,
    // this.stateName,
    // this.countryName,
    this.logo,
    // this.stateId,
    this.displayImage,
    this.longitude,
    // this.updatedAt,
    this.address,
    // this.schedule,
    this.websiteUrl,
    required this.name,
    // this.countryId,
    // this.sittingTables,
    this.cityId,
    // this.managerContacts,
    required this.photos,
    // required this.policies,
    required this.openNow,
    required this.distance,
    required this.status,
  });

  final String id;
  // final String? dress;
  final bool featured;
  // final String? yearOfOpening;
  final double? latitude;
  final double? rating;
  // final DateTime? createdAt;
  final String cityName;
  // final String? stateName;
  // final String? countryName;
  final String? logo;
  // final String? stateId;
  final String? displayImage;
  final double? longitude;
  // final dynamic updatedAt;
  final String? address;
  // final Schedule? schedule;
  final String? websiteUrl;
  final String name;
  // final String? countryId;
  // final Schedule? sittingTables;
  final String? cityId;
  // final List<ManagerContact>? managerContacts;
  final List<Photo> photos;
  // final List<String> policies;
  final bool openNow;
  final double? distance;
  final String status;

  factory ClubDataNew.fromJson(Map<String, dynamic> json) => ClubDataNew(
      id: json["id"],
      // dress: json["dress"],
      featured: json["featured"],
      // yearOfOpening: json["year_of_opening"],
      latitude: json["latitude"]?.toDouble(),
      rating: json["rating"]?.toDouble(),
      // createdAt: DateTime.parse(json["createdAt"]),
      cityName: json["city_name"],
      // stateName: json["state_name"],
      // countryName: json["country_name"],
      logo: json["logo"],
      // stateId: json["state_id"],
      displayImage: json["display_image"],
      longitude: json["longitude"]?.toDouble(),
      // updatedAt: json["updatedAt"],
      address: json["address"],
      // schedule: Schedule.fromJson(json["schedule"]),
      websiteUrl: json["website_url"],
      name: json["name"],
      // countryId: json["country_id"],
      // sittingTables: Schedule.fromJson(json["sitting_tables"]),
      cityId: json["city_id"],
      // managerContacts: json["manager_contacts"] == null ? [] : List<ManagerContact>.from(json["manager_contacts"].map((x) => ManagerContact.fromJson(x))),
      photos: json["photos"] == null
          ? []
          : List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
      // policies: json["policies"] == null ? [] : List<String>.from(json["policies"].map((x) => x)),
      openNow: json["open_now"],
      distance: json["distance"]?.toDouble(),
      status: json['status']);

  // Map<String, dynamic> toJson() => {
  //   "id": id,
  //   "dress": dress,
  //   "featured": featured,
  //   "year_of_opening": yearOfOpening,
  //   "latitude": latitude,
  //   "rating": rating,
  //   "createdAt": createdAt.toIso8601String(),
  //   "city_name": cityName,
  //   "state_name": stateName,
  //   "country_name": countryName,
  //   "logo": logo,
  //   "state_id": stateId,
  //   "display_image": displayImage,
  //   "longitude": longitude,
  //   "updatedAt": updatedAt,
  //   "address": address,
  //   "schedule": schedule.toJson(),
  //   "website_url": websiteUrl,
  //   "name": name,
  //   "country_id": countryId,
  //   "sitting_tables": sittingTables.toJson(),
  //   "city_id": cityId,
  //   "manager_contacts": List<dynamic>.from(managerContacts.map((x) => x.toJson())),
  //   "photos": List<dynamic>.from(photos.map((x) => x.toJson())),
  //   "policies": List<dynamic>.from(policies.map((x) => x)),
  //   "open_now": openNow,
  //   "distance": distance,
  // };
}

class ManagerContact {
  ManagerContact({
    required this.phone,
    this.name,
    this.email,
  });

  final String phone;
  final String? name;
  final String? email;

  factory ManagerContact.fromJson(Map<String, dynamic> json) => ManagerContact(
        phone: json["phone"],
        name: json["name"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "phone": phone,
        "name": name,
        "email": email,
      };
}

class Photo {
  Photo({
    required this.featured,
    required this.url,
    required this.status,
  });

  final bool? featured;
  final String url;
  final String? status;

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        featured: json["featured"],
        url: json["url"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "featured": featured,
        "url": url,
        "status": status,
      };
}

class Schedule {
  Schedule();

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule();

  Map<String, dynamic> toJson() => {};
}
