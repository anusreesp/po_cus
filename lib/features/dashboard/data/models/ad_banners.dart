
import 'package:json_annotation/json_annotation.dart';
part 'ad_banners.g.dart';

@JsonSerializable()
class AdBanner{
  @JsonKey(name: 'display_image')
  final String image;
  @JsonKey(name: 'redirecting_url')
  final String? redirectUrl;
  @JsonKey(name: 'redirect_type', includeIfNull: true, defaultValue: 'external')
  final String? redirectType;

  AdBanner({
    required this.image,
    required this.redirectUrl,
    this.redirectType
});

  factory AdBanner.fromJson(Map<String, dynamic> json) => _$AdBannerFromJson(json);

  Map<String, dynamic> toJson() => _$AdBannerToJson(this);

}