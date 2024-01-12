import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/authentication/data/service/firebase_auth_service.dart';
import 'package:htp_customer/features/profile/data/models/loyalty_points_model.dart';
import 'package:htp_customer/features/profile/data/services/profile_services.dart';

enum pointStatus { redeemed, received }

final loyaltyPointsProvider = StateNotifierProvider.autoDispose<
    LoyaltyPointsController, LoyaltyPointStates>((ref) {
  final authData = ref.watch(firebaseAuthServiceProvider);
  return LoyaltyPointsController(ref: ref, authData: authData);
});

final pointStatusProvider =
    StateProvider.autoDispose((ref) => pointStatus.received);
final totalPoints = StateProvider.autoDispose<String>((ref) => "0");

class LoyaltyPointsController extends StateNotifier<LoyaltyPointStates> {
  final FirebaseAuthenticate authData;
  final StateNotifierProviderRef ref;
  LoyaltyPointsController({required this.ref, required this.authData})
      : super(LoyaltyPointInitial()) {
    getLoyaltyPoints(authData.uid);
  }

  getLoyaltyPoints(String uid) async {
    try {
      state = LoyaltyPointLoading();
      final response =
          await ref.read(profileServiceProvider).getLoyaltyPoints(uid);
      final loyaltyPoint =
          await ref.read(profileServiceProvider).getProfileData();
      state = LoyaltyPointSuccess(
          data: response, point: loyaltyPoint.profileData.loyaltyPoints);
    } catch (err) {
      state = LoyaltyPointError();
    }
  }

  loyaltyCard(String userType) {
    switch (userType) {
      case "18e6a4b1-c609-460f-a796-c9e1661c5eff":
        return "assets/images/placeholders/loyalty_points/loyalty_gold.png";
      case "38c2cd71-8dbd-4911-a1c0-f24869ebb02f":
        return "assets/images/placeholders/loyalty_points/loyalty_solitaire.png";
      case "5557d9dd-53ff-499d-a037-c8881d9da732":
        return "assets/images/placeholders/loyalty_points/loytalty_silver.png";
      case "8ed41640-2a89-4a0c-9553-12561ff69eb0":
        return "assets/images/placeholders/loyalty_points/loyalty_platinium.png";
      case "91e5aae1-6edd-4394-a648-5908084db3e7":
        return "assets/images/placeholders/loyalty_points/loyalty_amethyst.png";
      default:
        return "";
    }
  }
}

abstract class LoyaltyPointStates {}

class LoyaltyPointInitial extends LoyaltyPointStates {}

class LoyaltyPointLoading extends LoyaltyPointStates {}

class LoyaltyPointSuccess extends LoyaltyPointStates {
  final List<LoyaltyModel> data;
  final double? point;
  LoyaltyPointSuccess({required this.data, this.point});
}

class LoyaltyPointError extends LoyaltyPointStates {}
