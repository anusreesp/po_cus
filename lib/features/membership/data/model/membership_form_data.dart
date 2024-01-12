

// "user_id":"UUT3W84kutVG9SjaYejZdpYmHeJ2",
// "name":"abhishek tiwari",
// "nationalty":"Indian",
// "residency":"Resident",
// "home_country_id":100,
// "home_country_name":"India",
// "home_state_id":4022,
// "home_state_name":"Uttar Pradesh",
// "home_city_id":133230,
// "home_city_name":"Noida",
// "government_id_number":"abc3456193y739",
// "frequency_of_clubbing":"Weekly",
// "govt_id_front":"https://storage.googleapis.com/party_images/1688722552541-Scenery.jpg",
// "govt_id_back":"https://storage.googleapis.com/party_images/1688722552541-Scenery.jpg",
// "user_image":"https://storage.googleapis.com/party_images/1688722552541-Scenery.jpg"

import 'package:json_annotation/json_annotation.dart';
part 'membership_form_data.g.dart';

@JsonSerializable()
class MembershipFormData{
  @JsonKey(name: 'user_id')
  final String userId;
  final String name;
  @JsonKey(name: 'nationalty')
  final String nationality;
  @JsonKey(name: 'residency')
  final String residency;
  @JsonKey(name: 'home_country_id')
  final int homeCountryId;
  @JsonKey(name: 'home_country_name')
  final String homeCountryName;
  @JsonKey(name: 'home_state_id')
  final int homeStateId;
  @JsonKey(name: 'home_state_name')
  final String homeStateName;
  @JsonKey(name: 'home_city_id')
  final int homeCityId;
  @JsonKey(name: 'home_city_name')
  final String homeCityName;
  @JsonKey(name: 'government_id_number')
  final String govtIdNumber;
  @JsonKey(name: 'frequency_of_clubbing')
  final String clubFrequency;
  @JsonKey(name: 'govt_id_front')
  final String govtIdFront;
  @JsonKey(name: 'govt_id_back')
  final String? govtIdBack;
  @JsonKey(name: 'user_image')
  final String userImage;
  @JsonKey(name: 'permanent_address')
  final String permanentAddress;
  final String? zipcode;

  MembershipFormData({
    required this.userId,
    required this.name,
    required this.nationality,
    required this.residency,
    required this.homeCountryId,
    required this.homeCountryName,
    required this.homeStateName,
    required this.homeStateId,
    required this.homeCityId,
    required this.homeCityName,
    required this.govtIdNumber,
    required this.clubFrequency,
    this.govtIdBack,
    required this.govtIdFront,
    required this.userImage,
    required this.permanentAddress,
    this.zipcode
  });

  MembershipFormData copyWith({
    String? userId,
    String? name,
    String? nationality,
    String? residency,
    int? homeCountryId,
    String? homeCountryName,
    String?  homeStateName,
    int? homeStateId,
    int? homeCityId,
    String? homeCityName,
    String? govtIdNumber,
    String? clubFrequency,
    String? govtIdBack,
    String? govtIdFront,
    String? userImage,
    String? permanentAddress,
    String? zipcode

  }) => MembershipFormData(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      nationality: nationality ?? this.nationality,
      residency: residency ?? this.residency,
      homeCountryId: homeCountryId ?? this.homeCountryId,
      homeCountryName: homeCountryName ?? this.homeCountryName,
      homeStateName: homeStateName ?? this.homeStateName,
      homeStateId: homeStateId ?? this.homeStateId,
      homeCityId: homeCityId ?? this.homeCityId,
      homeCityName: homeCityName ?? this.homeCityName,
      govtIdNumber: govtIdNumber ?? this.govtIdNumber,
      clubFrequency: clubFrequency ?? this.clubFrequency,
      govtIdFront: govtIdFront ?? this.govtIdFront,
      govtIdBack: govtIdBack ?? this.govtIdBack,
      userImage: userImage ?? this.userImage,
      permanentAddress: permanentAddress ?? this.permanentAddress,
    zipcode: zipcode ?? this.zipcode
  );

  factory MembershipFormData.fromJson(Map<String, dynamic> json) => _$MembershipFormDataFromJson(json);

  Map<String, dynamic> toJson() => _$MembershipFormDataToJson(this);

}