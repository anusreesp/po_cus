//
//
// class ClubsList {
//   ClubsList({
//     required this.clubs,
//   });
//
//   final List<Club> clubs;
//
//   factory ClubsList.fromJson(Map<String, dynamic> json) => ClubsList(
//     clubs: List<Club>.from(json["clubs"].map((x) => Club.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "clubs": List<dynamic>.from(clubs.map((x) => x.toJson())),
//   };
// }
//
// class Club {
//   Club({
//     required this.id,
//     required this.name,
//     required this.location,
//     required this.distance,
//     required this.rating,
//     required this.imageUrl,
//     required this.isFeatured,
//   });
//
//   final int id;
//   final String name;
//   final String location;
//   final String distance;
//   final double rating;
//   final String imageUrl;
//   final bool isFeatured;
//
//   factory Club.fromJson(Map<String, dynamic> json) => Club(
//     id: json["id"],
//     name: json["name"],
//     location: json["location"],
//     distance: json["distance"],
//     rating: json["rating"]?.toDouble(),
//     imageUrl: json["imageUrl"],
//     isFeatured: json["isFeatured"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "location": location,
//     "distance": distance,
//     "rating": rating,
//     "imageUrl": imageUrl,
//     "isFeatured": isFeatured,
//   };
// }
