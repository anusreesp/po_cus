import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/products_model.dart';
import '../data/services/club_services.dart';

final clubMiscDataProvider = StateNotifierProvider.family
    .autoDispose<ClubMiscDataController, ClubMiscStates, String>((ref, clubId) {
  final service = ref.watch(clubServiceProvider);
  return ClubMiscDataController(clubId, service);
});

class ClubMiscDataController extends StateNotifier<ClubMiscStates> {
  final String clubId;
  final ClubServices _services;
  ClubMiscDataController(this.clubId, this._services)
      : super(ClubMiscLoading()) {
    init();
  }

  init() async {
    try {
      state = ClubMiscLoading();
      final closedDates = await _services.upcomingClosingDates(clubId);

      for (final date in closedDates) {
        print(date.toString());
      }
      final drinks = await _services.drinksList(clubId);
      final smokes = await _services.smokesList(clubId);
      state = ClubMisLoaded(closedDates, drinks, smokes);
    } catch (e) {
      print(e.toString());
      state = ClubMiscError(e.toString());
    }
  }
}

abstract class ClubMiscStates {}

class ClubMiscLoading extends ClubMiscStates {}

class ClubMisLoaded extends ClubMiscStates {
  final List<ProductModel> drinks;
  final List<ProductModel> smokes;
  final List<DateTime> closedDates;

  ClubMisLoaded(this.closedDates, this.drinks, this.smokes);
}

class ClubMiscError extends ClubMiscStates {
  final String msg;
  ClubMiscError(this.msg);
}
