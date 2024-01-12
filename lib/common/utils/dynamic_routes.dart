import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/features/booking/presentation/pages/confirmation/confirm_ticket.dart';
import 'package:htp_customer/features/booking/presentation/pages/confirmation/entry_confirmation.dart';
// import 'package:htp_customer/features/clubs/presentation/pages/club_details_old.dart';
import 'package:htp_customer/features/clubs/presentation/pages/new/club_details_page.dart';
import 'package:htp_customer/features/dashboard/controllers/dashboard_controllers.dart';
import 'package:htp_customer/features/event/presentation/pages/events_details.dart';
import 'package:htp_customer/features/membership/presentation/memberships.dart';
import 'package:htp_customer/features/membership/presentation/screens/membership_request_status.dart';
import 'package:htp_customer/features/profile/presentation/profile_page.dart';
import 'package:htp_customer/features/profile/presentation/screens/loyalty_points.dart';
import 'package:htp_customer/features/profile/presentation/screens/profile_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../features/booking/presentation/widgets/club_details.dart';
import '../../features/dashboard/presentation/pages/home.dart';

///This function finds switches to the value received from notification url
///and returns the route of the screen
String getScreenName(String route) {
  switch (route) {
    // case 'event_entry_bookings':
    //   return ConfirmTicket.route;

    // case 'table_booking':
    //   return ConfirmTicket.route;

    // case 'club_entry_bookings':
    //   return ConfirmTicket.route;

    case 'clubs':
      return ClubDetailsPage.route;

    case 'events':
      return EventDetails.route;

    case 'users':
      return ProfileScreen.route;

    case 'contact_us':
      return 'contact_us';

    case 'loyality_points':
      return LoyaltyPointsScreen.route;

    case 'membership_requests':
      return MembershipRequestStatus.route;

    case 'table_booking':
      return EntryConfirmation.route;

    case 'event_entry_booking':
      return EntryConfirmation.route;

    case 'club_entry_booking':
      return EntryConfirmation.route;

    default:
      return HomeScreen.route;
  }
}

/// Get which is the active tab recently opened from bottom bar.
TabItem getTab(String screenName) {
  switch (screenName) {
    // case ConfirmTicket.route:
    //   return TabItem.home;

    case 'contact_us':
      return TabItem.support;

    case ClubDetailsPage.route:
      return TabItem.clubs;

    case EventDetails.route:
      return TabItem.events;

    case HomeScreen.route:
      return TabItem.home;

    case ProfileScreen.route:
      return TabItem.home;

    default:
      return TabItem.home;
  }
}

/// Redirection function if internal or external
redirect(Map<String, dynamic> data, Ref ref, {bool deepLink = false}) {
  //Example: event_entry_bookings/135582c8-5272-40b7-9169-32b752cf9671
  data.forEach((key, value) {
    print("....................|${value}");
  });
  final isInternal = data['internal_redirect']?.toString();
  final url = data['url'].toString();

  if (isInternal == null || isInternal == 'true') {
    List<String> urlComponent = [];
    if (deepLink) {
      urlComponent = url.split('=');
    } else {
      urlComponent = url.split('/');
    }
    final screen = getScreenName(urlComponent.first);
    final tab = getTab(screen);
    // if (screen == ConfirmTicket.route) {
    //   print("ROUTE INITIATED");
    //   ref.read(dashboardProvider.notifier).gotoPage(
    //       TabItem.home, ConfirmTicket.route,
    //       arguments: TicketValue(urlComponent.last, urlComponent.first));
    // } else
    if (tab == TabItem.support) {
      ref.read(dashboardProvider.notifier).selectTab(TabItem.support);
      return;
    }

    if (screen == EntryConfirmation.route) {
      ref.read(dashboardProvider.notifier).gotoPage(TabItem.home, screen,
          arguments: {'id': urlComponent.last, 'type': urlComponent.first});
      return;
    }

    if (screen == HomeScreen.route) {
      ref.read(dashboardProvider.notifier).selectTab(TabItem.home);
    } else {
      if (urlComponent.last.isEmpty) {
        ref.read(dashboardProvider.notifier).selectTab(tab);
      } else {
        ref
            .read(dashboardProvider.notifier)
            .gotoPage(TabItem.home, screen, arguments: urlComponent.last);
      }
    }
    // _ref.read(dashboardProvider.notifier).pushPage(TabItem.membership, MaterialPageRoute(builder: builder));
  } else {
    //Later implementation for external
    launchUrl(Uri.parse(url));
  }
}
///redirection with url of booking data to specific screen.
redirectUrl(String url, bool isInternal, WidgetRef ref) {
  //Example: event_entry_bookings/135582c8-5272-40b7-9169-32b752cf9671
  // final url = data['url'].toString();
  if (isInternal) {
    List<String> urlComponent = url.split('/');

    print(urlComponent);
    final screen = getScreenName(urlComponent.first);
    final tab = getTab(screen);

    // if (screen == ConfirmTicket.route) {
    //   print("ROUTE INITIATED");
    //   ref.read(dashboardProvider.notifier).gotoPage(
    //       TabItem.home, ConfirmTicket.route,
    //       arguments: TicketValue(urlComponent.last, urlComponent.first));
    // } else

    if (screen == HomeScreen.route) {
      ref.read(dashboardProvider.notifier).selectTab(TabItem.home);
    } else if (screen == ProfileScreen.route) {
      ref
          .read(dashboardProvider.notifier)
          .gotoPage(TabItem.home, ProfileScreen.route);
    } else {
      ref
          .read(dashboardProvider.notifier)
          .gotoPage(tab, screen, arguments: urlComponent.last);
    }
    // _ref.read(dashboardProvider.notifier).pushPage(TabItem.membership, MaterialPageRoute(builder: builder));
  } else {
    //Later implementation for external
    launchUrl(Uri.parse(url));
  }
}
