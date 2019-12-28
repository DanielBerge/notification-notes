import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:notification_notes/item_list.dart';
import 'package:notification_notes/widgets/notification_list.dart';
import 'package:provider/provider.dart';

class DismissibleTile extends StatelessWidget {
  final item;

  DismissibleTile({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myItems = Provider.of<ItemList>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Slidable(
        key: ValueKey(item),
        actionPane: SlidableDrawerActionPane(),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.white,
              ),
            ],
          ),
          child: ListTile(
            key: ValueKey(item),
            title: Text(item),
            subtitle: Text(item),
          ),
        ),
        actions: <Widget>[
          IconSlideAction(
            caption: "Edit",
            color: Colors.yellow,
            icon: Icons.edit,
            onTap: () {
              myItems.setEditingItem(item);
              NotificationList.showEditNotificationDialog(context);
              myItems.removeItem(item);
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
    );
  }

  void removeItem(context, myItems) {
    int undoIndex = myItems.myItems.indexOf(item);
    myItems.removeItem(item);
    Scaffold.of(context).removeCurrentSnackBar();
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text("Removed ${item.toString()}"),
      action: SnackBarAction(
        label: "Undo",
        onPressed: () {
          myItems.insertItem(undoIndex, item);
        },
      ),
      duration: Duration(seconds: 3),
    ));
  }
}
