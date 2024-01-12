import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/features/dashboard/controllers/location_controller.dart';
import 'package:htp_customer/features/event/data/models/event_list_response.dart';
import 'package:htp_customer/features/event/data/services/events_services.dart';

import '../data/models/ladiesclub_response.dart';
import '../data/services/ladiesnight_services.dart';
import '../widget/weekdays.dart';

final ladiesNightClubProvider =
    FutureProvider<List<LadiesNightData>>((ref) async {
  final service = ref.watch(ladiesNightServiceProvider);
  final location = ref.watch(userLocationProvider);
  final selectedDay = ref.watch(dayPickProvider);
  if (location is LocationLoaded) {
    return await service.getLadiesNightNew(location.cityName, selectedDay,
        lat: location.lat, lng: location.lng);
  }

  return [];
});
