
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/common/utils/dynamic_routes.dart';
import 'package:htp_customer/features/dashboard/controllers/location_controller.dart';
import 'package:htp_customer/features/dashboard/data/models/popups_model.dart';
import 'package:htp_customer/features/dashboard/data/services/dashboard_service.dart';

final adPopupProvider = StateNotifierProvider<AdPopupController,AdPopupStates>((ref){
  final service = ref.watch(dashboardServiceProvider);
  final userLocation = ref.watch(userLocationProvider);
  return AdPopupController(service: service,location: userLocation,ref:ref);
});

// final isAdLoading = StateProvider<bool>((ref) => true);

bool isPopupDisplayed = false;

class AdPopupController extends StateNotifier<AdPopupStates>{
  final DashboardService service;
  final LocationStates location;
  final Ref ref;
  AdPopupController({required this.service,required this.location,required this.ref}) : super(AdPopupInitial()){
    getPopup();
  }


  getPopup()async{
    if(isPopupDisplayed){
      return;
    }
    if(location is LocationLoaded) {
      final currentCity = (location as LocationLoaded).cityName;
      try {
        state = AdPopupLoading();
        List<PopupsModels> dataByLoc = [];
        final data = await service.getPopups();
        dataByLoc = data.where((element) => currentCity.toLowerCase() == element.city.toLowerCase()).toList();
        List<String> images = [];
        List<String> name = [];
        List<String> redirectType = [];
        List<String> url = [];
        List<bool> internalRedirect = [];
        for (var element in dataByLoc) {
          final now = DateTime.now();
          if(now.isAfter(element.startDate) && now.isBefore(element.endDate)){
            images.add(element.image ?? "");
            redirectType.add(element.redirectionType);
            name.add(element.clubEventName);
            url.add(element.redirectUrl ?? "");
            internalRedirect.add(element.internalRedirect ?? true);
          }

        }
        state = AdPopupShow(
          images: images, clubEventName: name, url: url,internalRedirect:internalRedirect);
        isPopupDisplayed = true;
      } catch (err) {
        print(">>>>>>>>>>::::${err.toString()}");
        state = AdPopupError();
      }
    }
  }
  adRedirection(String url,bool type){
    final Map<String,dynamic> data = {
      "url":url,"internal_redirect":type
    };
    // switch(type){
    //   case "clubs":
    //     ref.read(dashboardProvider.notifier).selectTab(TabItem.clubs);
    //   case "events":
    //     ref.read(dashboardProvider.notifier).selectTab(TabItem.events);
    // }
    redirect(data, ref);
  }
}



abstract class AdPopupStates{}

class AdPopupInitial extends AdPopupStates{}
class AdPopupShow extends AdPopupStates{
  final List<String> images;
  final List<String>? url;
  final List<String>? clubEventName;
  final List<bool>? internalRedirect;
  AdPopupShow({required this.images,required this.url,required this.clubEventName,required this.internalRedirect});
}
class AdPopupLoading extends AdPopupStates{}
class AdPopupError extends AdPopupStates{}