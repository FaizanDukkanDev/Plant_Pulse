import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
       options: const FirebaseOptions(
         appId: '1:1089578554449:android:c0fc634ac945dea8b41470',
         messagingSenderId: '1089578554449',
         projectId: 'plant-pulse-fe262',
         apiKey: 'AIzaSyCiXjX2jdO5GxK5hbWBaThi8nAqqm-uqN4',
         //storageBucket: 'plant-pulse-fe262.appspot.com',
         androidClientId:
             '1089578554449-tmndi53rc95kvpr5fok59vfuqk98l55m.apps.googleusercontent.com',
       ),
      );
  await fcmInit();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.white,
    systemNavigationBarDividerColor: Colors.grey,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) => runApp(App()));
}

Future<void> fcmInit() async {
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  // foreground message listener : create a high priority channel
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });

  // background message listener
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}

// background message handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}
