import 'package:firbase_authentiction/testing_notification/green_page.dart';
import 'package:firbase_authentiction/testing_notification/red_page.dart';
import 'package:firbase_authentiction/testing_notification/services/local_notification_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

//recive message when app is background solution for on message
Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
  print('on back ground handler called..........');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PushNotificationVU(),
      routes: {
        "red": (_) => const RedPageVU(),
        "green": (_) => const GreenPageVU()
      },
    );
  }
}

class PushNotificationVU extends StatefulWidget {
  const PushNotificationVU({Key? key}) : super(key: key);

  @override
  _PushNotificationVUState createState() => _PushNotificationVUState();
}

class _PushNotificationVUState extends State<PushNotificationVU> {
  @override
  void initState() {
    super.initState();
    LocalNotificationServices.initialize(context);

    //give the message on which user tap
    // and its openened the apps from terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        final routeFromMessage = message.data["route"];
        print('getInitialMessage called..........');
        Navigator.of(context).pushNamed(routeFromMessage);
      }
    });

    //Foreground work
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        print(message.notification!.body);
        print(message.notification!.title);
        print('on foreground called..........');
      }
      LocalNotificationServices.display(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      final routeFromMessage = message.data["route"];
      print('on messageopenedapp  called..........');
      Navigator.of(context).pushNamed(routeFromMessage);

      print(routeFromMessage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [Text('ForeGround screen')],
      )),
    );
  }
}
