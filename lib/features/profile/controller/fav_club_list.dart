

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/features/clubs/data/models/fire_club_details.dart';
import 'package:htp_customer/features/clubs/data/services/club_services.dart';

import '../../clubs/data/models/club_list_response.dart';

final favClubListProvider = FutureProvider.autoDispose<List<ClubDataModel>>((ref) async{
  final service = ref.watch(clubServiceProvider);
  return await service.getAllFavClubs();
});