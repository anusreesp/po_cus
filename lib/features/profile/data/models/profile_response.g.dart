// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileData _$ProfileDataFromJson(Map<String, dynamic> json) => ProfileData(
      name: json['name'] as String,
      id: json['id'] as String,
      gender: json['gender'] as String?,
      dob: json['dob'] as String?,
      profileImage: json['profile_image'] as String?,
      homeCity: json['home_city'] as int?,
      homeCityName: json['home_city_name'] as String?,
      homeState: json['home_state'] as int?,
      homeStateName: json['home_state_name'] as String?,
      homeCountry: json['home_country'] as int?,
      homeCountryName: json['home_country_name'] as String?,
      email: json['email'] as String,
      contacts: (json['contacts'] as List<dynamic>?)
              ?.map((e) => Contacts.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      activeMembershipId: json['active_membership_id'] as String?,
      activeMembershipName: json['active_membership_name'] as String?,
      lastMembershipId: json['last_membership_id'] as String?,
      lastMembershipName: json['last_membership_name'] as String?,
      verificationStatus: $enumDecodeNullable(
              _$VerificationStatusEnumMap, json['verification_status']) ??
          VerificationStatus.notVerified,
      loyaltyPoints: (json['loyality_point'] as num?)?.toDouble() ?? 0,
      kycStatus: json['kyc_status'] as String?,
      activeMembershipCardNo: json['active_membership_card_no'] as String?,
      membershipEndDate: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['mebership_ends_at'], const TimestampConverter().fromJson),
      membershipStartDate: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['mebership_starts_at'], const TimestampConverter().fromJson),
    );

Map<String, dynamic> _$ProfileDataToJson(ProfileData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'gender': instance.gender,
      'profile_image': instance.profileImage,
      'home_city': instance.homeCity,
      'home_city_name': instance.homeCityName,
      'home_state': instance.homeState,
      'home_state_name': instance.homeStateName,
      'home_country': instance.homeCountry,
      'home_country_name': instance.homeCountryName,
      'email': instance.email,
      'contacts': instance.contacts,
      'active_membership_id': instance.activeMembershipId,
      'active_membership_name': instance.activeMembershipName,
      'last_membership_id': instance.lastMembershipId,
      'last_membership_name': instance.lastMembershipName,
      'kyc_status': instance.kycStatus,
      'active_membership_card_no': instance.activeMembershipCardNo,
      'mebership_starts_at': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.membershipStartDate, const TimestampConverter().toJson),
      'mebership_ends_at': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.membershipEndDate, const TimestampConverter().toJson),
      'verification_status':
          _$VerificationStatusEnumMap[instance.verificationStatus]!,
      'dob': instance.dob,
      'loyality_point': instance.loyaltyPoints,
    };

const _$VerificationStatusEnumMap = {
  VerificationStatus.verified: 'verified',
  VerificationStatus.notVerified: 'not-verified',
  VerificationStatus.progress: 'under-process',
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

UserEditModel _$UserEditModelFromJson(Map<String, dynamic> json) =>
    UserEditModel(
      name: json['name'] as String?,
      gender: json['gender'] as String?,
      smokingHabit: json['smoking_habbit'] as bool?,
      drinkingHabit: json['drinking_habbit'] as bool?,
      drivingHabit: json['do_you_drive'] as bool?,
      clubbing: json['clubbing'] as String?,
      favCities: json['favorite_cities'] as String?,
      countryID: json['home_country'] as int?,
      countryName: json['home_country_name'] as String?,
      stateName: json['home_state_name'] as String?,
      stateId: json['home_state'] as int?,
      cityID: json['home_city'] as int?,
      cityName: json['home_city_name'] as String?,
      favClub: (json['favorite_clubs'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      socialHandle: json['socialHandle'] == null
          ? null
          : SocialHandle.fromJson(json['socialHandle'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserEditModelToJson(UserEditModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'gender': instance.gender,
      'smoking_habbit': instance.smokingHabit,
      'drinking_habbit': instance.drinkingHabit,
      'clubbing': instance.clubbing,
      'do_you_drive': instance.drivingHabit,
      'favorite_cities': instance.favCities,
      'favorite_clubs': instance.favClub,
      'socialHandle': instance.socialHandle?.toJson(),
      'home_country': instance.countryID,
      'home_country_name': instance.countryName,
      'home_state_name': instance.stateName,
      'home_state': instance.stateId,
      'home_city': instance.cityID,
      'home_city_name': instance.cityName,
    };

SocialHandle _$SocialHandleFromJson(Map<String, dynamic> json) => SocialHandle(
      facebook: json['facebook'] as String?,
      instagram: json['instagram'] as String?,
      twitter: json['twitter'] as String?,
    );

Map<String, dynamic> _$SocialHandleToJson(SocialHandle instance) =>
    <String, dynamic>{
      'facebook': instance.facebook,
      'twitter': instance.twitter,
      'instagram': instance.instagram,
    };

Contacts _$ContactsFromJson(Map<String, dynamic> json) => Contacts(
      phone: json['contact_no'] as String,
      isWhatsapp: json['is_whatsapp'] as bool?,
      isVerified: json['is_verified'] as bool?,
    );

Map<String, dynamic> _$ContactsToJson(Contacts instance) => <String, dynamic>{
      'contact_no': instance.phone,
      'is_whatsapp': instance.isWhatsapp,
      'is_verified': instance.isVerified,
    };
