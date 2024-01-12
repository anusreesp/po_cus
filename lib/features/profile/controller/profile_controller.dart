import 'package:camera/camera.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/features/profile/data/models/profile_response.dart';
import 'package:htp_customer/features/profile/data/services/profile_services.dart';

import '../../membership/data/model/membership_response.dart';
import '../../membership/data/services/membership_services.dart';

final profileControllerProvider =
    StateNotifierProvider.autoDispose<ProfileControllers, ProfileStates>((ref) {
  final services = ref.watch(profileServiceProvider);
  final memService = ref.watch(membershipServiceProvider);
  return ProfileControllers(services, memService);
});

class ProfileControllers extends StateNotifier<ProfileStates> {
  final ProfileServices _services;
  final MembershipServices _membershipServices;
  ProfileControllers(this._services, this._membershipServices)
      : super(ProfileLoading()) {
    getProfile();
  }

  getProfile() async {
    try {
      state = ProfileLoading();
      final UserProfiledData userData = await _services.getProfileData();
      MembershipData? currentMembership;
      print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>::${userData.profileData.loyaltyPoints}");
      if (userData.profileData.activeMembershipId != null &&
          userData.profileData.activeMembershipId!.isNotEmpty) {
        currentMembership = await _membershipServices
            .getMembershipDataById(userData.profileData.activeMembershipId!);
      }
      state = ProfileLoaded(
          userData.profileData, userData.userEditModel, currentMembership);
    } catch (e) {
      print("Print Profile: $e");

      state = ProfileError(e.toString());
    }
  }

  membershipCardType(String? id) {
    switch (id) {
      case "18e6a4b1-c609-460f-a796-c9e1661c5eff":
        return "assets/images/placeholders/membership_cards/new/gold.png";
      case "38c2cd71-8dbd-4911-a1c0-f24869ebb02f":
        return "assets/images/placeholders/membership_cards/new/solitaire.png";
      case "5557d9dd-53ff-499d-a037-c8881d9da732":
        return "assets/images/placeholders/membership_cards/new/silver.png";
      case "8ed41640-2a89-4a0c-9553-12561ff69eb0":
        return "assets/images/placeholders/membership_cards/new/platinum.png";
      case "91e5aae1-6edd-4394-a648-5908084db3e7":
        return "assets/images/placeholders/membership_cards/new/amethyst.png";
      default:
        return "";
    }
  }

  updateProfileImage(XFile file) async {
    try {
      state = ProfileLoading();
      await _services.updateProfileImage(file.path);
      getProfile();
    } catch (_) {
      rethrow;
    }
  }
}

abstract class ProfileStates {}

class ProfileLoading extends ProfileStates {}

class ProfileLoaded extends ProfileStates {
  final ProfileData profileData;
  final UserEditModel userEditModel;
  final MembershipData? activeMembershipData;

  ProfileLoaded(
      this.profileData, this.userEditModel, this.activeMembershipData);
}

class ProfileError extends ProfileStates {
  final String message;
  ProfileError(this.message);
}
