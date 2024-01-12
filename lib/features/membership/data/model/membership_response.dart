import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'membership_response.g.dart';

@JsonSerializable(createToJson: false)
class MembershipData {
  MembershipData({
    required this.id,
    required this.level,
    required this.name,
    required this.image,
    required this.flatImage,
    // required this.pricePerYear,
    required this.benefits,
    required this.planList,
    this.membershipCalculations,
    required this.tagline,
    this.isActive,
  });

  final String id;
  final int level;
  final String name;
  @JsonKey(name: 'display_image')
  final String image;
  @JsonKey(name: 'flat_image')
  final String flatImage;
  @JsonKey(name: 'benifits', defaultValue: [], includeIfNull: true)
  final List<Benefit> benefits;
  @JsonKey(name: 'plans')
  final List<Plan> planList;
  @JsonKey(name: 'membership_calculations')
  final MembershipCalculations? membershipCalculations;
  final TagLine tagline;
  final bool? isActive;

  factory MembershipData.fromJson(Map<String, dynamic> json) =>
      _$MembershipDataFromJson(json);
}

@JsonSerializable(createToJson: false)
class Benefit {
  final String title;
  final String description;
  Benefit({required this.title, required this.description});

  factory Benefit.fromJson(Map<String, dynamic> json) =>
      _$BenefitFromJson(json);
}

@JsonSerializable(createToJson: false)
class TagLine {
  @JsonKey(name: 'tagline_title')
  final String title;
  @JsonKey(defaultValue: [], includeIfNull: true)
  final List<String> taglines;

  TagLine({required this.title, required this.taglines});

  factory TagLine.fromJson(Map<String, dynamic> json) =>
      _$TagLineFromJson(json);
}

@JsonSerializable(createToJson: false)
class Plan {
  final num duration;
  @JsonKey(name: 'plan_unique_id')
  final String planUniqueId;
  final num price;

  String get formattedPrice => NumberFormat('#,##0', 'en_US').format(price);

  String get planDescription => 'USD \$ $formattedPrice / $durationText';

  String get durationText {
    if (duration == 1) {
      return '$duration Months';
    }

    if (duration < 12) {
      return '$duration Months';
    }

    final int months = (duration % 12).toInt();
    final int year = duration ~/ 12;

    if (months == 0) {
      if (year == 1) {
        return 'Year';
      } else {
        return '$year Years';
      }
    } else {
      if (months <= 1) {
        return '$year Years $months Month';
      } else {
        return '$year Years $months Month';
      }
    }
  }

  Plan(
      {required this.duration,
      required this.planUniqueId,
      required this.price});

  factory Plan.fromJson(Map<String, dynamic> json) => _$PlanFromJson(json);
}

@JsonSerializable(createToJson: false)
class MembershipCalculations {
  @JsonKey(
      name: 'table_booking_up_to_hours', defaultValue: -1, includeIfNull: true)
  final int tableBookingUpToHours;

  @JsonKey(name: 'complimentary_guest', defaultValue: 0, includeIfNull: true)
  final int complimentaryGuests;
  MembershipCalculations({
    required this.complimentaryGuests,
    required this.tableBookingUpToHours,
  });

  factory MembershipCalculations.fromJson(Map<String, dynamic> json) =>
      _$MembershipCalculationsFromJson(json);
}
