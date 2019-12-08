import 'package:flutter/material.dart';
import 'package:notification_notes/widgets/DismissibleTile.dart';
import 'package:notification_notes/ItemList.dart';
import 'package:provider/provider.dart';

import '../handlers/NotificationHandler.dart';

class NotificationList extends StatelessWidget {
  NotificationList({Key key, this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    final myItems = Provider.of<ItemList>(context, listen: false);

    NotificationHandler handler = new NotificationHandler();
    handler.showNotifications(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Consumer<ItemList>(
        builder: (_, items, __) => ReorderableListView(
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          myItems.addItem(myItems.myItems.length.toString() + "dasd");
        },
        tooltip: 'Add',
        child: Icon(Icons.add),
      ),
    );
  }
}
