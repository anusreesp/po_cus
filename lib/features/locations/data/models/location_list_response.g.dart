// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationData _$LocationDataFromJson(Map<String, dynamic> json) => LocationData(
      id: json['id'] as String,
      name: json['name'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      cityImage: json['city_image'] as String?,
      partyLocation: json['party_location'] as bool?,
      popularHometown: json['popular_hometown'] as bool?,
      countryName: json['country_name'] as String?,
    );

Map<String, dynamic> _$LocationDataToJson(LocationData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'city_image': instance.cityImage,
      'party_location': instance.partyLocation,
      'popular_hometown': instance.popularHometown,
      'country_name': instance.countryName,
    };
