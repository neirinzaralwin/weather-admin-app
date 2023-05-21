import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../utils/constants.dart';

class AppRepository {
  String fcmNotificationURL = "https://fcm.googleapis.com/fcm/send";

  Future<void> sendSpecificUser({required String token, required String title, required String body}) async {
    var json = {
      "to": token,
      "notification": {"body": body, "title": title}
    };

    var header = {"Authorization": "key=$SERVER_KEY", "Content-Type": "application/json"};
    Response response = await post(Uri.parse(fcmNotificationURL), headers: header, body: jsonEncode(json));
    if (response.statusCode == 200) {
      debugPrint("sent successfully");
    } else {
      debugPrint("sent failed");
    }
  }

  Future<void> sendNotificationToAllUsers({required String title, required String body}) async {
    final CollectionReference tokensCollection = FirebaseFirestore.instance.collection('fcm_tokens');
    QuerySnapshot snapshot = await tokensCollection.get();
    try {
      for (var doc in snapshot.docs) {
        String token = doc.get('token');
        await sendSpecificUser(token: token, title: title, body: body);
      }
      debugPrint("sent all users successfully");
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
