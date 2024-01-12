// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fire_club_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClubDataModel _$ClubDataModelFromJson(Map<String, dynamic> json) =>
    ClubDataModel(
      address: json['address'] as String,
      cityId: json['city_id'] as String,
      cityName: json['city_name'] as String,
      countryId: json['country_id'] as String?,
      countryName: json['country_name'] as String?,
      dress: json['dress'] as String?,
      id: json['id'] as String,
      name: json['name'] as String,
      photos: json['photos'] as List<dynamic>? ?? [],
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      schedule: json['schedule'] as Map<String, dynamic>,
      sittingTables: (json['sitting_tables'] as List<dynamic>?)
              ?.map((e) => SittingTable.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      ladiesNight: (json['ladies_night'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      stateId: json['state_id'] as String?,
      stateName: json['state_name'] as String?,
      websiteUrl: json['website_url'] as String?,
      displayImage: json['display_image'] as String?,
      rating: json['rating'],
      slots: (json['slots'] as List<dynamic>?)
              ?.map((e) => e as Map<String, dynamic>)
              .toList() ??
          [],
      logo: json['logo'] as String?,
      featured: json['featured'] as bool? ?? false,
      distance: (json['distance'] as num?)?.toDouble() ?? 0,
      description: json['description'] as String? ?? '',
      clubTimeZone: json['time_zone'] as String? ?? '',
      termsAndConditions: json['terms_and_conditions'] as String? ?? '',
    );

Map<String, dynamic> _$ClubDataModelToJson(ClubDataModel instance) =>
    <String, dynamic>{
      'address': instance.address,
      'city_id': instance.cityId,
      'city_name': instance.cityName,
      'country_id': instance.countryId,
      'country_name': instance.countryName,
      'display_image': instance.displayImage,
      'dress': instance.dress,
      'id': instance.id,
      'name': instance.name,
      'photos': instance.photos,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'schedule': instance.schedule,
      'sitting_tables': instance.sittingTables,
      'ladies_night': instance.ladiesNight,
      'state_id': instance.stateId,
      'state_name': instance.stateName,
      'website_url': instance.websiteUrl,
      'rating': instance.rating,
      'slots': instance.slots,
      'logo': instance.logo,
      'featured': instance.featured,
      'distance': instance.distance,
      'description': instance.description,
      'time_zone': instance.clubTimeZone,
      'terms_and_conditions': instance.termsAndConditions,
    };

SittingTable _$SittingTableFromJson(Map<String, dynamic> json) => SittingTable(
      minimumSpent: json['minimum_spent'] as num?,
      count: json['count'] as int? ?? 0,
      name: json['name'] as String? ?? 'Untitled',
      seaterCount: json['seater_count'] as int?,
    );

Map<String, dynamic> _$SittingTableToJson(SittingTable instance) =>
    <String, dynamic>{
      'minimum_spent': instance.minimumSpent,
      'count': instance.count,
      'name': instance.name,
      'seater_count': instance.seaterCount,
    };

SlotModel _$SlotModelFromJson(Map<String, dynamic> json) => SlotModel(
      slotTime: json['slot_time'] as String? ?? '',
      timeZone: json['zone'] as String? ?? '',
    );

Map<String, dynamic> _$SlotModelToJson(SlotModel instance) => <String, dynamic>{
      'slot_time': instance.slotTime,
      'zone': instance.timeZone,
    };
