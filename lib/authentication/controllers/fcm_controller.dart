
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/authentication/controllers/auth_controller.dart';
import 'package:htp_customer/common/utils/dynamic_routes.dart';
import 'package:htp_customer/features/booking/presentation/pages/confirmation/confirm_ticket.dart';
import 'package:htp_customer/features/dashboard/controllers/dashboard_controllers.dart';
import 'package:htp_customer/features/profile/controller/profile_controller.dart';
import 'package:htp_customer/features/profile/presentation/profile_page.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:math' as math;

import '../data/service/fcm_services.dart';

final fcmProvider = StateNotifierProvider((ref) {
  final fcm = ref.watch(fcmServiceProvider);
  return FCMController(fcm, ref);
});

@pragma('vm:entry-point')
Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.notification?.title} : ${message.notification?.body}");
}

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // ignore: avoid_print
  print('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    // ignore: avoid_print
    print('notification action tapped with input: ${notificationResponse.input}');
  }
}

class FCMController extends StateNotifier<FCMStates>{
  final FCMServices _fcm;
  final Ref _ref;
  FCMController(this._fcm, this._ref):super(FCMInitial()){
    init();
    _initLocalNotification();
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  init() async{
    print("FIREBASE INITIALIZATION");
    try{
     final authorized = await _fcm.registerNotification();
     if(authorized){
       RemoteMessage? initialMessage = await _fcm.getInitialMessage();
       if(initialMessage != null){
         _handleInitialMessage(initialMessage);
       }

       FirebaseMessaging.onMessage.listen((RemoteMessage message) {
         print("onMessage: ${message.notification?.title} : ${message.notification?.body} ${message.messageId}");
         print("NOTIFICATION DATA: ${message.data}");
         final notificationDataUrl = message.data['url'] as String?;
         if(notificationDataUrl != null && notificationDataUrl.contains('membership_requests')){
           print("MEMBERSHIP REQUEST NOTIFICATION");
           Future.delayed(const Duration(seconds: 2)).then((value) {
             // _ref.read(profileControllerProvider.notifier).getProfile();
             _ref.read(authProvider.notifier).checkUser();
           });
         }

         final notificationImage = message.notification?.android?.imageUrl;
         if(notificationImage == null){
           _showNotificationWithSound(math.Random().nextInt(10000), message.notification?.title, message.notification?.body, jsonEncode(message.data));
         }else{
           _showBigPictureLocalNotification(message);
         }
         
       });
       // FirebaseMessaging.onBackgroundMessage((_firebaseMessagingBackgroundHandler));

       FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
         print("onMessageOpenedApp: ${message.notification?.title} : ${message.notification?.body} ${message.messageId}");
         print("NOTIFICATION DATA OPENED: ${message.data}");

         //{internal_redirect: true, body: , title: Get ready to party like it's 1999 - your entry to Jacob Munoz is confirmed !, url: event_entry_bookings/135582c8-5272-40b7-9169-32b752cf9671}
         //Handle message click here
         redirect(message.data, _ref);
       });
     }
    }catch(e){
      print(e);
    }
  }

  _showBigPictureLocalNotification(RemoteMessage message)async{
    try{
      print("BIG PIC NOTIFICATION");
      final imageBytes = await _downloadAndSaveFile(message.notification!.android!.imageUrl!, 'fileName');
      final bigPicture = BigPictureStyleInformation(FilePathAndroidBitmap(imageBytes), largeIcon: FilePathAndroidBitmap(imageBytes));
      _showNotificationWithSound(math.Random().nextInt(10000), message.notification?.title, message.notification?.body, jsonEncode(message.data), bigPictureStyleInformation: bigPicture);
    }catch(e){
      print("BIG PICTURE ERROR: $e");
    }
  }

  testNotification()async{
    print("BIG PIC Test NOTIFICATION");
    final String largeIcon = await _downloadAndSaveFile('url', 'fileName');
    final bigPicture = BigPictureStyleInformation(FilePathAndroidBitmap(largeIcon),);
    _showNotificationWithSound(0, 'TEst', 'Testbody', 'payload', bigPictureStyleInformation: bigPicture);
  }

  Future<String> _downloadAndSaveFile(String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final response = await Dio().get(url, options: Options(responseType: ResponseType.bytes));

    final File file = File(filePath);
    await file.writeAsBytes(response.data);
    return filePath;
  }



  void _handleInitialMessage(RemoteMessage message){
    print("onInitialMessage: ${message.notification?.title} : ${message.notification?.body} ${message.messageId}");
  }


  _initLocalNotification(){
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('ic_notification');
    final DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings();

    final InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin);

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
        onDidReceiveNotificationResponse: onSelectNotification);
  }

  onSelectNotification(NotificationResponse notification) async{
    print("LOCAL NOTIFICATION CLICKED");
    print(notification.payload);
    redirect(jsonDecode(notification.payload ?? ''), _ref);
  }

  Future _showNotificationWithSound(int id, String? title, String? body, String? payload, {BigPictureStyleInformation? bigPictureStyleInformation}) async {
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name',
        importance: Importance.max,
        priority: Priority.high,
      styleInformation: bigPictureStyleInformation
    );

    const iOSPlatformChannelSpecifics = DarwinNotificationDetails();

    final platformChannelSpecifics = NotificationDetails(android:
        androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(id, title, body,
      platformChannelSpecifics,
      payload: payload,
    );
  }




}

abstract class FCMStates{}

class FCMInitial extends FCMStates{}

