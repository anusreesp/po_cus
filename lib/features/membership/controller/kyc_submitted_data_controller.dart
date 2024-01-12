
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/authentication/data/service/firebase_auth_service.dart';
import 'package:htp_customer/features/membership/data/model/kyc_requested_data.dart';
import 'package:htp_customer/features/membership/data/services/membership_services.dart';

final kycSubmittedDataProvider = FutureProvider.autoDispose<KycRequestedData?>((ref) async{
  final service = ref.watch(membershipServiceProvider);
  final auth = ref.watch(firebaseAuthServiceProvider);
  return await service.kycRequestedData(auth.uid);
});