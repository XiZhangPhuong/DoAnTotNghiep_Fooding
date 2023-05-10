import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fooding_project/utils/app_constants.dart';

class FcmNotification {
  static Future<void> requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("Quyen 1 thanh cong");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("Quyen 2 thanh cong");
    } else {
      print("Quyen 2 that bai");
    }
  }

  static void sendNotification({
    required String token,
    required String body,
    required String title,
  }) async {
    try {
      await Dio(BaseOptions(headers: {
        'Content-Type': 'application/json',
        'Authorization': 'key=$SERVERKEY',
      })).post(
        'https://fcm.googleapis.com/fcm/send',
        data: jsonEncode(
          <String, dynamic>{
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'status': 'done',
              'body': body,
              'title': title,
            },
            'notification': <String, dynamic>{
              'title': title,
              'body': body,
              'android_channel_id': 'fooding'
            },
            'to': token,
          },
        ),
      );
    } catch (e) {
      print(e.toString());
    }
  }
}
