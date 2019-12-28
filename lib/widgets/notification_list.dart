import 'package:flutter/material.dart';
import 'package:notification_notes/handlers/notification_handler.dart';
import 'package:notification_notes/item_list.dart';
import 'package:notification_notes/widgets/dismissible_tile.dart';
import 'package:notification_notes/widgets/edit_notification_dialog.dart';
import 'package:provider/provider.dart';

class NotificationList extends StatelessWidget {
  NotificationList({Key key, this.title}) : super(key: key);
  final String title;

  static Future showEditNotificationDialog(BuildContext context) {
    final myItems = Provider.of<ItemList>(context, listen: false);

    return showDialog(
      context: context,
      builder: (BuildContext context) =>
          Dialog(child: EditNotificationDialog(itemList: myItems)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final myItems = Provider.of<ItemList>(context, listen: false);

    NotificationHandler handler = new NotificationHandler();
    handler.showNotifications(context);

    return Consumer<ItemList>(
      builder: (_, items, __) => Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: ReorderableListView(
          children: <Widget>[
            for (final item in items.myItems)
              DismissibleTile(
                key: ValueKey(item),
                item: item,
              ),
          ],
          onReorder: (oldIndex, newIndex) {
            myItems.updateList(oldIndex, newIndex);
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showEditNotificationDialog(context);
          },
          tooltip: 'Add',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
