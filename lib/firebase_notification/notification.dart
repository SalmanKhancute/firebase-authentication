import 'package:firbase_authentiction/firebase_notification/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationVU extends StatefulWidget {
  NotificationVU({Key? key}) : super(key: key);

  @override
  _NotificationVUState createState() => _NotificationVUState();
}

class _NotificationVUState extends State<NotificationVU> {
  int count = 0;
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(channel.id, channel.name,
                    channelDescription:
                        "This channel is used for important notifications.",
                    color: Colors.blue,
                    playSound: true,
                    icon: '@mipmap/ic_launcher')));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title.toString()),
                content: SingleChildScrollView(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text(notification.body.toString())],
                )),
              );
            });
      }
    });
  }

  void showNotification() {
    setState(() {
      count++;
    });
    flutterLocalNotificationsPlugin.show(
        0,
        'testing $count',
        "How are you doing",
        NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                channelDescription:
                    "This channel is used for important notifications.",
                importance: Importance.high,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("FireBase Local and Push notification"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showNotification,
        child: Icon(Icons.add),
      ),
    );
  }
}
