import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/exception_handling/exception_ui.dart';

import '../features/dashboard/controllers/dashboard_controllers.dart';
import '../features/locations/presentation/location.dart';

class EventNotFoundExceptions extends ConsumerWidget {
  const EventNotFoundExceptions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ExceptionUi(
      data: "No nearby event found. Consider changing location.",
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

class EventTryAgainExceptions extends ConsumerWidget {
  final String msg;
  const EventTryAgainExceptions({super.key, required this.msg});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ExceptionUi(
        data: "$msg. Try again with new location.",
        path: "assets/svg/images/exception/events.svg",
        onTap: () {
          ref
              .read(dashboardProvider.notifier)
              .gotoPage(TabItem.home, LocationPage.route);
        },
        buttonText: "Change Location");
  }
}
