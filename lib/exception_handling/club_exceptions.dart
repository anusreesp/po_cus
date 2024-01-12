import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/exception_handling/exception_ui.dart';
import 'package:htp_customer/features/dashboard/controllers/dashboard_controllers.dart';

import '../features/locations/presentation/location.dart';

class ClubNotFoundExceptions extends ConsumerWidget {
  const ClubNotFoundExceptions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ExceptionUi(
      data: "No nearby clubs found. Consider changing location.",
      path: "assets/svg/images/exception/clubs.svg",
      onTap: () {
        ref
            .read(dashboardProvider.notifier)
            .gotoPage(TabItem.home, LocationPage.route);
      },
      buttonText: "Change Location",
    );
  }
}

class ClubTryAgainExceptions extends ConsumerWidget {
  const ClubTryAgainExceptions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ExceptionUi(
        data:
            "We could not find the exact match. Please try searching again or consider changing location",
        path: "assets/svg/images/exception/clubs.svg",
        onTap: () {
          ref
              .read(dashboardProvider.notifier)
              .gotoPage(TabItem.home, LocationPage.route);
        },
        buttonText: "Change Location");
  }
}
