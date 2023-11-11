import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart';

import 'flutter_secure_storage/secure_storage.dart';

class Messaging {
  final FirebaseMessaging _msg = FirebaseMessaging.instance;

  Future<void> getFirebaseMessagingToken() async {
    await _msg.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    await _msg.getToken().then((t) {
      if (t != null) {
        FSS().saveData("PushToken", t);
        log("PushToken: $t");
      }
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('Got a message whilst in the foreground!');
      log('Message data: ${message.data}');

      if (message.notification != null) {
        log('Message also contained a notification: ${message.notification}');
      }
    });
  }

  Future<void> sendPushNotifications(
      String pushToken, String name, String message) async {
    try {
      final body = {
        "to": pushToken,
        "notification": {"title": name, "body": message, "android_channel_id": "chats"},
        "data":{
          "some_data": "User Name:$name",
        }
      };
      var response =
          await post(Uri.parse("https://fcm.googleapis.com/fcm/send"),
              headers: {
                HttpHeaders.contentTypeHeader: "application/json",
                HttpHeaders.authorizationHeader:
                    "key=AAAAuHOJ0Oc:APA91bEgTGeUCaX28XLevblDrmhJynvtrF299UrCYTVdWl3dMsqwaljpvYSetQYuDosrT7orft74DB0swgSXFz0pTkb7CNUKMkWo936s7GX3ut_c-7Clll31deY4vhA2dapbVHwxdL2w"
              },
              body: jsonEncode(body));
      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');
    } catch (e) {
      log("\nsendPushNotifications: $e");
    }
  }
}
