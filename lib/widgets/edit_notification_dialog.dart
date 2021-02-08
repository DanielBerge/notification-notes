import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notification_notes/item_list.dart';
import 'package:notification_notes/models/item.dart';

class EditNotificationDialog extends StatelessWidget {
  final ItemList itemList;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  EditNotificationDialog({@required this.itemList});

  @override
  Widget build(BuildContext context) {
    if (itemList.editing == null) {
      titleController.text = "";
      descriptionController.text = "";
    } else {
      titleController.text = itemList.editing.item.title;
      descriptionController.text = itemList.editing.item.description;
    }
    return Container(
      width: 400,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  controller: titleController,
                  decoration: InputDecoration(labelText: "Title"),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter title';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  controller: descriptionController,
                  decoration: InputDecoration(labelText: "Description"),
                  minLines: 3,
                  maxLines: 1000,
                ),
                MaterialButton(
                  child: Text("Save"),
                  color: Colors.teal,
                  onPressed: () {
                    if (!_formKey.currentState.validate()) {
                      return null;
                    }
                    if (itemList.editing == null) {
                      itemList.addItem(
                        Item(
                          title: titleController.text,
                          description: descriptionController.text,
                        ),
                      );
                      Navigator.of(context).pop();
                    } else {
                      itemList.insertItem(
                        itemList.editing.index,
                        Item(
                            title: titleController.text,
                            description: descriptionController.text),
                      );
                      itemList.clearEditingItem();
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
