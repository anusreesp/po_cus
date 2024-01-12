import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:htp_customer/common/utils/timestamp_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_model.g.dart';

@JsonSerializable()
@TimestampConverter()
class EventModel {
  final String id;
// @JsonKey(name: 'club') final dynamic clubRef;
  @JsonKey(name: 'date_and_time')
  final DateTime eventData;
  final String? description;
  @JsonKey(name: 'entry_per_head')
  final num entryPerHead;
  final String name;
  @JsonKey(name: 'display_image')
  final String? profileImage;
  final EventClub club;
  final bool? featured;
  @JsonKey(name: 'event_type')
  final String? eventType;
  @JsonKey(defaultValue: [], includeIfNull: true)
  final List<String> photos;
  @JsonKey(name: 'club_logo')
  final String? logo;

  EventModel(
      {required this.id,
// required this.clubRef,
      required this.name,
      required this.profileImage,
      this.description,
      required this.entryPerHead,
      required this.eventData,
      this.eventType,
      this.featured,
      this.logo,
      required this.club,
      required this.photos});
  factory EventModel.fromJson(Map<String, dynamic> json) =>
      _$EventModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventModelToJson(this);
}

@JsonSerializable()
class EventClub {
  final String id;
  final String name;
  final double? latitude;
  final double? longitude;
  @JsonKey(name: 'city_id')
  final String cityId;
  @JsonKey(name: 'city_name')
  final String cityName;
  final String? address;
  @JsonKey(defaultValue: 0, includeIfNull: true)
  final double distance;
  // final DateTime? createdAt;

  EventClub(
      {required this.id,
      required this.name,
      this.latitude,
      this.longitude,
      required this.cityId,
      required this.cityName,
      this.address,
      required this.distance
      // this.createdAt,
      });

  factory EventClub.fromJson(Map<String, dynamic> json) =>
      _$EventClubFromJson(json);

  Map<String, dynamic> toJson() => _$EventClubToJson(this);
}
