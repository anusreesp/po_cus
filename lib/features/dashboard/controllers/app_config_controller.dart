
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/features/dashboard/data/models/app_settings.dart';

import '../data/services/dashboard_service.dart';

final appConfigProvider = StateNotifierProvider<AppConfigController, AppConfigStates>((ref) {
  final service = ref.watch(dashboardServiceProvider);
  return AppConfigController(service);
});

class AppConfigController extends StateNotifier<AppConfigStates>{
  final DashboardService _service;
  AppConfigController(this._service):super(AppConfigLoading()){
    init();
  }

  init()async{
    try{
      state = AppConfigLoading();
      final settings = await _service.getAppSettings();
      state = AppConfigLoaded(settings);
    }catch(e){
      print(e);
    }
  }

}

abstract class AppConfigStates{}

class AppConfigLoading extends AppConfigStates{}

class AppConfigLoaded extends AppConfigStates{
  final AppSettings settings;
  AppConfigLoaded(this.settings);
}