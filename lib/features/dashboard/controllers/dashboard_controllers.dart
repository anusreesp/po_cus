import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/router.dart';
import 'package:htp_customer/shared_prefs_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/services/dashboard_service.dart';

enum TabItem { home, clubs, events, support, notifications }

// final dashboardNavigatorProvider = Provider((ref) => GlobalKey<ScaffoldState>(debugLabel: 'DashboardScaffoldKey'));

final dashboardProvider = StateNotifierProvider<DashboardController, TabItem>((ref){
  final service = ref.watch(dashboardServiceProvider);
  final prefs = ref.watch(sharedPrefsProvider);
  return DashboardController(service, prefs);
});

class DashboardController extends StateNotifier<TabItem> {
  final DashboardService _service;
  final SharedPreferences _prefs;
  DashboardController(this._service, this._prefs) : super(TabItem.home){

  }

  final dashboardScaffoldState = GlobalKey<ScaffoldState>(debugLabel: 'DashboardScaffoldKey');

  // final navigationKeys = {
  //   TabItem.home: GlobalKey<NavigatorState>(debugLabel: 'HomeNavigatorKey'),
  //   TabItem.clubs: GlobalKey<NavigatorState>(debugLabel: 'ClubsNavigatorKey'),
  //   TabItem.events: GlobalKey<NavigatorState>(debugLabel: 'EventsNavigatorKey'),
  //   TabItem.locations: GlobalKey<NavigatorState>(debugLabel: 'LocationNavigatorKey'),
  //   TabItem.membership: GlobalKey<NavigatorState>(debugLabel: 'MembershipNavigatorKey'),
  //   // TabItem.misc: GlobalKey<NavigatorState>(debugLabel: 'MiscNavigatorKey'),
  // };

  selectTab(TabItem tab) {
    state = tab;
    // if (tab == state) {
    //   navigationKeys[tab]!.currentState!.popUntil((route) => route.isFirst);
    // } else if(tab == TabItem.home || tab == TabItem.membership){
    //   state = tab;
    //   navigationKeys[tab]!.currentState!.popUntil((route) => route.isFirst);
    // } else {
    //   state = tab;
    // }
  }

  selectTabHome(TabItem tab) {
    // navigationKeys[tab]!.currentState!.popUntil((route) => route.isFirst);
    state = tab;
  }

  gotoPage(TabItem tab, String route, {Object? arguments}) {
    // selectTab(tab);
    // final navigatorKey = navigationKeys[tab];
    mainNavigatorKey.currentState?.pushNamed(route, arguments: arguments);
  }

  // pushPage(TabItem tab, Route<MaterialPageRoute> route){
  //   navigationKeys[tab]!.currentState!.push(route);
  // }

  processHeroVideo()async{
    try{
      final url = await _service.getVideoUrl();
      final lastStoredFireVideoUrl = _prefs.getString(SharedPrefsKey.lastFireVideoUrl);
      //If there is a video on fire and stored url is not same download and set it
      if(url != null && url != lastStoredFireVideoUrl){
        final File downloadedFile = await _service.downloadIntroVideo(url);
        _prefs.setString(SharedPrefsKey.lastFireVideoUrl, url);
        _prefs.setString(SharedPrefsKey.localHeroVideoPath, downloadedFile.path);
      }
    }catch(_){
      print("VIDEO LOAD ERROR");
    }
  }

}


