import 'package:flutter/material.dart';
import 'package:notification_notes/item_list.dart';
import 'package:notification_notes/widgets/notification_list.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const String splitter = "¦§}#";

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return MaterialApp(
      title: 'Notification Notes',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.teal,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.teal,
      ),
      home: ChangeNotifierProvider<ItemList>(
        create: (context) => ItemList(),
        child: NotificationList(title: 'Notification notes'),
      ),
    );
  }
}
