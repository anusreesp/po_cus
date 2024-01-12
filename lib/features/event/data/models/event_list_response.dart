// To parse this JSON data, do
//
//     final eventListApiResponse = eventListApiResponseFromJson(jsonString);
//
// import 'dart:convert';
//
// EventListApiResponse eventListApiResponseFromJson(String str) => EventListApiResponse.fromJson(json.decode(str));
//
// String eventListApiResponseToJson(EventListApiResponse data) => json.encode(data.toJson());

class EventListApiResponse {
  EventListApiResponse({
    this.success,
    required this.message,
    this.count,
  });

  final bool? success;
  final List<EventDataApi> message;
  final int? count;

  factory EventListApiResponse.fromJson(Map<String, dynamic> json) =>
      EventListApiResponse(
        success: json["success"],
        message: json["message"] == null
            ? []
            : List<EventDataApi>.from(
                json["message"].map((x) => EventDataApi.fromJson(x))),
        count: json["count"],
      );

  // Map<String, dynamic> toJson() => {
  //   "success": success,
  //   "message": List<dynamic>.from(message.map((x) => x.toJson())),
  //   "count": count,
  // };
}

class EventDataApi {
  EventDataApi({
    required this.id,
    // required this.createdAt,
    required this.entryPerHead,
    required this.eventType,
    required this.name,
    required this.club,
    required this.description,
    // required this.photos,
    this.displayImage,
    // this.updatedAt,
    required this.dateAndTime,
    this.distance,
    required this.status,
  });

  final String id;
  // final DateTime createdAt;
  final int entryPerHead;
  final String? eventType;
  final String name;
  final Club? club;
  final String? description;
  // final List<dynamic> photos;
  final String? displayImage;
  // final dynamic updatedAt;
  final DateTime dateAndTime;
  final dynamic distance;
  final String status;

  factory EventDataApi.fromJson(Map<String, dynamic> json) => EventDataApi(
        id: json["id"],
        // createdAt: DateTime.parse(json["createdAt"]),
        entryPerHead: json["entry_per_head"],
        eventType: json["event_type"],
        name: json["name"],
        club: Club.fromJson(json["club"]),
        description: json["description"],
        // photos: List<dynamic>.from(json["photos"].map((x) => x)),
        displayImage: json["display_image"],
        // updatedAt: json["updatedAt"],
        dateAndTime: DateTime.parse(json["date_and_time"]),
        distance: json["distance"], status: json['status'],
      );

  // Map<String, dynamic> toJson() => {
  //   "id": id,
  //   "createdAt": createdAt.toIso8601String(),
  //   "entry_per_head": entryPerHead,
  //   "event_type": eventType,
  //   "name": name,
  //   "club": club.toJson(),
  //   "description": description,
  //   "photos": List<dynamic>.from(photos.map((x) => x)),
  //   "display_image": displayImage,
  //   "updatedAt": updatedAt,
  //   "date_and_time": dateAndTime.toIso8601String(),
  //   "distance": distance,
  // };
}

class Club {
  Club({
    required this.cityName,
    required this.address,
    required this.latitude,
    required this.name,
    required this.id,
    required this.cityId,
    required this.longitude,
  });

  final String cityName;
  final String? address;
  final double? latitude;
  final String name;
  final String id;
  final String? cityId;
  final double? longitude;

  factory Club.fromJson(Map<String, dynamic> json) => Club(
        cityName: json["city_name"],
        address: json["address"],
        latitude: json["latitude"],
        name: json["name"],
        id: json["id"],
        cityId: json["city_id"],
        longitude: json["longitude"],
      );

  // Map<String, dynamic> toJson() => {
  //   "city_name": cityName,
  //   "address": address,
  //   "latitude": latitude,
  //   "name": name,
  //   "id": id,
  //   "city_id": cityId,
  //   "longitude": longitude,
  // };
}
