import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
          textTheme: GoogleFonts.catamaranTextTheme(
            Theme.of(context).textTheme,
          ).copyWith(
            subtitle1: TextStyle(fontSize: 16),
            bodyText2: TextStyle(fontSize: 14),
          ),
          brightness: Brightness.light,
          primaryColor: Colors.white,
          scaffoldBackgroundColor: Colors.grey[50],
          primarySwatch: Colors.teal,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            titleTextStyle: GoogleFonts.catamaran(
              color: Colors.teal,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          )),
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
