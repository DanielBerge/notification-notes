import 'package:flutter/material.dart';
import 'package:notification_notes/handlers/notification_handler.dart';
import 'package:notification_notes/item_list.dart';
import 'package:notification_notes/widgets/dismissible_tile.dart';
import 'package:notification_notes/widgets/edit_notification_dialog.dart';
import 'package:provider/provider.dart';

class NotificationList extends StatelessWidget {
  NotificationList({Key key, this.title}) : super(key: key);
  final String title;

  static Future showEditNotificationDialog(BuildContext context, editing) {
    final myItems = Provider.of<ItemList>(context, listen: false);

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
    final ItemList items = context.watch<ItemList>();

    NotificationHandler()..showNotifications(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ReorderableListView(
        children: <Widget>[
          for (final item in items.myItems.items)
            DismissibleTile(
              key: ValueKey(item.title),
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
        child: Icon(Icons.add),
      ),
    );
  }
}
