// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'membership_form_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MembershipFormData _$MembershipFormDataFromJson(Map<String, dynamic> json) =>
    MembershipFormData(
      userId: json['user_id'] as String,
      name: json['name'] as String,
      nationality: json['nationalty'] as String,
      residency: json['residency'] as String,
      homeCountryId: json['home_country_id'] as int,
      homeCountryName: json['home_country_name'] as String,
      homeStateName: json['home_state_name'] as String,
      homeStateId: json['home_state_id'] as int,
      homeCityId: json['home_city_id'] as int,
      homeCityName: json['home_city_name'] as String,
      govtIdNumber: json['government_id_number'] as String,
      clubFrequency: json['frequency_of_clubbing'] as String,
      govtIdBack: json['govt_id_back'] as String?,
      govtIdFront: json['govt_id_front'] as String,
      userImage: json['user_image'] as String,
      permanentAddress: json['permanent_address'] as String,
      zipcode: json['zipcode'] as String?,
    );

Map<String, dynamic> _$MembershipFormDataToJson(MembershipFormData instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'name': instance.name,
      'nationalty': instance.nationality,
      'residency': instance.residency,
      'home_country_id': instance.homeCountryId,
      'home_country_name': instance.homeCountryName,
      'home_state_id': instance.homeStateId,
      'home_state_name': instance.homeStateName,
      'home_city_id': instance.homeCityId,
      'home_city_name': instance.homeCityName,
      'government_id_number': instance.govtIdNumber,
      'frequency_of_clubbing': instance.clubFrequency,
      'govt_id_front': instance.govtIdFront,
      'govt_id_back': instance.govtIdBack,
      'user_image': instance.userImage,
      'permanent_address': instance.permanentAddress,
      'zipcode': instance.zipcode,
    };
