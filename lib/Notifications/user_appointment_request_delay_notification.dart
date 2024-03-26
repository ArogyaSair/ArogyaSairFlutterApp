// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;

sendAppointmentDelayToUser(
    {required String userKey,
      required String appointmentDate,
      required String disease,
      required String status,
      required String hospitalName,
      required String newDate}) async {
  var serverKey = 'AAAANZSWEE8:APA91bGT4zt_EFbTd_zsH9VQf0ydv7wTmKR9pGgdN0r509WHczxR2uwMj4bk9UajZvOix_l3y6a6usEnXZMWyA3q04W7n49K92zK45fbqwXsRm5NL_Ryru5MlqSexZ7exPNK820TyH1C';

  var token;
  final userRef = FirebaseDatabase.instance
      .ref()
      .child("ArogyaSair/tblUser")
      .child(userKey);

  DatabaseEvent databaseEvent = await userRef.once();
  DataSnapshot dataSnapshot = databaseEvent.snapshot;

  var userData = dataSnapshot.value as Map;
  token = userData["UserFCMToken"];

  String constructFCMPayload(String token) {
    return jsonEncode(
      <String, dynamic>{
        'notification': <String, dynamic>{
          'body': "Your appointment of date $appointmentDate, for $disease has been DELAYED for $newDate date by $hospitalName.",
          'title': "Appointment Notification",
        },
        'data': <String, dynamic>{
          'name': disease,
          'time': appointmentDate.toString(),
          'status': status,
        },
        'to': token
      },
    );
  }

  if (token.isEmpty) {
    return log('Unable to send FCM message, no token exists.');
  }

  try {
    http.Response response =
    await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverKey',
        },
        body: constructFCMPayload(token));

    log("status: ${response.statusCode} | Message Sent Successfully!");
  } catch (e) {
    log("error push notification $e");
  }
}
