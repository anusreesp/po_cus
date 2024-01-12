import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/features/clubs/data/models/club_details_response.dart';
import 'package:htp_customer/features/clubs/data/models/fire_club_details.dart';
import 'package:htp_customer/features/clubs/data/services/club_details_services.dart';
import 'package:htp_customer/features/clubs/data/services/club_services.dart';

// final checkFavClubProvider = FutureProvider.autoDispose.family<bool, String>((ref, clubId) async{
//   final service = ref.watch(clubServiceProvider);
//   return await service.checkFav(clubId);
// });

enum FavStates{fav, nonFav}
final favProvider = StateNotifierProvider.autoDispose.family<FavController, FavStates, String>((ref, clubId) {
  final service = ref.watch(clubServiceProvider);
  return FavController(service, clubId);
});

class FavController extends StateNotifier<FavStates>{
  final ClubServices _services;
  final String clubId;
  FavController(this._services, this.clubId):super(FavStates.nonFav){
    checkFav();
  }

  checkFav() async{
    state = FavStates.nonFav;
    final isFav = await _services.checkFav(clubId);
    if(isFav){
      state = FavStates.fav;
    }else{
      state = FavStates.nonFav;
    }
  }

  markFav(ClubDataModel clubDetails) async{
    try{
      state = FavStates.fav;
      await _services.markFav(clubDetails);
      // checkFav();
    }catch(_){
      // state = FavStates.nonFav;
    }
  }

  deleteFav()async{
    try{
      state = FavStates.nonFav;
      await _services.deleteFav(clubId);
      checkFav();
    }catch(_){

    }
  }

}



final clubDetailProvider = StateNotifierProvider.autoDispose((ref) {
  final service = ref.watch(clubDetailServiceProvider);
  return ClubDetailsController(service);
});

class ClubDetailsController extends StateNotifier<ClubDetailsStates> {
  final ClubDetailServices _services;

  ClubDetailsController(this._services) : super(ClubDetailLoading()) {
    getClubDetails();
  }

  getClubDetails() async {
    try {
      state = ClubDetailLoading();
      dynamic val;
      final data = await _services.getClubDetails(val);
      state = ClubDetailLoaded(data);
    } catch (e) {
      state = ClubDetailError(e.toString());
    }
  }
}

abstract class ClubDetailsStates {}

class ClubDetailLoaded extends ClubDetailsStates {
  final List<ClubDetailData> clubsDetails;
  ClubDetailLoaded(this.clubsDetails);
}

class ClubDetailLoading extends ClubDetailsStates {}

class ClubDetailError extends ClubDetailsStates {
  final String msg;
  ClubDetailError(this.msg);
}
