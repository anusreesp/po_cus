import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final signupCountryCodeProvider = StateProvider.autoDispose((ref) {
  var link = ref.keepAlive();
  Timer(const Duration(seconds: 1), () {
    link.close();
  });
  return '+65';
});

final selectedCountryCodeProvider = StateProvider.autoDispose<String?>((ref) {
  return;
});
