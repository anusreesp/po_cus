// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventModel _$EventModelFromJson(Map<String, dynamic> json) => EventModel(
      id: json['id'] as String,
      name: json['name'] as String,
      profileImage: json['display_image'] as String?,
      description: json['description'] as String?,
      entryPerHead: json['entry_per_head'] as num,
      eventData: const TimestampConverter()
          .fromJson(json['date_and_time'] as Timestamp),
      eventType: json['event_type'] as String?,
      featured: json['featured'] as bool?,
      logo: json['club_logo'] as String?,
      club: EventClub.fromJson(json['club'] as Map<String, dynamic>),
      photos: (json['photos'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Map<String, dynamic> _$EventModelToJson(EventModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date_and_time': const TimestampConverter().toJson(instance.eventData),
      'description': instance.description,
      'entry_per_head': instance.entryPerHead,
      'name': instance.name,
      'display_image': instance.profileImage,
      'club': instance.club,
      'featured': instance.featured,
      'event_type': instance.eventType,
      'photos': instance.photos,
      'club_logo': instance.logo,
    };

EventClub _$EventClubFromJson(Map<String, dynamic> json) => EventClub(
      id: json['id'] as String,
      name: json['name'] as String,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      cityId: json['city_id'] as String,
      cityName: json['city_name'] as String,
      address: json['address'] as String?,
      distance: (json['distance'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$EventClubToJson(EventClub instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'city_id': instance.cityId,
      'city_name': instance.cityName,
      'address': instance.address,
      'distance': instance.distance,
    };
