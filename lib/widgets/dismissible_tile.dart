import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:notification_notes/handlers/note_list_handler.dart';
import 'package:notification_notes/models/notes.dart';
import 'package:notification_notes/widgets/notification_list.dart';
import 'package:provider/provider.dart';

class DismissibleTile extends StatelessWidget {
  final Note item;

  DismissibleTile({
    Key key,
    @required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NoteListHandler myItems = context.watch<NoteListHandler>();

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Slidable(
          key: ValueKey(item),
          actionPane: SlidableDrawerActionPane(),
          child: ListTile(
            key: ValueKey(item),
            title: Text(item.title),
            enabled: item.enabled,
            subtitle: Text(item.description),
            onTap: () {
              myItems.setEditingItem(item);
              NotificationList.showEditNotificationDialog(context, true);
              myItems.removeItem(item);
            },
          ),
          actions: <Widget>[
            IconSlideAction(
              caption: item.enabled ? "Disable" : "Enable",
              color: item.enabled ? Colors.redAccent : Colors.green,
              icon: item.enabled ? Icons.clear : Icons.verified_user_outlined,
              onTap: () {
                myItems.toggleEnabled(item);
              },
            )
          ],
          secondaryActions: <Widget>[
            IconSlideAction(
              caption: "Delete",
              color: Colors.red,
              icon: Icons.cancel,
              onTap: () {
                removeItem(context, myItems);
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
              removeItem(context, myItems);
            },
          ),
        ),
      ),
    );
  }

  void removeItem(context, NoteListHandler myItems) {
    int undoIndex = myItems.noteList.indexOf(item);
    myItems.removeItem(item);
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Removed ${item.title}"),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            myItems.insertItem(undoIndex, item);
          },
        ),
        duration: Duration(seconds: 3),
      ),
    );
  }
}
