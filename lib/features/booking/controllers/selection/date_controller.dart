import 'package:flutter_riverpod/flutter_riverpod.dart';

final datePickProvider = StateProvider.autoDispose<DateTime?>((ref) {
  return null;
});

final slotPickProvider = StateProvider.autoDispose<String?>((ref) => null);
