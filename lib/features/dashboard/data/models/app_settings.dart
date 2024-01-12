

import 'package:json_annotation/json_annotation.dart';
part 'app_settings.g.dart';

@JsonSerializable()
class AppSettings{
  @JsonKey(name: 'latest_build_number')
  final String? latestBuildNumber;
  @JsonKey(name: 'latest_version_number')
  final String? latestAppVersion;

  int get buildNumberInt => int.tryParse(latestBuildNumber ?? '0') ?? 0;

  AppSettings({
    this.latestAppVersion,
    this.latestBuildNumber
});

  factory AppSettings.fromJson(Map<String, dynamic> json) => _$AppSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$AppSettingsToJson(this);


}