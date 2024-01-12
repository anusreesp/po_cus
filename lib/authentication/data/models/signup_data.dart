
import 'package:cloud_firestore/cloud_firestore.dart';

class SignupData {
  SignupData({
    required this.id,
    required this.name,
    required this.gender,
    required this.city,
    // required this.country,
    required this.cityName,
    required this.countryId,
    required this.countryName,
    this.homeState,
    this.homeStateName,
    required this.dob,
    required this.email,
    this.password,
    this.profileImage,
    required this.contacts,
    // this.contactList,
    this.deviceToken,
    this.drinkPreference,
    this.smokePreference
  });

  final String id;
  final String name;
  final String gender;
  final int city;
  final String cityName;
  // final String country;
  final int countryId;
  final String countryName;
  final int? homeState;
  final String? homeStateName;
  final String dob;
  final String email;
  final String? password;
  final String? profileImage;
  // final Contact contact;
  final List<Contact> contacts;
  final String? deviceToken;
  final bool? drinkPreference;
  final bool? smokePreference;

  SignupData copyWith({
    String? id,
    String? name,
    String? gender,
    int? city,
    String? country,
    int? homeState,
    String? homeStateName,
    String? dob,
    String? email,
    String? password,
    String? profileImage,
    List<Contact>? contacts,
    String? cityName,
    int? countryId,
    String? countryName,
    String? deviceToken,
    bool? drinkPreference,
    bool? smokePreference
  }) =>
      SignupData(
          id: id ?? this.id,
          name: name ?? this.name,
          gender: gender ?? this.gender,
          city: city ?? this.city,
          // country: country ?? this.country,
          countryId: countryId ?? this.countryId,
          countryName: countryName ?? this.countryName,
          homeState: homeState ?? this.homeState,
          homeStateName: homeStateName ?? this.homeStateName,
          dob: dob ?? this.dob,
          email: email ?? this.email,
          password: password ?? this.password,
          profileImage: profileImage ?? this.profileImage,
          contacts: contacts ?? this.contacts,
          cityName: cityName ?? this.cityName,
          deviceToken: deviceToken ?? this.deviceToken,
          drinkPreference: drinkPreference ?? this.drinkPreference,
          smokePreference: smokePreference ?? this.smokePreference
      );

  factory SignupData.fromJson(Map<String, dynamic> json) => SignupData(
      id: json["id"],
      name: json["name"],
      gender: json["gender"],
      city: json["home_city"],
      cityName: json["home_city_name"],
      countryId: json["home_country"],
      countryName: json["home_country_name"],
      homeState: json["home_state"],
      homeStateName: json["home_state_name"],
      dob: json["dob"],
      email: json["email"],
      // password: json["password"],
      profileImage: json["profile_image"],
      smokePreference: json["smoking_habbit"],
      drinkPreference: json["drinking_habbit"],
      // contact: Contact.fromJson(json["contact"][0]),
      contacts: json["contacts"] != null ? List<Contact>.from(json["contacts"].map((x) => Contact.fromJson(x))) : []
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "gender": gender,
    "home_city": city,
    "home_city_name": cityName,
    "home_country": countryId,
    "home_country_name": countryName,
    "home_state": homeState,
    "home_state_name": homeStateName,
    "dob": dob,
    "email": email.toLowerCase(),
    "profile_image": profileImage,
    "contacts": contacts.map((e) => e.toJson()).toList(),
    "active_membership_id": null,
    "active_membership_name": null,
    "last_membership_id": null,
    "last_membership_name": null,
    "status": 'Active',
    "drinking_habbit": drinkPreference,
    "smoking_habbit": smokePreference,
    "device_token": [deviceToken],
    "createdAt": FieldValue.serverTimestamp(),
    "role": ["customer"],
    "club_id": null,

    "name_lower_case": name.toLowerCase(),
    "phone_no": contacts.first.contactNo
    // "contact": List<dynamic>.from(contact.map((x) => x.toJson())),
  };
}

class Contact {
  Contact({
    required this.contactNo,
    required this.isVerified,
    required this.isActive,
    required this.mode
  });

  final String contactNo;
  final bool isVerified;
  final bool isActive;
  final String mode;

  Contact copyWith({
    String? contactNo,
    bool? isVerified,
    bool? isActive,
    String? mode
  }) =>
      Contact(
          contactNo: contactNo ?? this.contactNo,
          isVerified: isVerified ?? this.isVerified,
          isActive: isActive ?? this.isActive,
        mode: mode ?? this.mode
      );

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
      contactNo: json["contact_no"],
      isVerified: json["is_verified"],
      isActive: json["is_active"],
    mode: json["mode"]
  );

  Map<String, dynamic> toJson() => {
    "contact_no": contactNo,
    "is_verified": isVerified,
    "is_active": isActive,
    "mode": mode
    // "createdAt": FieldValue.serverTimestamp()
  };
}
