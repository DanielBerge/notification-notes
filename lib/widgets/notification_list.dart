import 'package:flutter/material.dart';
import 'package:notification_notes/handlers/note_list_handler.dart';
import 'package:notification_notes/handlers/notification_handler.dart';
import 'package:notification_notes/utils/statics.dart';
import 'package:notification_notes/widgets/edit_notification_dialog.dart';
import 'package:notification_notes/widgets/note_tile.dart';
import 'package:provider/provider.dart';

import '../handlers/storage_handler.dart';

class NotificationList extends StatelessWidget {
  final String title;

  NotificationList({Key? key, required this.title}) : super(key: key);

  static showEditNotificationDialog(BuildContext context) {
    final NoteListHandler noteListHandler = context.read<NoteListHandler>();

    return showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(BORDER_RADIUS),
          ),
        ),
        child: EditNotificationDialog(noteListHandler: noteListHandler),
      ),
    ).then((value) {
      if (value == null) {
        noteListHandler.clearEditingItem();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final NoteListHandler noteListHandler = context.watch<NoteListHandler>();

    NotificationHandler()..showNotifications(noteListHandler.noteList);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        elevation: ELEVATION,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(BORDER_RADIUS),
          ),
        ),
      ),
      body: ReorderableListView(
        proxyDecorator: (widget, _, __) {
          return widget;
        },
        children: <Widget>[
          for (final item in noteListHandler.noteList)
            DismissibleTile(
              key: ValueKey(item.hashCode),
              item: item,
              noteListHandler: noteListHandler,
            ),
        ],
        onReorder: (oldIndex, newIndex) {
          noteListHandler.updateList(oldIndex, newIndex);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showEditNotificationDialog(context);
        },
        tooltip: 'Add',
        backgroundColor: Colors.teal,
        child: Icon(Icons.add),
      ),
    );
  }
}
