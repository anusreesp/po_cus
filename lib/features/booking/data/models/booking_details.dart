import 'package:json_annotation/json_annotation.dart';

part 'booking_details.g.dart';

@JsonSerializable()
class BookingResponseData {
  BookingResponseData({
    required this.success,
    required this.data,
    required this.qrCode,
    required this.count,
  });

  final bool? success;
  final BookingDetailsModel data;
  @JsonKey(name: 'qr_code')
  final String? qrCode;
  final int? count;

  factory BookingResponseData.fromJson(Map<String, dynamic> json) =>
      _$BookingResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$BookingResponseDataToJson(this);
}

@JsonSerializable()
class BookingDetailsModel {
  final int? amount;
  @JsonKey(name: 'attendee_count')
  final int attendeeCount;
  // @TimestampConverter()
  @JsonKey(name: 'booking_date')
  final DateTime bookingDate;
  @JsonKey(name: 'createdAt')
  final DateTime createdAt;
  @JsonKey(name: 'booking_id')
  final int bookingId;
  @JsonKey(name: 'status')
  final String? bookingStatus;
  // @JsonKey(name: 'club') final dynamic clubRef;
  @JsonKey(name: 'club_id')
  final String? clubId;
  @JsonKey(name: 'club_name')
  final String? clubName;
  final String? clubCity;
  @JsonKey(name: 'expected_arrival_time')
  final String? expectedArrival;
  final String id;
  @JsonKey(name: 'event_name')
  final String? eventName;
  // @JsonKey(name: 'user') final dynamic userRef;
  // final String? status;
  // @JsonKey(name: 'qr_code') final String? qrCode;
  @JsonKey(name: 'club_location')
  final String? clubLocation;
  @JsonKey(name: 'club_address')
  final String? clubAddress;
  @JsonKey(name: 'event_display_image')
  final String? eventImage;
  @JsonKey(name: 'club_display_image')
  final String? clubImage;
  @JsonKey(name: 'booking_type')
  final String? bookingType;
  @JsonKey(includeIfNull: true, defaultValue: [])
  final List<Map> people;
  @JsonKey(name: 'preferred_products', includeIfNull: true, defaultValue: [])
  final List<SelectedProducts> products;
  @JsonKey(includeIfNull: true, defaultValue: 0)
  final double? longitude;
  @JsonKey(includeIfNull: true, defaultValue: 0)
  final double? latitude;
  @JsonKey(name: 'invoice_url', includeIfNull: true, defaultValue: '')
  final String? invoiceUrl;
  @JsonKey(name: 'terms_and_conditions', includeIfNull: true, defaultValue: '')
  final String termsAndConditions;
  @JsonKey(name: 'country_time_zone')
  final String countryTimeZone;

  BookingDetailsModel({
    this.amount,
    required this.attendeeCount,
    required this.bookingDate,
    required this.bookingId,
    required this.bookingStatus,
    required this.createdAt,
    required this.termsAndConditions,
    required this.countryTimeZone,

    // this.clubRef,
    this.clubId,
    this.clubName,
    this.clubCity,
    this.expectedArrival,
    required this.id,
    this.eventName,
    this.clubLocation,
    this.eventImage,
    this.clubImage,
    this.bookingType,
    required this.people,
    required this.products,
    required this.clubAddress,
    required this.longitude,
    required this.latitude,
    required this.invoiceUrl,

    // this.status,
    // this.qrCode
    // this.userRef
  });

  factory BookingDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$BookingDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookingDetailsModelToJson(this);
}

@JsonSerializable()
class SelectedProducts {
  @JsonKey(name: 'brand_name')
  final String brandName;
  @JsonKey(name: 'category')
  final String categoryId;
  @JsonKey(name: 'category_name')
  final String categoryName;
  @JsonKey(name: 'product_type')
  final String? productType;

  SelectedProducts(
      {required this.brandName,
      required this.categoryId,
      required this.categoryName,
      this.productType});

  factory SelectedProducts.fromJson(Map<String, dynamic> json) =>
      _$SelectedProductsFromJson(json);

  Map<String, dynamic> toJson() => _$SelectedProductsToJson(this);
}


// To parse this JSON data, do
//
//     final bookingDetailsResponse = bookingDetailsResponseFromJson(jsonString);

