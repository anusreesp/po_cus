
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:htp_customer/common/utils/timestamp_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'loyalty_points_model.g.dart';

@JsonSerializable()
@TimestampConverter()
class LoyaltyModel{
  final String? id;
  @JsonKey(name: 'booking_id')
  final String? bookingId;
  @JsonKey(name: 'booking_type')
  final String? bookingType;
  @JsonKey(name: 'club_id')
  final String? clubId;
  @JsonKey(name: 'club_name')
  final String? clubName;
  final DateTime? createdAt;
  @JsonKey(name: 'loyality_point')
  final double? loyaltyPoints;
  @JsonKey(name: 'transaction_type')
  final String? transactionType;
  @JsonKey(name: 'club_logo')
  final String? clubLogo;
  LoyaltyModel({
    this.id,
    this.bookingId,
    this.bookingType,
    this.clubId,
    required this.clubName,
    this.createdAt,
    required this.loyaltyPoints,
    this.transactionType,
    this.clubLogo
});
  factory LoyaltyModel.fromJson(Map<String, dynamic> json) => _$LoyaltyModelFromJson(json);
}