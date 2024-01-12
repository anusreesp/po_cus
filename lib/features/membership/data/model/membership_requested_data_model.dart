

import 'package:json_annotation/json_annotation.dart';

part 'membership_requested_data_model.g.dart';

@JsonSerializable()
class MembershipRequestedDataModel{
  final String id;
  @JsonKey(name: 'membership_id')
  final String membershipId;
  @JsonKey(name: 'membership_name')
  final String membershipName;
  final String status;

  MembershipRequestedDataModel({
    required this.id,
    required this.status,
    required this.membershipId,
    required this.membershipName
});

  factory MembershipRequestedDataModel.fromJson(Map<String, dynamic> json) => _$MembershipRequestedDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$MembershipRequestedDataModelToJson(this);

}