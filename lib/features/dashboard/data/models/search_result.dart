import 'dart:convert';
import '../../../event/data/models/event_model.dart';

enum SearchType {event, club, location}

// class SearchResult{
//   final String id;
//   final String name;
//   final String? city;
//   final SearchType type;
//   // final EventModel? eventModel;
//
//   SearchResult({
//     required this.id,
//     required this.name,
//     this.city,
//     required this.type});
// }


SearchResultResponse searchResultResponseFromJson(String str) => SearchResultResponse.fromJson(json.decode(str));

String searchResultResponseToJson(SearchResultResponse data) => json.encode(data.toJson());

class SearchResultResponse {
  final bool success;
  final List<SearchResult> data;

  SearchResultResponse({
    required this.success,
    required this.data,
  });

  SearchResultResponse copyWith({
    bool? success,
    List<SearchResult>? data,
  }) =>
      SearchResultResponse(
        success: success ?? this.success,
        data: data ?? this.data,
      );

  factory SearchResultResponse.fromJson(Map<String, dynamic> json) => SearchResultResponse(
    success: json["success"],
    data: json.containsKey('data')
        ? List<SearchResult>.from(json["data"].map((x) => SearchResult.fromJson(x)))
        : [],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class SearchResult {
  final String id;
  final SearchType type;
  final String name;
  final String? cityName;
  final String? cityId;
  final String? countryId;
  final String? countryName;
  // final String? partyLocation;
  // final bool? popularHometown;

  SearchResult({
    required this.id,
    required this.type,
    required this.name,
    this.cityName,
    this.cityId,
    this.countryId,
    this.countryName,
    // this.partyLocation,
    // this.popularHometown,
  });

  // SearchResult copyWith({
  //   String? id,
  //   SearchType? type,
  //   String? name,
  //   String? cityName,
  //   String? cityId,
  //   String? countryId,
  //   String? countryName,
  //   String? partyLocation,
  //   bool? popularHometown,
  // }) =>
  //     SearchResult(
  //       id: id ?? this.id,
  //       type: type ?? this.type,
  //       name: name ?? this.name,
  //       cityName: cityName ?? this.cityName,
  //       cityId: cityId ?? this.cityId,
  //       countryId: countryId ?? this.countryId,
  //       countryName: countryName ?? this.countryName,
  //       partyLocation: partyLocation ?? this.partyLocation,
  //       popularHometown: popularHometown ?? this.popularHometown,
  //     );

  factory SearchResult.fromJson(Map<String, dynamic> json) => SearchResult(
    id: json["id"],
    type: typeValues.map[json["type"]]!,
    name: json["name"],
    cityName: json["city_name"],
    cityId: json["city_id"],
    countryId: json["country_id"],
    countryName: json["country_name"],
    // partyLocation: json["party_location"],
    // popularHometown: json["popular_hometown"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": typeValues.reverse[type],
    "name": name,
    "city_name": cityName,
    "city_id": cityId,
    "country_id": countryId,
    "country_name": countryName,
    // "party_location": partyLocation,
    // "popular_hometown": popularHometown,
  };
}

// enum Type {
//   CLUB,
//   EVENT,
//   LOCATION
// }

final typeValues = EnumValues({
  "club": SearchType.club,
  "event": SearchType.event,
  "location": SearchType.location
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
