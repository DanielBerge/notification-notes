import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../ItemList.dart';

class DismissibleTile extends StatelessWidget {
  final item;

  DismissibleTile({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myItems = Provider.of<ItemList>(context, listen: false);
    return Dismissible(
      key: key,
      child: ListTile(
        key: ValueKey(item),
        title: Text(item),
      ),
      onDismissed: (dir) {
        if (dir == DismissDirection.endToStart) {
          myItems.removeItem(item);
          Scaffold.of(context).removeCurrentSnackBar();
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("Removed ${item.toString()}"),
            duration: Duration(seconds: 2),
          ));
        } else if (dir == DismissDirection.startToEnd) {}
      },
      secondaryBackground: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerRight,
          child: Icon(Icons.remove),
        ),
      ),
      background: Container(
        color: Colors.amberAccent,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Icon(Icons.edit),
        ),
      ),
    );
  }
}
