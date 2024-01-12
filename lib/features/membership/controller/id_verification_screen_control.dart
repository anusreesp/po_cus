import 'package:flutter_riverpod/flutter_riverpod.dart';

enum VerificationScreen {upload, selfie, selfieUpload }

final idVerificationScreen = StateProvider.autoDispose<VerificationScreen>(
    (ref) => VerificationScreen.upload);
