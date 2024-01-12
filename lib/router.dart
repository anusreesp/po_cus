import 'package:flutter/material.dart';
import 'package:htp_customer/features/booking/presentation/pages/confirmation/entry_confirmation.dart';
import 'package:htp_customer/features/booking/presentation/pages/table_booking.dart';
import 'package:htp_customer/features/clubs/data/models/fire_club_details.dart';
import 'package:htp_customer/features/clubs/presentation/pages/new/club_details_page.dart';
import 'package:htp_customer/features/dashboard/presentation/pages/home.dart';
import 'package:htp_customer/features/membership/presentation/screens/membership_request_status.dart';
import 'package:htp_customer/features/profile/presentation/screens/about_us.dart';
import 'package:htp_customer/features/profile/presentation/screens/account_settings.dart';
import 'package:htp_customer/features/profile/presentation/screens/change_email_screen.dart';
import 'package:htp_customer/features/profile/presentation/screens/change_mobile_screen.dart';
import 'package:htp_customer/features/profile/presentation/screens/favorite_clubs.dart';
import 'package:htp_customer/features/profile/presentation/screens/loyalty_points.dart';
import 'package:htp_customer/features/profile/presentation/screens/my_bookings_screen.dart';
import 'package:htp_customer/features/profile/presentation/screens/otp_verification_screen.dart';
import 'package:htp_customer/features/profile/presentation/screens/profile_screen.dart';
import 'package:htp_customer/features/membership/presentation/screens/membership_form_main.dart';
import 'package:htp_customer/features/profile/presentation/screens/profile_update_screen.dart';
import 'package:htp_customer/features/profile/presentation/screens/test/my_booking_screen.dart';
import 'package:htp_customer/splashscreen/splash_screen_new.dart';
import 'package:htp_customer/startup_page.dart';
import 'package:htp_customer/features/booking/presentation/pages/confirmation/bill_verification/bill_scan.dart';
import 'package:htp_customer/features/clubs/presentation/pages/playing_now.dart';
import 'package:htp_customer/features/dashboard/presentation/pages/about/aboutus.dart';
import 'package:htp_customer/features/dashboard/presentation/pages/contactus/contactus.dart';
import 'package:htp_customer/features/event/presentation/pages/events_details.dart';
import 'package:htp_customer/features/idverification/presentation/pages/docs/verification_id.dart';
import 'package:htp_customer/features/ladiesnight/ladiesnight.dart';
import 'package:htp_customer/features/takehome/takeme.dart';
import 'package:htp_customer/features/profile/presentation/booking/new/newdetails.dart';
import 'package:htp_customer/features/profile/presentation/booking/old/oldbookdetail.dart';
import 'package:htp_customer/features/profile/presentation/changepassword.dart';
import 'package:htp_customer/features/profile/presentation/favouriteclub.dart';
import 'package:htp_customer/features/profile/presentation/booking/new/newbooking.dart';
import 'package:htp_customer/features/profile/presentation/booking/old/oldbooking.dart';
import 'package:htp_customer/features/profile/presentation/profile_page.dart';
import 'package:htp_customer/features/profile/presentation/profileupdate.dart';
import 'features/booking/presentation/pages/entry_booking.dart';
// import 'features/clubs/presentation/pages/club_details_old.dart';
import 'features/locations/presentation/location.dart';
import 'features/membership/presentation/memberships.dart';
import 'features/profile/presentation/booking/new/newpart.dart';

final mainNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'MainNavigator');

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case Dashboard.route:
      //   return MaterialPageRoute(builder: (_) => const Dashboard());
      // case HomeScreen.route:
      //   return MaterialPageRoute(builder: (_) => const HomeScreen());
      case StartupPage.route:
        return MaterialPageRoute(builder: (_) => const StartupPage());

      // case ConfirmTicket.route:
      //   return MaterialPageRoute(
      //       settings: settings, builder: (_) => ConfirmTicket());

      case TableBookingPage.route:
        return MaterialPageRoute(builder: (_) {
          final data = settings.arguments as ClubDataModel;
          return TableBookingPage(data: data);
        });

      case EntryBooking.route:
        return MaterialPageRoute(builder: (_) {
          // final data = settings.arguments as ClubDataModel;

          final snapData = settings.arguments as FireClubDetails;
          return EntryBooking(
            // data: data,
            // snapData: snapData,
            data: snapData.data,
          );
        });

      case MembershipFormMain.route:
        return MaterialPageRoute(builder: (_) {
          return const MembershipFormMain();
        });

      case SplashScreenNew.route:
        return MaterialPageRoute(builder: (_) {
          return const SplashScreenNew();
        });

      case EntryConfirmation.route:
        return MaterialPageRoute(builder: (_) {
          final args = settings.arguments as Map<String, dynamic>;
          return EntryConfirmation(id: args['id'], bookingType: args['type']);
        });

      // --------------------------- New Route implementation -----------------

      default:
        return MaterialPageRoute(
            builder: (_) =>  Scaffold(
                  body: Center(child: Text("No route found \n${settings.name}", textAlign: TextAlign.center,)),
                ));
    }
  }
}

final Map<String, Widget Function(BuildContext)> routesList = {
  HomeScreen.route: (context) => HomeScreen(),
  LocationPage.route: (context) => LocationPage(),
  ClubDetailsPage.route: (context) => ClubDetailsPage(),
  EventDetails.route: (context) => EventDetails(),
  LadiesNight.route: (context) => LadiesNight(),
  // ProfilePage.route: (context) => ProfilePage(),
  // UpdateProfilePage.route: (context) => UpdateProfilePage(),
  NewBooking.route: (context) => NewBooking(),
  NewDetails.route: (context) => const NewDetails(),
  // NewPartDetails.route: (context) => NewPartDetails(),
  // OldBooking.route: (context) => OldBooking(),
  // OldBookingDetails.route: (context) => OldBookingDetails(),
  FavouriteClub.route: (context) => const FavouriteClub(),
  ChangePassword.route: (context) => ChangePassword(),
  // ConfirmTicket.route: (context) => ConfirmTicket(),
  // AboutUs.route: (context) => const AboutUs(),
  // ScanBill.route: (context) => ScanBill(),
  // ClubDetails.route: (context) => ClubDetails(),
  // PlayingNow.route: (context) => const PlayingNow(),
  // ConfirmTicket.route: (context) => ConfirmTicket(),
  // EventDetails.route: (context) => EventDetails(),
  // IDVerificationPage.route: (context) => const IDVerificationPage(),
  // ConfirmTicket.route: (context) => ConfirmTicket(),
  // RequestPlan.route: (context) => const RequestPlan(),
  // RequestUpgrade.route: (context) => const RequestUpgrade(),
  ContactUs.route: (context) => const ContactUs(),
  MembershipsPage.route: (context) => const MembershipsPage(),
  TakeMeHome.route: (context) => TakeMeHome(),
  AccountSettingsPage.route: (context) => AccountSettingsPage(),
  ProfileScreen.route: (context) => ProfileScreen(),
  ChangeMobileScreen.route: (context) => ChangeMobileScreen(),
  ChangeEmailScreen.route: (context) => ChangeEmailScreen(),
  OtpVerificationScreen.route: (context) => OtpVerificationScreen(),
  MyBookingsScreen.route: (context) => MyBookingsScreen(),
  MyBookingsScreenTest.route: (context) => MyBookingsScreenTest(),
  MyFavoriteClubsPage.route: (context) => MyFavoriteClubsPage(),
  AboutUsNew.route: (context) => AboutUsNew(),
  MembershipRequestStatus.route: (context) => MembershipRequestStatus(),
  UpdateProfileScreen.route: (context) => UpdateProfileScreen(),
  LoyaltyPointsScreen.route: (context) => LoyaltyPointsScreen(),
};
