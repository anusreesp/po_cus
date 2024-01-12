// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:htp_customer/features/clubs/controllers/club_list_controller.dart';
// import 'package:htp_customer/features/clubs/data/models/club_list_api_response.dart';

// //Keep same order, pop menu returns index. Below enum is mapped with values
// enum FilterEnum { nearby, popular, aToz, zToa, openNow }

// final clubFilteredListProvider =
//     StateNotifierProvider<ClubFilterListController, List<ClubDataNew>>((ref) {
//   final clubListController = ref.watch(clubListProvider);
//   if (clubListController is ClubLoaded) {
//     return ClubFilterListController(clubListController.clubs);
//   } else {
//     return ClubFilterListController([]);
//   }
// });

// class ClubFilterListController extends StateNotifier<List<ClubDataNew>> {
//   final List<ClubDataNew> clubList;
//   ClubFilterListController(this.clubList) : super(clubList);

//   FilterEnum? selectedFilter;

//   filterClubs(FilterEnum filterType) {
//     selectedFilter = filterType;
//     switch (filterType) {
//       case FilterEnum.aToz:
//         sortAtoZ();
//         break;

//       case FilterEnum.zToa:
//         sortZtoA();
//         break;

//       case FilterEnum.openNow:
//         openNowSort();
//         break;

//       case FilterEnum.popular:
//         popularSort();
//         break;

//       case FilterEnum.nearby:
//         nearbySor();
//         break;
//     }
//   }

//   sortAtoZ() {
//     print('FilterAtoZ');
//     clubList.sort((a, b) => a.name.compareTo(b.name));
//     state = [...clubList];
//   }

//   sortZtoA() {
//     print('FilterZtoA');
//     clubList.sort((a, b) => b.name.compareTo(a.name));
//     state = [...clubList];
//   }

//   nearbySor() {
//     print('NearbySort');
//     clubList.sort((a, b) {
//       if (a.distance == null || b.distance == null) {
//         return 0;
//       }
//       return a.distance!.compareTo(b.distance!.toInt());
//     });
//     state = [...clubList];
//   }

//   popularSort() {
//     print('PopularSort');
//     clubList.sort((a, b) => a.featured ?? false ? -1 : 1);
//     state = [...clubList];
//   }

//   openNowSort() {
//     print('OpenNowSort');
//     clubList.sort((a, b) => a.openNow ?? false ? -1 : 1);
//     state = [...clubList];
//   }
// }
