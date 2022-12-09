import 'dart:typed_data';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationViewer {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static final Int64List _vibrationPattern = Int64List.fromList([500, 1000]);
  static final AndroidNotificationChannel _channel = AndroidNotificationChannel(
      "elitechannel", // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.high,
      playSound: true,
      enableVibration: true,
      vibrationPattern: _vibrationPattern,
      showBadge: true);
  static Future<void> initialize() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: initializationSettingsIOS,
    );

    _flutterLocalNotificationsPlugin.initialize(
      initializationSettings, //todo check this for data and check permissions
    );
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);
    debugPrint("channelInitialized");
  }

  static Future<void> display(RemoteMessage message) async {
    try {
      NotificationDetails notificationDetails = NotificationDetails(
        iOS: const DarwinNotificationDetails(),
        android: AndroidNotificationDetails(
          _channel.id,
          _channel.name,
          channelDescription: _channel.description,
          importance: Importance.high,
          priority: Priority.high,
          visibility: NotificationVisibility.public,
          channelShowBadge: true,
          playSound: true,
          vibrationPattern: _vibrationPattern,
          icon: '@mipmap/ic_launcher',
          enableVibration: true,
          enableLights: true,
          timeoutAfter: 10000,
        ),
      );
      RemoteNotification? notification = message.notification;

      int id = DateTime.now().second;
      if (message.notification != null) {
        await _flutterLocalNotificationsPlugin.show(
          id,
          notification!.title,
          notification.body,

          notificationDetails,
          // todo payload: message.data["route"],
        );
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
