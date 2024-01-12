import 'package:json_annotation/json_annotation.dart';

part 'fire_club_details.g.dart';

class FireClubDetails {
  final ClubDataModel data;
  // final List<String> photos;
  // final String? cityName;

  FireClubDetails({required this.data});
}

@JsonSerializable()
// @TimestampConverter()
class ClubDataModel {
  final String address;
  @JsonKey(name: 'city_id')
  final String cityId;
  @JsonKey(name: 'city_name')
  final String cityName;
  @JsonKey(name: 'country_id')
  final String? countryId;
  @JsonKey(name: 'country_name')
  final String? countryName;
  // @JsonKey(name:'created_at')
  // final DateTime createdAt;
  @JsonKey(name: 'display_image')
  final String? displayImage;
  final String? dress;
  final String id;
  // final ManagerContact managerContact;
  final String name;
  @JsonKey(defaultValue: [])
  final List<dynamic> photos;
  final double? latitude;
  final double? longitude;
  final Map<String, dynamic> schedule;
  @JsonKey(name: 'sitting_tables', defaultValue: [], includeIfNull: true)
  final List<SittingTable> sittingTables;
  @JsonKey(name: 'ladies_night', defaultValue: [], includeIfNull: true)
  final List<String> ladiesNight;

  @JsonKey(name: 'state_id')
  final String? stateId;
  @JsonKey(name: 'state_name')
  final String? stateName;
  // @JsonKey(name:'updated_At')
  // final String updatedAt;
  @JsonKey(name: 'website_url')
  final String? websiteUrl;
  final dynamic rating;
  @JsonKey(includeIfNull: true, defaultValue: [])
  final List<Map> slots;
  final String? logo;
  @JsonKey(defaultValue: false, includeIfNull: true)
  final bool featured;
  @JsonKey(defaultValue: 0, includeIfNull: true)
  final double distance;
  @JsonKey(defaultValue: "", includeIfNull: true)
  final String description;
  @JsonKey(name: 'time_zone', defaultValue: '')
  final String clubTimeZone;
  @JsonKey(name: 'terms_and_conditions', defaultValue: '')
  final String termsAndConditions;

  ClubDataModel(
      {
      // required this.managerContact,
      required this.address,
      required this.cityId,
      required this.cityName,
      this.countryId,
      this.countryName,
      this.dress,
      required this.id,
      required this.name,
      required this.photos,
      this.latitude,
      this.longitude,
      required this.schedule,
      required this.sittingTables,
      required this.ladiesNight,
      this.stateId,
      this.stateName,
      // required this.updatedAt,
      this.websiteUrl,
      // required this.createdAt,
      this.displayImage,
      this.rating,
      required this.slots,
      this.logo,
      required this.featured,
      required this.distance,
      required this.description,
      required this.clubTimeZone,
      required this.termsAndConditions});
  factory ClubDataModel.fromJson(Map<String, dynamic> json) =>
      _$ClubDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$ClubDataModelToJson(this);

  ///Only data required to save as favorite is converted into json
  Map<String, dynamic> toFavJson() => <String, dynamic>{
        'address': address,
        'city_id': cityId,
        'city_name': cityName,
        'country_id': countryId,
        'country_name': countryName,
        'display_image': displayImage,
        'dress': dress,
        'id': id,
        'name': name,
        // 'photos': photos,
        'latitude': latitude,
        'longitude': longitude,
        'schedule': schedule,
        'state_id': stateId,
        'state_name': stateName,
        'website_url': websiteUrl,
        'rating': rating,
      };
}

@JsonSerializable()
class SittingTable {
  @JsonKey(name: 'minimum_spent')
  final num? minimumSpent;
  @JsonKey(defaultValue: 0, includeIfNull: true)
  final int count;
  @JsonKey(defaultValue: 'Untitled', includeIfNull: true)
  final String name;
  @JsonKey(name: 'seater_count')
  final int? seaterCount;

  SittingTable(
      {this.minimumSpent,
      required this.count,
      required this.name,
      this.seaterCount});

  factory SittingTable.fromJson(Map<String, dynamic> json) =>
      _$SittingTableFromJson(json);

  Map<String, dynamic> toJson() => _$SittingTableToJson(this);
}

@JsonSerializable()
class SlotModel {
  @JsonKey(name: 'slot_time', includeIfNull: true, defaultValue: '')
  final String slotTime;
  @JsonKey(name: 'zone', includeIfNull: true, defaultValue: '')
  final String timeZone;

  SlotModel({required this.slotTime, required this.timeZone});
}

// class ManagerContact {
//   ManagerContact({
//     required this.phone,
//     this.name,
//     this.email,
//   });
//
//   final String phone;
//   final String? name;
//   final String? email;
//   factory ClubDataModel.fromJson(Map<String, dynamic> json) => _$ManagerContactFromJson(json);
//
//   Map<String, dynamic> toJson() => _$ManagerContactToJson(this);
// }