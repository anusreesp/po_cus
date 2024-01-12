import 'package:flutter_riverpod/flutter_riverpod.dart';

enum CameraPosition { font, back }

final cameraProvider = StateProvider.autoDispose<CameraPosition>((ref) {
  return CameraPosition.back;
});

final cameracProvider = StateProvider.autoDispose<CameraPosition>((ref) {
  return CameraPosition.back;
});
