
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum MembershipTab {basicForm, idVerification, membership}

final membershipFormIndexProvider = StateProvider.autoDispose<MembershipTab>((ref) => MembershipTab.basicForm);