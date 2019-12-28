import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notification_notes/item_list.dart';
import 'package:provider/provider.dart';

class NotificationHandler {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  NotificationHandler() {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future showNotification(int id, String title, String description) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        playSound: false,
        autoCancel: false,
        onlyAlertOnce: true,
        ongoing: true,
        enableVibration: false,
        channelShowBadge: false,
        importance: Importance.Default,
        priority: Priority.Low);
    var iOSPlatformChannelSpecifics =
        new IOSNotificationDetails(presentSound: false);
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      description,
      platformChannelSpecifics,
      payload: 'No_Sound',
    );
  }

  void showNotifications(context) {
    flutterLocalNotificationsPlugin.cancelAll();
    final myItems = Provider.of<ItemList>(context, listen: true);
    for (final item in myItems.myItems.reversed) {
      showNotification(
          myItems.myItems.indexOf(item), item.toString(), item.toUpperCase());
    }
  }
}
