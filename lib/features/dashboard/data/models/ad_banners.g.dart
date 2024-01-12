// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ad_banners.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdBanner _$AdBannerFromJson(Map<String, dynamic> json) => AdBanner(
      image: json['display_image'] as String,
      redirectUrl: json['redirecting_url'] as String?,
      redirectType: json['redirect_type'] as String? ?? 'external',
    );

Map<String, dynamic> _$AdBannerToJson(AdBanner instance) => <String, dynamic>{
      'display_image': instance.image,
      'redirecting_url': instance.redirectUrl,
      'redirect_type': instance.redirectType,
    };
