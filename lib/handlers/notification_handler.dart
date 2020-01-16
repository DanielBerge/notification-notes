import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notification_notes/item_list.dart';
import 'package:notification_notes/main.dart';
import 'package:provider/provider.dart';

class NotificationHandler {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  NotificationHandler() {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
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
        importance: Importance.Default,
        priority: Priority.Low);
    var iOSPlatformChannelSpecifics =
        IOSNotificationDetails(presentSound: false);
    var platformChannelSpecifics = NotificationDetails(
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
      List<String> titleDescription = item.split(MyApp.splitter);
      showNotification(myItems.myItems.indexOf(item), titleDescription[0],
          titleDescription[1]);
    }
  }
}
