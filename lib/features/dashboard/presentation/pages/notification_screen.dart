import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:htp_customer/common/widgets_common/app_bar_back_button.dart';
import 'package:htp_customer/features/dashboard/controllers/dashboard_controllers.dart';
import 'package:htp_customer/features/dashboard/controllers/notifications_controller.dart';
import 'package:htp_customer/features/dashboard/data/models/notifications_model.dart';
import 'package:htp_customer/htp_theme.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: () async {
        ref.read(notificationsProvider.notifier).init();
      },
      child: Scaffold(
        appBar: AppBar(
            title: const Text("NOTIFICATIONS", style: man14LightBlue),
            leading: AppbarBackButton(
              onTap: () {
                ref.read(dashboardProvider.notifier).selectTab(TabItem.home);
              },
            )),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 120,
        ),
        child: Consumer(
          builder: (context, ref, _) {
            final controller = ref.watch(notificationsProvider);

            if (controller is NotificationsLoading) {
              return const Center(
                child: const CircularProgressIndicator(
                    color: HtpTheme.goldenColor),
              );
            }

            if (controller is NotificationsLoaded) {
              if (controller.notifications.isEmpty &&
                  controller.previousNotifications.isEmpty &&
                  controller.yesterdayNotifications.isEmpty) {
                return const _Placeholder();
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!controller.notifications.isEmpty)
                    Padding(
                      padding: const EdgeInsets.only(left: 0, top: 12),
                      child: Text(
                        "Today",
                        style: tenor16WhiteOpac,
                      ),
                    ),
                  if (!controller.notifications.isEmpty)
                    ...controller.notifications.map(
                      (data) {
                        // ref.read(notificationsProvider.notifier).filterNotifications(data);
                        return Dismissible(
                            key: Key("${data.id!}-all"),
                            onDismissed: (dismissDirection) {
                              ref
                                  .read(notificationsProvider.notifier)
                                  .deleteNotification(data.id!);
                            },
                            child: _NotificationBox(notification: data));
                      },
                    ),
                  if (!controller.yesterdayNotifications.isEmpty)
                    Padding(
                      padding: const EdgeInsets.only(left: 0, top: 12),
                      child: Text(
                        "Yesterday",
                        style: tenor16WhiteOpac,
                      ),
                    ),
                  if (!controller.yesterdayNotifications.isEmpty)
                    ...controller.yesterdayNotifications.map(
                      (data) {
                        return Dismissible(
                            key: Key("${data.id!}-yesterday"),
                            onDismissed: (dismissDirection) {
                              ref
                                  .read(notificationsProvider.notifier)
                                  .deleteNotification(data.id!);
                            },
                            child: _NotificationBox(notification: data));
                      },
                    ),
                  // if (!controller.thisWeekNotifications.isEmpty)
                  //   Padding(
                  //     padding: const EdgeInsets.only(left: 0, top: 12),
                  //     child: Text(
                  //       "This week",
                  //       style: tenor16WhiteOpac,
                  //     ),
                  //   ),
                  // if (!controller.thisWeekNotifications.isEmpty)
                  //   ...controller.thisWeekNotifications.map((data) {
                  //     return Dismissible(
                  //         key: Key("${data.id!}-this-week"),
                  //         onDismissed: (dismissDirection) {
                  //           ref
                  //               .read(notificationsProvider.notifier)
                  //               .deleteNotification(data.id!);
                  //         },
                  //         child: _NotificationBox(notification: data));
                  //   }),
                  if (!controller.previousNotifications.isEmpty)
                    Padding(
                      padding: const EdgeInsets.only(left: 0, top: 12),
                      child: Text(
                        "Earlier",
                        style: tenor16WhiteOpac,
                      ),
                    ),
                  if (!controller.previousNotifications.isEmpty)
                    ...controller.previousNotifications.map((data) {
                      return Dismissible(
                          key: Key("${data.id!}-earlier"),
                          onDismissed: (dismissDirection) {
                            ref
                                .read(notificationsProvider.notifier)
                                .deleteNotification(data.id!);
                          },
                          child: _NotificationBox(notification: data));
                    })
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 44),
        child: Column(
          children: [
            SvgPicture.asset(
              'assets/svg/icons/notifications.svg',
              height: 80,
              color: Colors.white12,
            ),
            const SizedBox(
              height: 6,
            ),
            const Text(
              'All quiet on the notification front. Enjoy your night and check back later for updates.',
              style: man14LightGrey,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}

class _NotificationBox extends ConsumerWidget {
  final NotificationsModel notification;
  const _NotificationBox({Key? key, required this.notification})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        print(notification.toJson());
        if (notification.readStatus == false) {
          ref
              .read(notificationsProvider.notifier)
              .readNotification(notification.id!);
        }
        // ref.read(notificationsProvider.notifier).redirection(
        //     notification.notificationType ?? "null",
        //     notification.url,
        //     ref,
        //     context);

        // redirectUrl(notification.url ?? '', notification.internalRedirect, ref);

        if (notification.internalRedirect) {
          ref
              .read(notificationsProvider.notifier)
              .redirectNotification(notification);
        } else {
          try {
            launchUrl(Uri.parse(notification.url ?? ''));
          } catch (e) {
            debugPrint(e.toString());
          }
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        margin: const EdgeInsets.only(bottom: 6),
        decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(width: 1, color: HtpTheme.darkGreyColor))),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///Notifications icon
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(right: 12),
              child: SvgPicture.asset(
                ref.read(notificationsProvider.notifier).notificationIcon(
                      notification.notificationType != null
                          ? notification.notificationType!
                          : "welcome",
                    ),
                // width: 26,
              ),
            ),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///Notifications Title
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          notification.title,
                          style: tenor14LightBlue,
                        ),
                      ),

                      ///Notifications duration/time
                      Text(
                        timeText(notification.createdAt),
                        style: man10LightBlueOpac,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),

                  ///Notifications body
                  Text(
                    notification.body!,
                    style: man12LightBlueOpac,
                  )
                ],
              ),
            )
          ],
        ),

        // child: Column(
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: [
        //     Row(
        //       children: [
        //         Container(
        //           alignment: Alignment.centerLeft,
        //           child: SvgPicture.asset(
        //             ref.read(notificationsProvider.notifier).notificationIcon(
        //                   notification.notificationType != null
        //                       ? notification.notificationType!
        //                       : "welcome",
        //                 ),
        //             // width: 26,
        //           ),
        //         ),
        //         // Container(
        //         //     padding: EdgeInsets.only(left: 10),
        //         //     width: timeText(notification.createdAt).contains("min")
        //         //         ? size.width / 1.5
        //         //         : size.width / 1.45,
        //         //     child: Text(
        //         //       notification.title,
        //         //       style: tenor14LightBlue,
        //         //     )),
        //
        //         ///Duration
        //         Text(
        //           timeText(notification.createdAt),
        //           style: man10LightBlueOpac,
        //         )
        //       ],
        //     ),
        //     SizedBox(
        //       height: 6,
        //     ),
        //     Container(
        //         margin: EdgeInsets.only(left: 16),
        //         width: size.width / 1.4,
        //         child: Text(
        //           notification.body!,
        //           style: man12LightBlueOpac,
        //         ))
        //   ],
        // ),
      ),
    );
  }

  String timeText(DateTime dateTime) {
    final now = DateTime.now();
    final diff = now.difference(dateTime);
    if (diff.inMinutes <= 60) {
      return '${diff.inMinutes} min ago';
    }

    if (diff.inHours <= 24) {
      return '${diff.inHours}h ago';
    }

    if (diff.inDays == 1) {
      return '1d ago';
    }
    if (diff.inDays <= 7) {
      return '${diff.inDays}d ago';
    }
    if (diff.inDays >= 7) {
      int weeks = (diff.inDays / 7).toInt();
      return '${weeks}w ago';
    }
    if (diff.inDays > 30) {
      int months = (diff.inDays / 30).toInt();
      return '${months}m ago';
    }

    return DateFormat('dd MMMM yyyy').format(dateTime);
  }
}
