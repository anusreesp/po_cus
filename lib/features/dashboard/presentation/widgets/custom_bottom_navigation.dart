import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/common/widgets_common/needles_widget.dart';
import 'package:htp_customer/features/clubs/controllers/new/clubs_filterlist_controller.dart';
import 'package:htp_customer/features/clubs/presentation/widgets/new/club_filter.dart';
import 'package:htp_customer/features/dashboard/controllers/dashboard_controllers.dart';
import 'package:htp_customer/features/dashboard/controllers/notifications_controller.dart';
import 'package:htp_customer/features/event/controllers/events_filterlist_controller.dart';
import 'package:htp_customer/features/event/presentation/widget/events_filter.dart';

import 'bottom_navigation_button.dart';

class CustomBottomNavigation extends ConsumerWidget {
  const CustomBottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTab = ref.watch(dashboardProvider);
    return Container(
      color: Colors.black.withOpacity(0.8),
      // elevation: 1,
      // clipBehavior: Clip.antiAlias,
      child: SizedBox(
        // height: 62,
        height: 76,
        child: Column(
          children: [
            const NeedleDoubleSided(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BottomNavigationButton(
                  iconName: "home",
                  text: "Home",
                  active: currentTab == TabItem.home,
                  onTap: () {
                    ref
                        .read(dashboardProvider.notifier)
                        .selectTab(TabItem.home);
                  },
                ),
                BottomNavigationButton(
                    iconName: "bottle",
                    text: "Clubs",
                    active: currentTab == TabItem.clubs,
                    onTap: () {
                      ref.invalidate(selectedClubProvider);
                      ref.invalidate(clubsFilterListProvider);
                      ref
                          .read(dashboardProvider.notifier)
                          .selectTab(TabItem.clubs);
                    }),
                BottomNavigationButton(
                    iconName: "ticket",
                    text: "Events",
                    active: currentTab == TabItem.events,
                    onTap: () {
                      ref.invalidate(selectedValProvider);
                      ref.invalidate(eventsFilterListProvider);
                      ref
                          .read(dashboardProvider.notifier)
                          .selectTab(TabItem.events);
                    }),
                BottomNavigationButton(
                    iconName: 'chat',
                    text: "VIP Plans",
                    active: currentTab == TabItem.support,
                    onTap: () {
                      ref
                          .read(dashboardProvider.notifier)
                          .selectTab(TabItem.support);
                    }),
                Consumer(builder: (context, ref, _) {
                  final controller = ref.watch(notificationsProvider);
                  if (controller is NotificationsLoaded &&
                      controller.unreadCount <= 0) {
                    // controller.unreadCount
                    return BottomNavigationButton(
                        // iconName: "bell_dot",
                        iconName: 'bell_icon_grey',
                        // iconName: "notification_alert",
                        text: "Updates",
                        active: currentTab == TabItem.notifications,
                        onTap: () {
                          ref
                              .read(dashboardProvider.notifier)
                              .selectTab(TabItem.notifications);
                        });
                  }
                  return BottomNavigationButton(
                      iconName: "notification_alert",
                      noColor: true,
                      // iconName: "bell_dot",
                      text: "Updates",
                      active: currentTab == TabItem.notifications,
                      onTap: () {
                        ref
                            .read(dashboardProvider.notifier)
                            .selectTab(TabItem.notifications);
                      });
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


//
// class CustomBottomNavigation extends ConsumerWidget {
//   const CustomBottomNavigation({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final currentTab = ref.watch(dashboardProvider);
//     return ClipRRect(
//       borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
//       child: BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//         child: BottomAppBar(
//           color: Colors.black26,
//           // elevation: 1,
//           // clipBehavior: Clip.antiAlias,
//           child: Container(
//             // height: 62,
//             height: 72,
//             // margin: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
//             decoration: const BoxDecoration(
//                 // color: Colors.black26,
//                 borderRadius: BorderRadius.only(topRight: Radius.circular(16), topLeft: Radius.circular(16))
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 BottomNavigationButton(
//                   iconName: "home",
//                   text: "Home",
//                   active: currentTab == TabItem.home,
//                   onTap: () {
//                     ref
//                         .read(dashboardProvider.notifier)
//                         .selectTab(TabItem.home);
//                   },
//                 ),
//                 BottomNavigationButton(
//                     iconName: /* "club" */ "clubs",
//                     text: "Clubs",
//                     active: currentTab == TabItem.clubs,
//                     onTap: () {
//                       ref
//                           .read(dashboardProvider.notifier)
//                           .selectTab(TabItem.clubs);
//                     }),
//                 BottomNavigationButton(
//                     iconName: "event",
//                     text: "Events",
//                     active: currentTab == TabItem.events,
//                     onTap: () {
//                       ref
//                           .read(dashboardProvider.notifier)
//                           .selectTab(TabItem.events);
//                     }),
//
//                 Consumer(builder: (context, ref, _){
//                   final controller = ref.watch(notificationsProvider);
//                   if(controller is NotificationsLoaded && controller.unreadCount <= 0){
//                     // controller.unreadCount
//                     return BottomNavigationButton(
//                         iconName: "notification_bell",
//                         text: "Updates",
//                         active: currentTab == TabItem.locations,
//                         onTap: () {
//                           ref
//                               .read(dashboardProvider.notifier)
//                               .selectTab(TabItem.locations);
//                         });
//                   }
//                   return BottomNavigationButton(
//                       iconName: "notifications",
//                       text: "Updates",
//                       active: currentTab == TabItem.locations,
//                       onTap: () {
//                         ref
//                             .read(dashboardProvider.notifier)
//                             .selectTab(TabItem.locations);
//                       });
//                 }),
//
//                 BottomNavigationButton(
//                     iconName: /* "membership" */ "vip",
//                     text: "VIP Plans",
//                     active: currentTab == TabItem.membership,
//                     onTap: () {
//                       ref
//                           .read(dashboardProvider.notifier)
//                           .selectTab(TabItem.membership);
//                     }),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
