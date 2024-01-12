// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'popups_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PopupsModels _$PopupsModelsFromJson(Map<String, dynamic> json) => PopupsModels(
      city: json['city'] as String,
      clubId: json['clubId'] as String?,
      clubEventName: json['club_event_name'] as String,
      id: json['id'] as String,
      image: json['image'] as String?,
      eventId: json['eventId'] as String?,
      redirectionType: json['redirectionType'] as String,
      redirectUrl: json['redirect_url'] as String?,
      internalRedirect: json['internal_redirect'] as bool?,
      startDate:
          const TimestampConverter().fromJson(json['start_date'] as Timestamp),
      endDate:
          const TimestampConverter().fromJson(json['end_date'] as Timestamp),
    );

Map<String, dynamic> _$PopupsModelsToJson(PopupsModels instance) =>
    <String, dynamic>{
      'city': instance.city,
      'clubId': instance.clubId,
      'club_event_name': instance.clubEventName,
      'eventId': instance.eventId,
      'id': instance.id,
      'image': instance.image,
      'redirectionType': instance.redirectionType,
      'redirect_url': instance.redirectUrl,
      'internal_redirect': instance.internalRedirect,
      'start_date': const TimestampConverter().toJson(instance.startDate),
      'end_date': const TimestampConverter().toJson(instance.endDate),
    };
