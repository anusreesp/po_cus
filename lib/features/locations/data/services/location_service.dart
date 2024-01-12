import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/features/locations/data/models/location_list_response.dart';
import 'package:htp_customer/networking/http_client.dart';


final locationServiceProvider = Provider<LocationServices>((ref) {
  final client = ref.watch(clientProvider);
  return LocationServices(client);
});

class LocationServices {
  final NetworkClient _client;

  LocationServices(this._client);

  final _db = FirebaseFirestore.instance;

  Future<List<LocationData>> getLocationList() async {
    try {
      // final response = await _client.getRequest(
      //     '/location/v1//cities?country=c262885e-94e5-4820-9ab5-152111037907');
      // final data = LocationListResponse.fromJson(response.data);
      // return data.data;
      final ref = await _db.collection('cities').where('party_location', isEqualTo: true).orderBy('name').get();
      final data = ref.docs;
      return data.map((e) => LocationData.fromJson(e.data())).toList();
    } catch (e) {
      rethrow;
    }
  }
}
