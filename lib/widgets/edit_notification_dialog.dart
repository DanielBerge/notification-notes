import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notification_notes/ItemList.dart';

class EditNotificationDialog extends StatelessWidget {
  final ItemList itemList;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  EditNotificationDialog({@required this.itemList});

  @override
  Widget build(BuildContext context) {
    titleController.text = itemList.editing == null ? "" : itemList.editing.string;
    return SizedBox(
      width: 200,
      height: 300,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(labelText: "Title"),
            ),
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: "Description"),
              minLines: 3,
              maxLines: 5,
            ),
            MaterialButton(
              child: Text("Save"),
              color: Colors.teal,
              onPressed: () {
                if(itemList.editing == null) {
                  itemList.addItem(titleController.text);
                  Navigator.of(context).pop();
                } else {
                  itemList.insertItem(itemList.editing.index, titleController.text);
                  itemList.clearEditingItem();
                  Navigator.of(context).pop();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
