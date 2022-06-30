import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationServices {
  static final FlutterLocalNotificationsPlugin notificationplugin =
      FlutterLocalNotificationsPlugin();

  static void initialize(BuildContext context) {
    InitializationSettings initializationSettings =
        const InitializationSettings(
            android: AndroidInitializationSettings('@mipmap/ic_launcher'));
    notificationplugin.initialize(
      initializationSettings,
      onSelectNotification: (String? route) {
        if (route != null) {
          Navigator.of(context).pushNamed(route);
        }
      },
    );
  }

  static void display(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      NotificationDetails notificationDetails = const NotificationDetails(
          android: AndroidNotificationDetails(
              "easyapproch", "eassyapproch channel",
              channelDescription: "this is our channel",
              importance: Importance.max,
              priority: Priority.high,
              playSound: true));
      await notificationplugin.show(id, message.notification!.title,
          message.notification!.body, notificationDetails,
          payload: message.data['route']);
    } on Exception catch (e) {
      debugPrint("$e");
    }
  }
}
