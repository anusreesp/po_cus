// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loyalty_points_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoyaltyModel _$LoyaltyModelFromJson(Map<String, dynamic> json) => LoyaltyModel(
      id: json['id'] as String?,
      bookingId: json['booking_id'] as String?,
      bookingType: json['booking_type'] as String?,
      clubId: json['club_id'] as String?,
      clubName: json['club_name'] as String?,
      createdAt: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['createdAt'], const TimestampConverter().fromJson),
      loyaltyPoints: (json['loyality_point'] as num?)?.toDouble(),
      transactionType: json['transaction_type'] as String?,
      clubLogo: json['club_logo'] as String?,
    );

Map<String, dynamic> _$LoyaltyModelToJson(LoyaltyModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'booking_id': instance.bookingId,
      'booking_type': instance.bookingType,
      'club_id': instance.clubId,
      'club_name': instance.clubName,
      'createdAt': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.createdAt, const TimestampConverter().toJson),
      'loyality_point': instance.loyaltyPoints,
      'transaction_type': instance.transactionType,
      'club_logo': instance.clubLogo,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
