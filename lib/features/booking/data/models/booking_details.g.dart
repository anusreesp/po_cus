// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingResponseData _$BookingResponseDataFromJson(Map<String, dynamic> json) =>
    BookingResponseData(
      success: json['success'] as bool?,
      data: BookingDetailsModel.fromJson(json['data'] as Map<String, dynamic>),
      qrCode: json['qr_code'] as String?,
      count: json['count'] as int?,
    );

Map<String, dynamic> _$BookingResponseDataToJson(
        BookingResponseData instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
      'qr_code': instance.qrCode,
      'count': instance.count,
    };

BookingDetailsModel _$BookingDetailsModelFromJson(Map<String, dynamic> json) =>
    BookingDetailsModel(
      amount: json['amount'] as int?,
      attendeeCount: json['attendee_count'] as int,
      bookingDate: DateTime.parse(json['booking_date'] as String),
      bookingId: json['booking_id'] as int,
      bookingStatus: json['status'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      termsAndConditions: json['terms_and_conditions'] as String? ?? '',
      countryTimeZone: json['country_time_zone'] as String,
      clubId: json['club_id'] as String?,
      clubName: json['club_name'] as String?,
      clubCity: json['clubCity'] as String?,
      expectedArrival: json['expected_arrival_time'] as String?,
      id: json['id'] as String,
      eventName: json['event_name'] as String?,
      clubLocation: json['club_location'] as String?,
      eventImage: json['event_display_image'] as String?,
      clubImage: json['club_display_image'] as String?,
      bookingType: json['booking_type'] as String?,
      people: (json['people'] as List<dynamic>?)
              ?.map((e) => e as Map<String, dynamic>)
              .toList() ??
          [],
      products: (json['preferred_products'] as List<dynamic>?)
              ?.map((e) => SelectedProducts.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      clubAddress: json['club_address'] as String?,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0,
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0,
      invoiceUrl: json['invoice_url'] as String? ?? '',
    );

Map<String, dynamic> _$BookingDetailsModelToJson(
        BookingDetailsModel instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'attendee_count': instance.attendeeCount,
      'booking_date': instance.bookingDate.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'booking_id': instance.bookingId,
      'status': instance.bookingStatus,
      'club_id': instance.clubId,
      'club_name': instance.clubName,
      'clubCity': instance.clubCity,
      'expected_arrival_time': instance.expectedArrival,
      'id': instance.id,
      'event_name': instance.eventName,
      'club_location': instance.clubLocation,
      'club_address': instance.clubAddress,
      'event_display_image': instance.eventImage,
      'club_display_image': instance.clubImage,
      'booking_type': instance.bookingType,
      'people': instance.people,
      'preferred_products': instance.products,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'invoice_url': instance.invoiceUrl,
      'terms_and_conditions': instance.termsAndConditions,
      'country_time_zone': instance.countryTimeZone,
    };

SelectedProducts _$SelectedProductsFromJson(Map<String, dynamic> json) =>
    SelectedProducts(
      brandName: json['brand_name'] as String,
      categoryId: json['category'] as String,
      categoryName: json['category_name'] as String,
      productType: json['product_type'] as String?,
    );

Map<String, dynamic> _$SelectedProductsToJson(SelectedProducts instance) =>
    <String, dynamic>{
      'brand_name': instance.brandName,
      'category': instance.categoryId,
      'category_name': instance.categoryName,
      'product_type': instance.productType,
    };
