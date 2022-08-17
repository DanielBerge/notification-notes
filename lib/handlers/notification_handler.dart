import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notification_notes/models/note.dart';

import '../models/category.dart';

class NotificationHandler {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  NotificationHandler() {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future showNotification(
      int id, String title, String description, NoteCategory category) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'no.berge.notificationnotes',
      'My Notes',
      playSound: false,
      autoCancel: false,
      onlyAlertOnce: true,
      ongoing: true,
      enableVibration: false,
      channelShowBadge: false,
      importance: Importance.defaultImportance,
      priority: Priority.low,
      largeIcon: DrawableResourceAndroidBitmap(
          "@mipmap/${category.text.toLowerCase()}"),
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
      presentSound: false,
      presentBadge: true,
      presentAlert: true,
    );
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      description,
      platformChannelSpecifics,
      payload: 'No_Sound',
    );
  }

  void showNotifications(List<Note> noteList) {
    flutterLocalNotificationsPlugin.cancelAll();
    for (final item in noteList.reversed) {
      if (item.enabled) {
        showNotification(
          noteList.indexOf(item),
          item.title,
          item.description,
          item.category,
        );
      }
    }
  }
}
