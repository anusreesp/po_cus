// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'membership_requested_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MembershipRequestedDataModel _$MembershipRequestedDataModelFromJson(
        Map<String, dynamic> json) =>
    MembershipRequestedDataModel(
      id: json['id'] as String,
      status: json['status'] as String,
      membershipId: json['membership_id'] as String,
      membershipName: json['membership_name'] as String,
    );

Map<String, dynamic> _$MembershipRequestedDataModelToJson(
        MembershipRequestedDataModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'membership_id': instance.membershipId,
      'membership_name': instance.membershipName,
      'status': instance.status,
    };
