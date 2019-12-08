import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notification_notes/ItemList.dart';

class EditNotificationDialog extends StatefulWidget {
  final ItemList itemList;

  EditNotificationDialog({@required this.itemList});

  @override
  State<StatefulWidget> createState() => EditNotificationState();
}

class EditNotificationState extends State<EditNotificationDialog> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    titleController.text = widget.itemList.editing == null ? "" : widget.itemList.editing.string;
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
                if(widget.itemList.editing == null) {
                  widget.itemList.addItem(titleController.text);
                  Navigator.of(context).pop();
                } else {
                  widget.itemList.insertItem(widget.itemList.editing.index, titleController.text);
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
