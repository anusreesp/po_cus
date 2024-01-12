// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppSettings _$AppSettingsFromJson(Map<String, dynamic> json) => AppSettings(
      latestAppVersion: json['latest_version_number'] as String?,
      latestBuildNumber: json['latest_build_number'] as String?,
    );

Map<String, dynamic> _$AppSettingsToJson(AppSettings instance) =>
    <String, dynamic>{
      'latest_build_number': instance.latestBuildNumber,
      'latest_version_number': instance.latestAppVersion,
    };
