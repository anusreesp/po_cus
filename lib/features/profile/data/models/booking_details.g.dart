// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingData _$BookingDataFromJson(Map<String, dynamic> json) => BookingData(
      id: json['id'] as String,
      bookingId: json['booking_id'] as int,
      countryTimeZone: json['country_time_zone'] as String,
      clubName: json['club_name'] as String?,
      bookingDate: const TimestampConverter()
          .fromJson(json['booking_date'] as Timestamp),
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp),
      bookingType: json['booking_type'] as String,
      eventName: json['event_name'] as String?,
      clubLocation: json['club_location'] as String?,
      eventImage: json['event_display_image'] as String?,
      clubImage: json['club_display_image'] as String?,
      expectedArrivalTime: json['expected_arrival_time'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$BookingDataToJson(BookingData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'booking_id': instance.bookingId,
      'booking_date': const TimestampConverter().toJson(instance.bookingDate),
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'club_name': instance.clubName,
      'booking_type': instance.bookingType,
      'event_name': instance.eventName,
      'club_location': instance.clubLocation,
      'event_display_image': instance.eventImage,
      'club_display_image': instance.clubImage,
      'expected_arrival_time': instance.expectedArrivalTime,
      'status': instance.status,
      'country_time_zone': instance.countryTimeZone,
    };
