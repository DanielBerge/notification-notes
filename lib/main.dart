import 'package:flutter/material.dart';
import 'package:notification_notes/item_list.dart';
import 'package:notification_notes/widgets/notification_list.dart';
import 'package:provider/provider.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notification Notes',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: ChangeNotifierProvider<ItemList>(
          create: (context) => ItemList(),
          child: NotificationList(title: 'Notification Notes')),
    );
  }
}
