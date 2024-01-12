// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'membership_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MembershipData _$MembershipDataFromJson(Map<String, dynamic> json) =>
    MembershipData(
      id: json['id'] as String,
      level: json['level'] as int,
      name: json['name'] as String,
      image: json['display_image'] as String,
      flatImage: json['flat_image'] as String,
      benefits: (json['benifits'] as List<dynamic>?)
              ?.map((e) => Benefit.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      planList: (json['plans'] as List<dynamic>)
          .map((e) => Plan.fromJson(e as Map<String, dynamic>))
          .toList(),
      membershipCalculations: json['membership_calculations'] == null
          ? null
          : MembershipCalculations.fromJson(
              json['membership_calculations'] as Map<String, dynamic>),
      tagline: TagLine.fromJson(json['tagline'] as Map<String, dynamic>),
      isActive: json['is_active'] as bool,
    );

Benefit _$BenefitFromJson(Map<String, dynamic> json) => Benefit(
      title: json['title'] as String,
      description: json['description'] as String,
    );

TagLine _$TagLineFromJson(Map<String, dynamic> json) => TagLine(
      title: json['tagline_title'] as String,
      taglines: (json['taglines'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Plan _$PlanFromJson(Map<String, dynamic> json) => Plan(
      duration: json['duration'] as num,
      planUniqueId: json['plan_unique_id'] as String,
      price: json['price'] as num,
    );

MembershipCalculations _$MembershipCalculationsFromJson(
        Map<String, dynamic> json) =>
    MembershipCalculations(
      complimentaryGuests: json['complimentary_guest'] as int? ?? 0,
      tableBookingUpToHours: json['table_booking_up_to_hours'] as int? ?? -1,
    );
