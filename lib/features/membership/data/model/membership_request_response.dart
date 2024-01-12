// To parse this JSON data, do
//
//     final membershipsRequestResponse = membershipsRequestResponseFromJson(jsonString);

import 'dart:convert';

MembershipsRequestResponse membershipsRequestResponseFromJson(String str) =>
    MembershipsRequestResponse.fromJson(json.decode(str));

String membershipsRequestResponseToJson(MembershipsRequestResponse data) =>
    json.encode(data.toJson());

class MembershipsRequestResponse {
  MembershipsRequestResponse({
    required this.success,
    required this.data,
    required this.count,
  });

  final bool success;
  final List<MembershipRequestData> data;
  final int count;

  factory MembershipsRequestResponse.fromJson(Map<String, dynamic> json) =>
      MembershipsRequestResponse(
        success: json["success"],
        data: List<MembershipRequestData>.from(
            json["data"].map((x) => MembershipRequestData.fromJson(x))),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "count": count,
      };
}

class MembershipRequestData {
  MembershipRequestData({
    required this.id,
    required this.membership,
    required this.status,
    required this.user,
    required this.location,
    required this.createdAt,
    required this.updatedAt,
    required this.userName,
    required this.membershipName,
    required this.locationName,
  });

  final String id;
  final String membership;
  final String status;
  final String user;
  final String location;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String userName;
  final String membershipName;
  final String locationName;

  factory MembershipRequestData.fromJson(Map<String, dynamic> json) =>
      MembershipRequestData(
        id: json["id"],
        membership: json["membership"],
        status: json["status"],
        user: json["user"],
        location: json["location"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        userName: json["user_name"],
        membershipName: json["membership_name"],
        locationName: json["location_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "membership": membership,
        "status": status,
        "user": user,
        "location": location,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "user_name": userName,
        "membership_name": membershipName,
        "location_name": locationName,
      };
}
