import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:htp_customer/common/utils/member_utils.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../common/utils/timestamp_converter.dart';
import '../../controller/profile_update_controller.dart';

part 'profile_response.g.dart';

class UserProfiledData {
  final ProfileData profileData;
  final UserEditModel userEditModel;

  UserProfiledData(this.profileData, this.userEditModel);
}

@JsonSerializable()
@TimestampConverter()
class ProfileData {
  final String name;
  final String id;
  final String? gender;
  @JsonKey(name: 'profile_image')
  final String? profileImage;
  @JsonKey(name: 'home_city')
  final int? homeCity;
  @JsonKey(name: 'home_city_name')
  final String? homeCityName;
  @JsonKey(name: 'home_state')
  final int? homeState;
  @JsonKey(name: 'home_state_name')
  final String? homeStateName;
  @JsonKey(name: 'home_country')
  final int? homeCountry;
  @JsonKey(name: 'home_country_name')
  final String? homeCountryName;
  final String email;
  @JsonKey(name: 'contacts', defaultValue: [])
  final List<Contacts> contacts;
  @JsonKey(name: 'active_membership_id')
  final String? activeMembershipId;
  @JsonKey(name: 'active_membership_name')
  final String? activeMembershipName;
  @JsonKey(name: 'last_membership_id')
  final String? lastMembershipId;
  @JsonKey(name: 'last_membership_name')
  final String? lastMembershipName;
  @JsonKey(name: 'kyc_status')
  final String? kycStatus;
  @JsonKey(name: 'active_membership_card_no')
  final String? activeMembershipCardNo;
  @JsonKey(name: 'mebership_starts_at')
  final DateTime? membershipStartDate;
  @JsonKey(name: 'mebership_ends_at')
  final DateTime? membershipEndDate;
  @JsonKey(
      name: 'verification_status',
      defaultValue: VerificationStatus.notVerified,
      includeIfNull: true)
  final VerificationStatus verificationStatus;
  @JsonKey(name: 'dob')
  final String? dob;
  @JsonKey(name: 'loyality_point')
  final double loyaltyPoints;

  // final DateTime createdAt;
  ProfileData(
      {required this.name,
      required this.id,
      required this.gender,
      required this.dob,
      this.profileImage,
      this.homeCity,
      this.homeCityName,
      this.homeState,
      this.homeStateName,
      this.homeCountry,
      this.homeCountryName,
      required this.email,
      required this.contacts,
      this.activeMembershipId,
      this.activeMembershipName,
      this.lastMembershipId,
      this.lastMembershipName,
      required this.verificationStatus,
      this.loyaltyPoints = 0,
      this.kycStatus,
      this.activeMembershipCardNo,
      this.membershipEndDate,
      this.membershipStartDate
      // required this.createdAt,
      });

  bool get hasActiveMembership =>
      activeMembershipId != null && activeMembershipId!.isNotEmpty;

  bool get isKycAvailable => kycStatus == 'Approved' || kycStatus == 'Pending';

  bool get membershipExpired =>
      activeMembershipId == null && lastMembershipId != null;

  MembershipType get membershipType =>
      MemberUtils.getMembershipTypeById(activeMembershipId);

  factory ProfileData.fromJson(Map<String, dynamic> json) =>
      _$ProfileDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserEditModel {
  final String? name;
  final String? gender;
  @JsonKey(name: 'smoking_habbit')
  final bool? smokingHabit;
  @JsonKey(name: 'drinking_habbit')
  final bool? drinkingHabit;
  final String? clubbing;
  @JsonKey(name: 'do_you_drive')
  final bool? drivingHabit;
  @JsonKey(name: 'favorite_cities')
  final String? favCities;
  @JsonKey(name: 'favorite_clubs', defaultValue: [])
  final List<String> favClub;
  final SocialHandle? socialHandle;
  // final String? dob;
  @JsonKey(name: 'home_country')
  final int? countryID;
  @JsonKey(name: 'home_country_name')
  final String? countryName;
  @JsonKey(name: 'home_state_name')
  final String? stateName;
  @JsonKey(name: 'home_state')
  final int? stateId;
  @JsonKey(name: 'home_city')
  final int? cityID;
  @JsonKey(name: 'home_city_name')
  final String? cityName;

  UserEditModel(
      {this.name,
      this.gender,
      this.smokingHabit,
      this.drinkingHabit,
      this.drivingHabit,
      this.clubbing,
      this.favCities,
      // this.dob,
      this.countryID,
      this.countryName,
      this.stateName,
      this.stateId,
      this.cityID,
      this.cityName,
      required this.favClub,
      this.socialHandle});

  GenderSelection? getGenderEnum() {
    switch (gender?.toLowerCase()) {
      case 'male':
        return GenderSelection.male;
      case 'female':
        return GenderSelection.female;
      case 'other':
        return GenderSelection.other;
      case 'non-binary':
        return GenderSelection.other;

      default:
        return null;
    }
  }

  factory UserEditModel.fromJson(Map<String, dynamic> json) =>
      _$UserEditModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserEditModelToJson(this);
}

// class FavCities {
//   final String name;
//   FavCities({required this.name});
// }

// @JsonEnum()
enum VerificationStatus {
  @JsonValue('verified')
  verified,
  @JsonValue('not-verified')
  notVerified,
  @JsonValue('under-process')
  progress
}

@JsonSerializable()
class SocialHandle {
  final String? facebook;
  final String? twitter;
  final String? instagram;

  SocialHandle({this.facebook, this.instagram, this.twitter});

  factory SocialHandle.fromJson(Map<String, dynamic> json) =>
      _$SocialHandleFromJson(json);

  Map<String, dynamic> toJson() => _$SocialHandleToJson(this);
}

@JsonSerializable()
class Contacts {
  @JsonKey(name: 'contact_no')
  final String phone;
  @JsonKey(name: 'is_whatsapp')
  final bool? isWhatsapp;
  @JsonKey(name: 'is_verified')
  final bool? isVerified;
  Contacts({required this.phone, required this.isWhatsapp, this.isVerified});

  factory Contacts.fromJson(Map<String, dynamic> json) =>
      _$ContactsFromJson(json);

  Map<String, dynamic> toJson() => _$ContactsToJson(this);
}
