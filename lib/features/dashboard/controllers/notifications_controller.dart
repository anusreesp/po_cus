import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/common/utils/dynamic_routes.dart';
import 'package:htp_customer/features/booking/presentation/pages/confirmation/entry_confirmation.dart';
import 'package:htp_customer/features/clubs/presentation/pages/new/club_details_page.dart';
import 'package:htp_customer/features/membership/presentation/memberships.dart';
import 'package:htp_customer/features/membership/presentation/screens/membership_request_status.dart';
import 'package:htp_customer/features/profile/presentation/screens/loyalty_points.dart';
import 'package:htp_customer/features/profile/presentation/screens/profile_screen.dart';
import 'package:htp_customer/router.dart';
import '../../../authentication/data/service/firebase_auth_service.dart';
import '../../booking/controllers/entryconfirmation_controller.dart';
import '../data/models/notifications_model.dart';
import '../data/services/dashboard_service.dart';
import 'dashboard_controllers.dart';

final notificationsProvider = StateNotifierProvider.autoDispose((ref) {
  final service = ref.watch(dashboardServiceProvider);
  final auth = ref.watch(firebaseAuthServiceProvider);
  return NotificationsController(service, auth, ref);
});

class NotificationsController extends StateNotifier<NotificationsStates> {
  final DashboardService _service;
  final FirebaseAuthenticate _auth;
  final Ref _ref;
  NotificationsController(this._service, this._auth, this._ref)
      : super(NotificationsInitial()) {
    init();
  }
  /// Initial function to get all notifications.
  init() async {
    try {
      state = NotificationsLoading();
      final notifications = await _service.getAllNotifications(_auth.uid);
      filterNotifications(notifications);
      // state = NotificationsLoaded(notifications, [], [], [], 0);
    } catch (e) {
      state = NotificationError(e.toString());
    }
  }

  /// Filtering notification to separate lists of today, yesterday, this week and earlier.
  filterNotifications(
    List<NotificationsModel> data,
  ) {
    final now = DateTime.now();
    final List<NotificationsModel> today = [];
    final List<NotificationsModel> yesterday = [];
    // final List<NotificationsModel> thisWeek = [];
    final List<NotificationsModel> earlier = [];
    int unreadCount = 0;
    data.forEach((element) {
      if (element.readStatus == false) {
        unreadCount++;
      }
    });
    data.forEach((element) {
      final diff = now.difference(element.createdAt);
      if (diff.inDays == 0) {
        today.add(element);
      }
      if (diff.inDays == 1) {
        yesterday.add(element);
      }
      // if (diff.inDays >= 2 && diff.inDays <= 30) {
      //   thisWeek.add(element);
      // }
      if (diff.inDays > 2) {
        earlier.add(element);
      }
    });
    state =
        NotificationsLoaded(today, yesterday, earlier, unreadCount);
  }

  /// Icons for notification by its type.
  notificationIcon(String type) {
    switch (type) {
      case "welcome":
        return 'assets/svg/notification_icons/Partyone.svg';
      case "club_booking":
        return 'assets/svg/notification_icons/club.svg';
      case "club_booking_denied":
        return 'assets/svg/notification_icons/club_fail.svg';
      case "club_booking_success":
        return 'assets/svg/notification_icons/club_success.svg';
      case "event_booking":
        return 'assets/svg/notification_icons/event.svg';
      case "event_booking_denied":
        return 'assets/svg/notification_icons/event_fail.svg';
      case "event_booking_success":
        return 'assets/svg/notification_icons/event_success.svg';
      case "favorite":
        return 'assets/svg/notification_icons/heart.svg';
      case "local_offer":
        return 'assets/svg/notification_icons/local_offer.svg';
      case "membership":
        return 'assets/svg/notification_icons/membership.svg';
      case "membership_denied":
        return 'assets/svg/notification_icons/membership_fail.svg';
      case "membership_success":
        return 'assets/svg/notification_icons/membership_success.svg';
      case "cross":
        return 'https://storage.googleapis.com/party_images/1689658315773-red_cross.svg';
      case "profile":
        return "https://storage.googleapis.com/party_images/1689658315770-person.svg";
      case "info":
        return "https://storage.googleapis.com/party_images/1689658315692-alert.svg";
      default:
        return 'assets/svg/notification_icons/Partyone.svg';
    }
  }

  ///function to read a notification.
  readNotification(String id) async {
    try {
      await _service.updateNotificationRead(id);
      final notifications = await _service.getAllNotifications(_auth.uid);
      filterNotifications(notifications);
    } catch (e) {
      state = NotificationError(e.toString());
    }
  }

  /// Function to delete notification.
  deleteNotification(String id) async {
    try {
      await _service.deleteNotification(id);
      final notifications = await _service.getAllNotifications(_auth.uid);
      filterNotifications(notifications);
    } catch (e) {
      state = NotificationError(e.toString());
    }
  }

  /// Redirection from notification function.
  redirectNotification(NotificationsModel notification) {
    redirect(notification.toJson(), _ref);
  }
}

abstract class NotificationsStates {}

class NotificationsInitial extends NotificationsStates {}

class NotificationsLoading extends NotificationsStates {}

class NotificationsLoaded extends NotificationsStates {
  final List<NotificationsModel> notifications;
  final List<NotificationsModel> yesterdayNotifications;
  final List<NotificationsModel> previousNotifications;

  final int unreadCount;

  // int get unreadCount{
  //   int count = 0;
  //   for(final notification in notifications){
  //     if(notification.readStatus == false){
  //       count++;
  //     }
  //   }
  //   return count;
  // }

  NotificationsLoaded(this.notifications, this.yesterdayNotifications,
     this.previousNotifications, this.unreadCount);
}

class NotificationError extends NotificationsStates {
  final String msg;
  NotificationError(this.msg);
}
