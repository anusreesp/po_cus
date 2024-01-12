import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/features/clubs/controllers/club_list_controller.dart';
import 'package:htp_customer/features/clubs/data/models/club_list_api_response.dart';

//Keep same order, pop menu returns index. Below enum is mapped with values
enum FilterEnum { showingall, popular, openNow }

final clubsFilterListProvider =
    StateNotifierProvider<ClubsFilterListController, List<ClubDataNew>>((ref) {
  final clubListController = ref.watch(clubListProvider);
  if (clubListController is ClubLoaded) {
    return ClubsFilterListController(clubListController.clubs);
  } else {
    return ClubsFilterListController([]);
  }
});

class ClubsFilterListController extends StateNotifier<List<ClubDataNew>> {
  final List<ClubDataNew> clubList;
  ClubsFilterListController(this.clubList) : super(clubList);

  FilterEnum? selectedFilter;

  filterClubs(FilterEnum filterType) {
    selectedFilter = filterType;
    switch (filterType) {
      case FilterEnum.showingall:
        showingAll();
        break;

      case FilterEnum.openNow:
        openNowSort();
        break;

      case FilterEnum.popular:
        popularSort();
        break;
    }
  }

  showingAll() {
    debugPrint("Showing All");
    state = clubList;
  }

  popularSort() {
    print('PopularSort');
    clubList.sort((a, b) => a.featured ?? false ? -1 : 1);
    state = [...clubList];
  }

  openNowSort() {
    print('OpenNowSort');
    clubList.sort((a, b) => a.openNow ?? false ? -1 : 1);
    state = [...clubList];
  }
}
