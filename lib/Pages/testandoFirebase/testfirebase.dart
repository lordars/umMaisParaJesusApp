// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:ummaisjesus/shared/models/pushNotification_model.dart';

import '../../shared/models/notification_badge.dart';

class TestFlutterFirebase extends StatefulWidget {
  const TestFlutterFirebase({super.key});

  @override
  State<TestFlutterFirebase> createState() => _TestFlutterFirebaseState();
}

class _TestFlutterFirebaseState extends State<TestFlutterFirebase> {
//initialize somo values

  late final FirebaseMessaging _messaging;
  late int _totalNotificationCounter;
  //model
  PushNotification? _notificationInfo;
//register notification

  void registerNotification() async {
    await Firebase.initializeApp();
    //instancia for firebase messagin
    _messaging = FirebaseMessaging.instance;

    //three type of state in notificion
    // not datermined (null), granted (true) an decline (false)

    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("user granted the permission");

//main message
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        PushNotification notification = PushNotification(
            title: message.notification!.title,
            body: message.notification!.body,
            dataTitle: message.data['title'],
            dataBody: message.data['body']);
        setState(() {
          _totalNotificationCounter++;
          _notificationInfo = notification;
        });

        // ignore: unnecessary_null_comparison
        if (notification != null) {
          showSimpleNotification(Text(_notificationInfo!.title!),
              leading: NotificationBadge(
                  totalNotification: _totalNotificationCounter),
              subtitle: Text(_notificationInfo!.body!),
              background: Colors.cyan.shade700,
              duration: Duration(seconds: 2));
        }
      });
    } else {
      print("permition declined by user");
    }
  }

  checkForInitialMessage() async {
    await Firebase.initializeApp();
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      PushNotification notification = PushNotification(
        title: initialMessage.notification!.title,
        body: initialMessage.notification!.body,
        dataTitle: initialMessage.data['title'],
        dataBody: initialMessage.data['body'],
      );
      setState(() {
        _totalNotificationCounter++;
        _notificationInfo = notification;
      });
    }
  }

  @override
  void initState() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      PushNotification notification = PushNotification(
        title: message.notification!.title,
        body: message.notification!.body,
        dataTitle: message.data['title'],
        dataBody: message.data['body'],
      );
      setState(() {
        _totalNotificationCounter++;
        _notificationInfo = notification;
      });
    });

    registerNotification();
    checkForInitialMessage();
    _totalNotificationCounter = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PushNotification"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables, prefer_const_constructors
          children: [
            Text(
              "FlutterPushNotification",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            SizedBox(
              height: 12,
            ),
            NotificationBadge(totalNotification: _totalNotificationCounter),
            SizedBox(
              height: 30,
            ),
            //totification info not null then
            _notificationInfo != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "TITLE : ${_notificationInfo!.dataTitle ?? _notificationInfo!.title}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(
                        height: 9,
                      ),
                      Text(
                        "BODY : ${_notificationInfo!.dataBody ?? _notificationInfo!.body}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
