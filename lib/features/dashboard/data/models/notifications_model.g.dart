// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationsModel _$NotificationsModelFromJson(Map<String, dynamic> json) =>
    NotificationsModel(
      id: json['id'] as String?,
      title: json['title'] as String,
      notificationType: json['type'] as String?,
      body: json['body'] as String?,
      internalRedirect: json['internal_redirect'] as bool,
      readStatus: json['read_status'] as bool,
      url: json['url'] as String?,
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp),
    );

Map<String, dynamic> _$NotificationsModelToJson(NotificationsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'type': instance.notificationType,
      'internal_redirect': instance.internalRedirect,
      'read_status': instance.readStatus,
      'url': instance.url,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
    };
