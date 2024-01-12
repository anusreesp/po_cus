import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/authentication/controllers/auth_controller.dart';
import 'package:htp_customer/authentication/controllers/fcm_controller.dart';
import 'package:htp_customer/authentication/data/service/firebase_auth_service.dart';
import 'package:htp_customer/common/controllers/branch_controller.dart';
import 'package:htp_customer/features/clubs/presentation/pages/new/clubs_list.dart';
import 'package:htp_customer/features/dashboard/controllers/ad_popup_controller.dart';
import 'package:htp_customer/features/dashboard/controllers/dashboard_controllers.dart';
import 'package:htp_customer/features/dashboard/controllers/notifications_controller.dart';
import 'package:htp_customer/features/dashboard/presentation/pages/home.dart';
import 'package:htp_customer/features/dashboard/presentation/pages/notification_screen.dart';
import 'package:htp_customer/features/dashboard/presentation/widgets/custom_bottom_navigation.dart';
import 'package:htp_customer/features/event/presentation/pages/events_page.dart';
import 'package:htp_customer/features/profile/presentation/widgets/support.dart';
import '../../../../authentication/controllers/deep_linking.dart';
import '../widgets/ad_popup.dart';
import '../widgets/custom_drawer.dart';

class Dashboard extends ConsumerWidget {
  static const route = '/dashboard';
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final controller = ref.watch(dashboardProvider);
    // final ad = ref.watch(adPopupProvider);
    // print("------->>>$ad");
    // final List temp=[
    //   'https://www.cameraegg.org/wp-content/uploads/2016/01/Nikon-D500-Sample-Images-2.jpg',
    //   'https://cdn.photographylife.com/wp-content/uploads/2016/01/Sony-A6000-Sample-Images-22.jpg',
    //   'https://www.camera-rumors.com/wp-content/uploads/2015/01/nikon-d750-sample-images-1024x683.jpg'
    // ];


    ref.read(fcmProvider);
    ref.read(notificationsProvider);
    ref.read(deepLinkingProvider);
    // ref.read(branchProvider);

    return WillPopScope(
      onWillPop: () async {
        if (controller != TabItem.home) {
          ref.read(dashboardProvider.notifier).selectTab(TabItem.home);
          return false;
        }

        return true;
      },
      child: Scaffold(
        key: scaffoldKey,
        // key: ref.read(dashboardProvider.notifier).dashboardScaffoldState,
        // extendBodyBehindAppBar: true,
        extendBody: true,
        drawer: const CustomDrawer(),

        body: IndexedStack(
          index: controller.index,
          children: [
            // MembershipsPage(),
            HomeScreen(
              dashBoardScaffoldKey: scaffoldKey,
            ),
            // ClubsPage(),
            ClubsList(
              dashBoardScaffoldKey: scaffoldKey,
            ),
            EventsPage(
              dashBoardScaffoldKey: scaffoldKey,
            ),
            const SupportPage(isNotFromHome: false),
            const NotificationsScreen(),
            // MembershipsPage()
          ],
        ),
        bottomNavigationBar: const CustomBottomNavigation(),
      ),
    );
  }
}