// import 'dart:convert';
//
// BookingDetailsResponse bookingDetailsResponseFromJson(String str) => BookingDetailsResponse.fromJson(json.decode(str));
//
// String bookingDetailsResponseToJson(BookingDetailsResponse data) => json.encode(data.toJson());
//
// class BookingDetailsResponse {
//   BookingDetailsResponse({
//     required this.success,
//     required this.data,
//     required this.count,
//   });
//
//   final bool success;
//   final List<BookingData> data;
//   final int count;
//
//   factory BookingDetailsResponse.fromJson(Map<String, dynamic> json) => BookingDetailsResponse(
//     success: json["success"],
//     data: List<BookingData>.from(json["data"].map((x) => BookingData.fromJson(x))),
//     count: json["count"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "success": success,
//     "data": List<dynamic>.from(data.map((x) => x.toJson())),
//     "count": count,
//   };
// }
//
// class BookingData {
//   BookingData({
//     required this.id,
//     required this.user,
//     required this.club,
//     required this.amount,
//     required this.bookingDate,
//     required this.attendeeCount,
//     required this.bookingId,
//     required this.bookingStatus,
//     required this.checkedIn,
//     required this.qrCode,
//     required this.clubName,
//     required this.clubAddress,
//     required this.clubCity,
//     required this.userName,
//     required this.userProfileImage,
//     required this.bookingPeople,
//     required this.preferredProducts,
//   });
//
//   final String id;
//   final String user;
//   final String club;
//   final int amount;
//   final DateTime bookingDate;
//   final int attendeeCount;
//   final String bookingId;
//   final String bookingStatus;
//   final bool checkedIn;
//   final String qrCode;
//   final String clubName;
//   final String clubAddress;
//   final String clubCity;
//   final String userName;
//   final String userProfileImage;
//   final List<BookingPerson> bookingPeople;
//   final List<PreferredProduct> preferredProducts;
//
//   factory BookingData.fromJson(Map<String, dynamic> json) => BookingData(
//     id: json["id"],
//     user: json["user"],
//     club: json["club"],
//     amount: json["amount"],
//     bookingDate: DateTime.parse(json["booking_date"]),
//     attendeeCount: json["attendee_count"],
//     bookingId: json["booking_id"],
//     bookingStatus: json["booking_status"],
//     checkedIn: json["checked_in"],
//     qrCode: json["qr_code"],
//     clubName: json["club_name"],
//     clubAddress: json["club_address"],
//     clubCity: json["club_city"],
//     userName: json["user_name"],
//     userProfileImage: json["user_profile_image"],
//     bookingPeople: List<BookingPerson>.from(json["booking_people"].map((x) => BookingPerson.fromJson(x))),
//     preferredProducts: List<PreferredProduct>.from(json["preferred_products"].map((x) => PreferredProduct.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "user": user,
//     "club": club,
//     "amount": amount,
//     "booking_date": "${bookingDate.year.toString().padLeft(4, '0')}-${bookingDate.month.toString().padLeft(2, '0')}-${bookingDate.day.toString().padLeft(2, '0')}",
//     "attendee_count": attendeeCount,
//     "booking_id": bookingId,
//     "booking_status": bookingStatus,
//     "checked_in": checkedIn,
//     "qr_code": qrCode,
//     "club_name": clubName,
//     "club_address": clubAddress,
//     "club_city": clubCity,
//     "user_name": userName,
//     "user_profile_image": userProfileImage,
//     "booking_people": List<dynamic>.from(bookingPeople.map((x) => x.toJson())),
//     "preferred_products": List<dynamic>.from(preferredProducts.map((x) => x.toJson())),
//   };
// }
//
// class BookingPerson {
//   BookingPerson({
//     required this.id,
//     required this.name,
//     required this.age,
//   });
//
//   final String id;
//   final String name;
//   final int age;
//
//   factory BookingPerson.fromJson(Map<String, dynamic> json) => BookingPerson(
//     id: json["id"],
//     name: json["name"],
//     age: json["age"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "age": age,
//   };
// }
//
// class PreferredProduct {
//   PreferredProduct({
//     required this.id,
//     required this.brand,
//     required this.category,
//     required this.brandName,
//     required this.categoryName,
//   });
//
//   final String id;
//   final String brand;
//   final String category;
//   final String brandName;
//   final String categoryName;
//
//   factory PreferredProduct.fromJson(Map<String, dynamic> json) => PreferredProduct(
//     id: json["id"],
//     brand: json["brand"],
//     category: json["category"],
//     brandName: json["brand_name"],
//     categoryName: json["category_name"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "brand": brand,
//     "category": category,
//     "brand_name": brandName,
//     "category_name": categoryName,
//   };
// }
