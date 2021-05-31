import 'package:flutter/material.dart';
import 'package:notification_notes/handlers/note_list_handler.dart';
import 'package:notification_notes/widgets/notification_list.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return MaterialApp(
      title: 'Notification Notes',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.teal,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.teal,
      ),
      home: ChangeNotifierProvider<NoteListHandler>(
        create: (context) => NoteListHandler(),
        child: NotificationList(title: 'Notifications'),
      ),
    );
  }
}
