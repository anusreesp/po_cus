import 'package:htp_customer/features/profile/controller/profile_update_controller.dart';

class ProfileInfo{
  ProfileInfo({
     this.name,
     this.sex,
     this.favClub,
     this.favCity,
     this.smoke,
     this.drink,
     this.clubbing,
     this.drive,
     this.fb,
     this.insta,
     this.twitter,
});
  final String? name;
  final String? sex;
  final String? favClub;
  final String? favCity;
  final bool? smoke;
  final bool? drink;
  final String? clubbing;
  final bool? drive;
  final String? fb;
  final String? twitter;
  final String? insta;

  GenderSelection? get genderEnum => getGender(sex);

  factory ProfileInfo.fromJson(Map<String, dynamic> json)=> ProfileInfo(
      name: json['name'] ,
      sex: json['sex'] ,
      favClub: json['one_of_fav_club'],
      favCity: json['one_of_fav_city'],
      smoke: json['smoking_habbit'],
      drink: json['drinking_drink'],
      clubbing: json['clubbing'],
      drive: json['drive'],
      fb: json['facebook_handle'],
      twitter: json['twitter_handle'],
      insta: json['instagram_handle']
     );

  GenderSelection? getGender(String? value){
    switch(value){
      case null:
        return null;
      case 'Male':
        return GenderSelection.male;
      case 'Female':
        return GenderSelection.female;
      default:
        return GenderSelection.other;
    }
}
}
