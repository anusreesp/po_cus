import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:htp_customer/common/utils/timestamp_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'popups_model.g.dart';

@JsonSerializable()
@TimestampConverter()
class PopupsModels{
  String city;
  String? clubId;
  @JsonKey(name: 'club_event_name')
  String clubEventName;
  String? eventId;
  String id;
  String? image;
  String redirectionType;
  @JsonKey(name: 'redirect_url')
  String? redirectUrl;
  @JsonKey(name: 'internal_redirect')
  bool? internalRedirect;
  @JsonKey(name: 'start_date')
  DateTime startDate;
  @JsonKey(name: 'end_date')
  DateTime endDate;
  PopupsModels({
  required this.city,this.clubId,required this.clubEventName, required this.id,this.image,this.eventId,required this.redirectionType,
    this.redirectUrl,required this.internalRedirect,
    required this.startDate,
    required this.endDate
});
  factory PopupsModels.fromJson(Map<String, dynamic> json) => _$PopupsModelsFromJson(json);

  Map<String, dynamic> toJson() => _$PopupsModelsToJson(this);

}