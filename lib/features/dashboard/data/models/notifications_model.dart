

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:htp_customer/common/utils/timestamp_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notifications_model.g.dart';

@JsonSerializable()
@TimestampConverter()
class NotificationsModel{
  final String? id;
  final String title;
  final String? body;
  @JsonKey(name: 'type')
  final String? notificationType;
  @JsonKey(name: 'internal_redirect')
  final bool internalRedirect;
  @JsonKey(name: 'read_status')
  final bool readStatus;
  final String? url;
  final DateTime createdAt;

  NotificationsModel({
    required this.id,
    required this.title,
    this.notificationType,
    this.body,
    required this.internalRedirect,
    required this.readStatus,
    this.url,
    required this.createdAt
});

  factory NotificationsModel.fromJson(Map<String, dynamic> json) => _$NotificationsModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationsModelToJson(this);

}