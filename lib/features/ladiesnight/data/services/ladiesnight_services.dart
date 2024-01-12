import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/features/ladiesnight/data/models/ladiesclub_response.dart';
import 'package:htp_customer/networking/http_client.dart';

final ladiesNightServiceProvider = Provider((ref) {
  final client = ref.watch(clientProvider);

  return LadiesNightClubServices(client);
});

class LadiesNightClubServices {
  final NetworkClient _client;

  LadiesNightClubServices(this._client);

  Future<List<LadiesNightData>> getLadiesNightClubs() async {
    try {
      final response = await _client.getRequest(
          '/club/v1/clubList?country=c262885e-94e5-4820-9ab5-152111037907');
      final data = LadiesNightClubListResponse.fromJson(response.data);

      return data.message;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<LadiesNightData>> getLadiesNightNew(String city, String day,
      {double? lat, double? lng}) async {
    try {
      final url = (lat != null && lng != null)
          ? '/club/v1/ladiesNight?day=$day&city_name=$city&current_lat=$lat&current_long=$lng&sort_by=near-by'
          : '/club/v1/ladiesNight?day=$day&city_name=$city&sort_by=near-by';

      debugPrint("ladies night -----$url");

      final response = await _client.getRequest(url);
      final data = LadiesNightClubListResponse.fromJson(response.data);
      debugPrint("ladies night -----${data.message}");
      return data.message;
    } catch (e) {
      rethrow;
    }
  }
}
