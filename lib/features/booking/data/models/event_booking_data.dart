
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:htp_customer/common/utils/timestamp_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_booking_data.g.dart';

@JsonSerializable()
class EventBookingData{
  final dynamic amount;
  @JsonKey(name: 'attendee_count') final int attendeeCount;
  @TimestampConverter()
  @JsonKey(name: 'booking_date') final DateTime bookingDate;
  @JsonKey(name: 'booking_id') final int bookingId;
  @JsonKey(name: 'booking_status') final String bookingStatus;
  @JsonKey(name: 'event')  final dynamic eventRef;
  final String id;
  @JsonKey(name: 'user') final dynamic userRef;

  EventBookingData({
    this.amount,
    required this.attendeeCount,
    required this.bookingDate,
    required this.bookingId,
    required this.bookingStatus,
    required this.eventRef,
    required this.id,
    this.userRef
});

  factory EventBookingData.fromJson(Map<String, dynamic> json) => _$EventBookingDataFromJson(json);


}