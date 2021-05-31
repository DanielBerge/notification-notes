

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notification_notes/handlers/note_list_handler.dart';
import 'package:provider/provider.dart';

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

  Future showNotification(int id, String title, String description) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        playSound: false,
        autoCancel: false,
        onlyAlertOnce: true,
        ongoing: true,
        enableVibration: false,
        channelShowBadge: false,
        importance: Importance.defaultImportance,
        priority: Priority.low);
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

  void showNotifications(BuildContext context) {
    flutterLocalNotificationsPlugin.cancelAll();
    final NoteListHandler myItems = context.read<NoteListHandler>();
    for (final item in myItems.noteList.reversed) {
      if (item.enabled) {
        showNotification(
          myItems.noteList.indexOf(item),
          item.title,
          item.description,
        );
      }
    }
  }
}
