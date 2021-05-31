import 'package:flutter/material.dart';
import 'package:notification_notes/handlers/note_list_handler.dart';
import 'package:notification_notes/handlers/notification_handler.dart';
import 'package:notification_notes/widgets/dismissible_tile.dart';
import 'package:notification_notes/widgets/edit_notification_dialog.dart';
import 'package:provider/provider.dart';

class NotificationList extends StatelessWidget {
  NotificationList({Key key, this.title}) : super(key: key);
  final String title;

  static Future showEditNotificationDialog(BuildContext context, editing) {
    final NoteListHandler myItems = context.read<NoteListHandler>();

    return showDialog(
      context: context,
      barrierDismissible: !editing,
      builder: (BuildContext context) => Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: EditNotificationDialog(itemList: myItems),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final NoteListHandler items = context.watch<NoteListHandler>();

    NotificationHandler()..showNotifications(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          )
        ),
        textTheme: TextTheme(
          headline6: TextStyle(
            color: Colors.teal,
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ReorderableListView(
        children: <Widget>[
          for (final item in items.noteList)
            DismissibleTile(
              key: ValueKey(item.hashCode),
              item: item,
            ),
        ],
        onReorder: (oldIndex, newIndex) {
          items.updateList(oldIndex, newIndex);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showEditNotificationDialog(context, false);
        },
        tooltip: 'Add',
        backgroundColor: Colors.teal,
        child: Icon(Icons.add),
      ),
    );
  }
}
