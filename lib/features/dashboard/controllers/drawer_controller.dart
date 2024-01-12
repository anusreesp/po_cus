// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// enum drawerItem {
//   home,
//   nowInBali,
//   clubs,
//   events,
//   locations,
//   membership,
//   ladiedClub,
//   takeMeHome,
//   about,
//   contactUs
// }
//
// final dashboardProvider =
//     StateNotifierProvider<DashboardController, drawerItem>(
//         (ref) => DashboardController());
//
// class DashboardController extends StateNotifier<drawerItem> {
//   DashboardController() : super(drawerItem.home);
//
//   final navigationKeys = {
//     drawerItem.home: GlobalKey<NavigatorState>(),
//     drawerItem.clubs: GlobalKey<NavigatorState>(),
//     drawerItem.events: GlobalKey<NavigatorState>(),
//     drawerItem.locations: GlobalKey<NavigatorState>(),
//     drawerItem.membership: GlobalKey<NavigatorState>()
//   };
//
//   selectTab(drawerItem tab) {
//     if (tab == state) {
//       navigationKeys[tab]!.currentState!.popUntil((route) => route.isFirst);
//     } else {
//       state = tab;
//     }
//   }
// }
