import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:notification_notes/handlers/note_list_handler.dart';
import 'package:notification_notes/models/note.dart';
import 'package:notification_notes/widgets/notification_list.dart';

class DismissibleTile extends StatelessWidget {
  final Note item;
  final NoteListHandler noteListHandler;

  DismissibleTile({
    Key? key,
    required this.item,
    required this.noteListHandler,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Slidable(
        key: ValueKey(item),
        actionPane: SlidableDrawerActionPane(),
        child: ListTile(
          key: ValueKey(item),
          title: Text(item.title),
          enabled: item.enabled,
          subtitle: Text(item.description),
          onTap: () {
            noteListHandler.setEditingItem(item);
            NotificationList.showEditNotificationDialog(context, true);
          },
        ),
        actions: <Widget>[
          IconSlideAction(
            caption: item.enabled ? "Disable" : "Enable",
            color: item.enabled ? Colors.redAccent : Colors.green,
            icon: item.enabled ? Icons.clear : Icons.verified_user_outlined,
            onTap: () {
              noteListHandler.toggleEnabled(item);
            },
          )
        ],
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: "Delete",
            color: Colors.red,
            icon: Icons.cancel,
            onTap: () {
              removeItem(context, noteListHandler);
            },
          ),
        ],
        dismissal: SlidableDismissal(
          dismissThresholds: <SlideActionType, double>{
            SlideActionType.primary: 1.0,
            SlideActionType.secondary: 0.3
          },
          child: SlidableDrawerDismissal(),
          onDismissed: (actionType) {
            removeItem(context, noteListHandler);
          },
        ),
      ),
    );
  }

  void removeItem(context, NoteListHandler noteListHandler) {
    int undoIndex = noteListHandler.noteList.indexOf(item);
    noteListHandler.removeItem(item);
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Removed ${item.title}"),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            noteListHandler.insertItem(undoIndex, item);
          },
        ),
        duration: Duration(seconds: 3),
      ),
    );
  }
}
