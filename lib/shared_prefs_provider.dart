

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPrefsProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

class SharedPrefsKey{
  static const lat = 'lat';
  static const lng = 'lng';
  static const cityName = 'city_name';
  static const lastFireVideoUrl = 'last-fire-video';
  static const localHeroVideoPath = 'local-hero-video-path';
}