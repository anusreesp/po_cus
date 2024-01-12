import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../common/utils/timestamp_converter.dart';

part 'booking_details.g.dart';

@JsonSerializable()
@TimestampConverter()
class BookingData {
  BookingData(
      {required this.id,
      required this.bookingId,
      required this.countryTimeZone,
      this.clubName,
      // required this.displayImage,
      required this.bookingDate,
      required this.createdAt,
      required this.bookingType,
      this.eventName,
      this.clubLocation,
      this.eventImage,
      this.clubImage,
      this.expectedArrivalTime,
      this.status});

  final String id;
  @JsonKey(name: 'booking_id')
  final int bookingId;
  @JsonKey(name: 'booking_date')
  final DateTime bookingDate;
  @JsonKey(name: 'createdAt')
  final DateTime createdAt;
  @JsonKey(name: 'club_name')
  final String? clubName;
  // final String? displayImage;
  @JsonKey(name: 'booking_type')
  final String bookingType;
  @JsonKey(name: 'event_name')
  final String? eventName;
  @JsonKey(name: 'club_location')
  final String? clubLocation;
  @JsonKey(name: 'event_display_image')
  final String? eventImage;
  @JsonKey(name: 'club_display_image')
  final String? clubImage;
  @JsonKey(name: 'expected_arrival_time')
  final String? expectedArrivalTime;
  final String? status;
  @JsonKey(name: 'country_time_zone')
  final String countryTimeZone;

  DateTime get bookingDateOnly => DateTime(bookingDate.toUtc().year,
      bookingDate.toUtc().month, bookingDate.toUtc().day);

  factory BookingData.fromJson(Map<String, dynamic> json) =>
      _$BookingDataFromJson(json);

  Map<String, dynamic> toJson() => _$BookingDataToJson(this);
}
