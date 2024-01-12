

class StateListResponse {
  final bool success;
  final List<StateData> data;
  final int count;

  StateListResponse({
    required this.success,
    required this.data,
    required this.count,
  });

  factory StateListResponse.fromJson(Map<String, dynamic> json) => StateListResponse(
    success: json["success"],
    data: List<StateData>.from(json["data"].map((x) => StateData.fromJson(x))),
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "count": count,
  };
}

class StateData {
  final int id;
  final String name;
  final int countryId;
  final String countryName;
  final double? latitude;
  final double? longitude;
  final dynamic stateImage;
  final DateTime? createdAt;
  final dynamic updatedAt;

  StateData({
    required this.id,
    required this.name,
    required this.countryId,
    required this.countryName,
    required this.latitude,
    required this.longitude,
    this.stateImage,
    this.createdAt,
    this.updatedAt,
  });

  factory StateData.fromJson(Map<String, dynamic> json) => StateData(
    id: json["id"],
    name: json["name"],
    countryId: json["country_id"],
    countryName: json["country_name"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    stateImage: json["state_image"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "country_id": countryId,
    "country_name": countryName,
    "latitude": latitude,
    "longitude": longitude,
    "state_image": stateImage,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt,
  };
}
