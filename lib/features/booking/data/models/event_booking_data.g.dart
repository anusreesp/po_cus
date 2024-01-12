// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_booking_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventBookingData _$EventBookingDataFromJson(Map<String, dynamic> json) =>
    EventBookingData(
      amount: json['amount'],
      attendeeCount: json['attendee_count'] as int,
      bookingDate: const TimestampConverter()
          .fromJson(json['booking_date'] as Timestamp),
      bookingId: json['booking_id'] as int,
      bookingStatus: json['booking_status'] as String,
      eventRef: json['event'],
      id: json['id'] as String,
      userRef: json['user'],
    );

Map<String, dynamic> _$EventBookingDataToJson(EventBookingData instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'attendee_count': instance.attendeeCount,
      'booking_date': const TimestampConverter().toJson(instance.bookingDate),
      'booking_id': instance.bookingId,
      'booking_status': instance.bookingStatus,
      'event': instance.eventRef,
      'id': instance.id,
      'user': instance.userRef,
    };
