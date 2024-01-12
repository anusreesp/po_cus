// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:htp_customer/features/booking/presentation/pages/confirmation/bill_verification/bill_scan.dart';
// import 'package:htp_customer/features/booking/presentation/pages/confirmation/confirm_ticket.dart';
// import 'package:htp_customer/features/clubs/presentation/pages/playing_now.dart';
// import 'package:htp_customer/features/dashboard/controllers/dashboard_controllers.dart';
// import 'package:htp_customer/features/clubs/presentation/pages/clubs_page.dart';
// import 'package:htp_customer/features/dashboard/presentation/pages/about/aboutus.dart';
// import 'package:htp_customer/features/dashboard/presentation/pages/contactus/contactus.dart';
// import 'package:htp_customer/features/dashboard/presentation/pages/notification_screen.dart';
// import 'package:htp_customer/features/event/presentation/pages/events_details.dart';
// import 'package:htp_customer/features/event/presentation/pages/events_page.dart';
// import 'package:htp_customer/features/event/presentation/pages/single_event.dart';
// import 'package:htp_customer/features/dashboard/presentation/pages/home.dart';
// import 'package:htp_customer/features/idverification/presentation/pages/docs/verification_id.dart';
// import 'package:htp_customer/features/ladiesnight/ladiesnight.dart';
// import 'package:htp_customer/features/membership/presentation/memberships.dart';
// import 'package:htp_customer/features/membership/presentation/request_upgrade.dart';
// import 'package:htp_customer/features/membership/presentation/requested_plan.dart';
// import 'package:htp_customer/features/takehome/takeme.dart';
// import 'package:htp_customer/features/dashboard/presentation/pages/test_page.dart';
// import 'package:htp_customer/features/profile/presentation/booking/new/newdetails.dart';
// import 'package:htp_customer/features/profile/presentation/booking/old/oldbookdetail.dart';
// import 'package:htp_customer/features/profile/presentation/changepassword.dart';
// import 'package:htp_customer/features/profile/presentation/favouriteclub.dart';
// import 'package:htp_customer/features/profile/presentation/booking/new/newbooking.dart';
// import 'package:htp_customer/features/profile/presentation/booking/old/oldbooking.dart';
// import 'package:htp_customer/features/profile/presentation/profile_page.dart';
// import 'package:htp_customer/features/profile/presentation/profileupdate.dart';
// import 'package:htp_customer/features/dashboard/presentation/widgets/confirmation.dart';
// import '../../../booking/presentation/pages/entry_booking.dart';
// import '../../../clubs/presentation/pages/club_details.dart';
// import '../../../locations/presentation/location.dart';
// import '../../../profile/presentation/booking/new/newpart.dart';
//
// ///Navigation inspired by Andrea blog
// ///https://codewithandrea.com/articles/multiple-navigators-bottom-navigation-bar/
//
// class TabNavigator extends ConsumerWidget {
//   final TabItem tabItem;
//   const TabNavigator({Key? key, required this.tabItem}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final routeBuilder = getRoutesBuilder(tabItem, context);
//     return Navigator(
//       key: ref.read(dashboardProvider.notifier).navigationKeys[tabItem],
//       initialRoute: '/',
//       onGenerateRoute: (routeSetting) {
//         return MaterialPageRoute(
//           settings: routeSetting,
//           builder: (context) => routeBuilder[routeSetting.name!]!(context),
//         );
//       },
//     );
//   }
//
//   Map<String, WidgetBuilder> getRoutesBuilder(
//       TabItem tabItem, BuildContext context) {
//     switch (tabItem) {
//       case TabItem.home:
//         return _homeRouteBuilder(context);
//
//       case TabItem.clubs:
//         return _clubRouteBuilder(context);
//
//       case TabItem.events:
//         return _eventsRouteBuilder(context);
//
//       case TabItem.locations:
//         return _locationsRouteBuilder(context);
//
//       case TabItem.membership:
//         return _membershipRouteBuilder(context);
//
//       // case TabItem.misc:
//       //   return _miscRouteBuilder(context);
//     }
//   }
//
//   Map<String, WidgetBuilder> _homeRouteBuilder(BuildContext context) {
//     return {
//       '/': (context) => HomeScreen(),
//       LocationPage.route: (context) => LocationPage(),
//       ClubDetails.route: (context) => ClubDetails(),
//       EventDetails.route: (context) => EventDetails(),
//       // TableBookingPage.route: (context) => const TableBookingPage(),
//       // EntryBooking.route: (context) => const EntryBooking(),
//       LadiesNight.route: (context) => LadiesNight(),
//       //---------------profile associated-------------------
//       ProfilePage.route: (context) => ProfilePage(),
//       UpdateProfilePage.route: (context) => UpdateProfilePage(),
//       NewBooking.route: (context) => NewBooking(),
//       NewDetails.route: (context) => const NewDetails(),
//
//       NewPartDetails.route: (context) => NewPartDetails(),
//       OldBooking.route: (context) => OldBooking(),
//       OldBookingDetails.route: (context) => OldBookingDetails(),
//       FavouriteClub.route: (context) => const FavouriteClub(),
//       ChangePassword.route: (context) => ChangePassword(),
//       ConfirmTicket.route: (context) => ConfirmTicket(),
//
//       //event
//       // EventDetails.route: (context) => EventDetails(),
//       // SingleEventDetails.route: (context) => SingleEventDetails(),
//
//       ContactUs.route: (context) => const ContactUs(),
//       AboutUs.route: (context) => const AboutUs(),
//       ScanBill.route: (context) => ScanBill()
//     };
//   }
//
//   Map<String, WidgetBuilder> _clubRouteBuilder(BuildContext context) {
//     return {
//       '/': (context) => const ClubsPage(),
//       ClubDetails.route: (context) => ClubDetails(),
//       // TableBookingPage.route: (context) => const TableBookingPage(),
//       // EntryBooking.route: (context) => const EntryBooking(),
//       // Confirmation.route: (context) => const Confirmation(),
//       PlayingNow.route: (context) => const PlayingNow(),
//       ConfirmTicket.route: (context) => ConfirmTicket(),
//       // ConfirmTicket.route: (context) => ConfirmTicket()
//     };
//   }
//
//   Map<String, WidgetBuilder> _eventsRouteBuilder(BuildContext context) {
//     return {
//       '/': (context) => EventsPage(),
//       EventDetails.route: (context) => EventDetails(),
//       ConfirmTicket.route: (context) => ConfirmTicket(),
//       // SingleEventDetails.route: (context) => SingleEventDetails(),
//     };
//   }
//
//   Map<String, WidgetBuilder> _locationsRouteBuilder(BuildContext context) {
//     return {
//       // '/': (context) => LocationPage(),
//       '/': (context) => NotificationsScreen(),
//       // TestPage.route: (context) => const TestPage(),
//       IDVerificationPage.route: (context) => const IDVerificationPage(),
//       ConfirmTicket.route: (context) => ConfirmTicket(),
//     };
//   }
//
//   Map<String, WidgetBuilder> _membershipRouteBuilder(BuildContext context) {
//     return {
//       '/': (context) => const MembershipsPage(),
//       RequestPlan.route: (context) => const RequestPlan(),
//       RequestUpgrade.route: (context) => const RequestUpgrade(),
//       ContactUs.route: (context) => const ContactUs(),
//
//       ClubDetails.route: (context) => ClubDetails(),
//       EventDetails.route: (context) => EventDetails(),
//       LocationPage.route: (context) => LocationPage(),
//
//       //---------------profile associated-------------------
//       ProfilePage.route: (context) => ProfilePage(),
//       UpdateProfilePage.route: (context) => UpdateProfilePage(),
//       NewBooking.route: (context) => NewBooking(),
//       NewDetails.route: (context) => const NewDetails(),
//
//       NewPartDetails.route: (context) => NewPartDetails(),
//       OldBooking.route: (context) => OldBooking(),
//       OldBookingDetails.route: (context) => OldBookingDetails(),
//       FavouriteClub.route: (context) => const FavouriteClub(),
//       ChangePassword.route: (context) => ChangePassword(),
//       NotificationsScreen.route: (context) => const NotificationsScreen(),
//       ConfirmTicket.route: (context) => ConfirmTicket(),
//       TakeMeHome.route: (context) => TakeMeHome(),
//     };
//   }
//
//   // Map<String, WidgetBuilder> _miscRouteBuilder(BuildContext context) {
//   //   return {
//   //     '/': (context) => MiscPlaceholder(),
//   //     LocationPage.route: (context) => LocationPage(),
//   //     // TestPage.route: (context) => const TestPage(),
//   //     TakeMeHome.route: (context) => TakeMeHome(),
//   //     IDVerificationPage.route: (context) => const IDVerificationPage(),
//   //   };
//   // }
// }
// //
// // class MiscPlaceholder extends StatefulWidget {
// //   const MiscPlaceholder({Key? key}) : super(key: key);
// //
// //   @override
// //   State<MiscPlaceholder> createState() => _MiscPlaceholderState();
// // }
// //
// // class _MiscPlaceholderState extends State<MiscPlaceholder> {
// //
// //   @override
// //   void initState() {
// //     Navigator.pop(context);
// //     super.initState();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return const Placeholder();
// //   }
// // }
// //
