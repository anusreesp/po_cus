

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/features/dashboard/data/models/ad_banners.dart';
import 'package:htp_customer/features/dashboard/data/services/dashboard_service.dart';

final adBannerProvider = FutureProvider.family<List<AdBanner>, String?>((ref, cityName) async{
  final service = ref.watch(dashboardServiceProvider);
  return await service.getAdBanner(cityName);
});