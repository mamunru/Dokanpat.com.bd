import 'package:dokanpat/configs/key_value.dart';
import 'package:dokanpat/controllers/token_controller.dart';
import 'package:dokanpat/model/payment_model.dart';
import 'package:dokanpat/services/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

import '../main.dart';
import 'package:get_storage/get_storage.dart';

class LocalNotificationService {
//  LocalNotificationService();

  //flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();
  static String navigationActionId = 'id_3';

  static Future _notificationDetailswithimage(String image) async {
    String bigPicurePath = await Utils.downloadFile(image, 'bigPicture.jpg');

    // String largeIconPath = await Utils.assetsimage(
    //     'assets/images/icon_app.png', 'largepicture.png');
    // ;
    final BigPictureStyleInformation styleInformation =
        BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicurePath),
      // largeIcon: FilePathAndroidBitmap(largeIconPath)
    );

    final BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(FilePathAndroidBitmap(bigPicurePath),
            //largeIcon: FilePathAndroidBitmap(largeIconPath),
            contentTitle: 'overridden <b>big</b> content title',
            htmlFormatContentTitle: true,
            summaryText: 'summary <i>text</i>',
            htmlFormatSummaryText: true);

    return NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        channelDescription: 'channel description',
        importance: Importance.max,
        styleInformation: styleInformation,
      ),
    );
  }

  static Future _notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        channelDescription: 'channel description',
        importance: Importance.max,
      ),
    );
  }

  //final BehaviorSubject<String?> onNotificationClick = BehaviorSubject();

  static Future init() async {
    await Firebase.initializeApp();
    await FirebaseMessaging.instance.setAutoInitEnabled(true);
    // Set the background messaging handler early on, as a named top-level function
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    FirebaseMessaging.instance.getInitialMessage();

    FirebaseMessaging.onMessage.listen((message) {
      showFlutterNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('----------------${message.messageId}----------');
      TokenController tokenController = Get.find();
      tokenController.onNotificationFunction();

      //Get.toNamed('/homepage');
    });

    final android = AndroidInitializationSettings('@drawable/ic_stat_android');
    final settings = InitializationSettings(android: android);
    final details = await _notifications.getNotificationAppLaunchDetails();

    if (details != null && details.didNotificationLaunchApp) {
      onNotifications.add(details.notificationResponse!.payload);
    }

    await _notifications.initialize(settings,
        //     onDidReceiveNotificationResponse: (payload) async {
        //   onNotifications.add(payload as String?);
        // }
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) {
      switch (notificationResponse.notificationResponseType) {
        case NotificationResponseType.selectedNotification:
          onNotifications.add(notificationResponse.payload);
          break;
        case NotificationResponseType.selectedNotificationAction:
          if (notificationResponse.actionId == navigationActionId) {
            onNotifications.add(notificationResponse.payload);
          }
          break;
      }
    });
  }

  static Future showNotification(
          {int? id, String? title, String? body, String? payload}) async =>
      _notifications.show(
        id!,
        title,
        body,
        await _notificationDetails(),
        payload: payload,
      );

  static void showFlutterNotification(RemoteMessage message) async {
    final _box = GetStorage();
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    print(message.data);
    TokenController tokencontrol = Get.find();
    tokencontrol.onNotificationFunction();

    if (notification != null && android != null) {
      if (message.data['image'].toString().length > 5) {
        _notifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          await _notificationDetailswithimage(message.data['image'].toString()),
          payload: '/homepage',
        );
      } else {
        _notifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          await _notificationDetails(),
          payload: '/homepage',
        );
      }
    }
  }
}
