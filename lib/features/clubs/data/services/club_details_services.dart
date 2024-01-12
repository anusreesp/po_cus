import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/features/clubs/data/models/club_details_response.dart';
import 'package:htp_customer/networking/http_client.dart';

final clubDetailServiceProvider = Provider<ClubDetailServices>((ref) {
  final client = ref.watch(clientProvider);
  return ClubDetailServices(client);
});

class ClubDetailServices {
  final NetworkClient _client;
  ClubDetailServices(this._client);

  Future<List<ClubDetailData>> getClubDetails(String? id) async {
    try {
      final response = await _client.getRequest('/club/v1/clubDetails?id=$id');
      final data = ClubDetailsResponse.fromJson(response.data);

      return data.data;
    } catch (e) {
      rethrow;
    }
  }
}
