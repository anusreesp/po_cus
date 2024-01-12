
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/authentication/data/service/firebase_auth_service.dart';

final authStateChangeProvider = StreamProvider<User?>((ref) =>
    ref.watch(firebaseAuthServiceProvider).authStateChanges());
