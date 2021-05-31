import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notification_notes/handlers/note_list_handler.dart';
import 'package:notification_notes/models/note.dart';
import 'package:notification_notes/utils/validators.dart';

class EditNotificationDialog extends StatelessWidget {
  final NoteListHandler itemList;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  EditNotificationDialog({required this.itemList});

  @override
  Widget build(BuildContext context) {
    titleController.text = itemList.editing?.item.title ?? "";
    descriptionController.text = itemList.editing?.item.description ?? "";

    onSave() {
      if (!_formKey.currentState!.validate()) {
        return null;
      }
      if (itemList.editing == null) {
        itemList.addItem(
          Note(
            title: titleController.text,
            description: descriptionController.text,
            enabled: true,
          ),
        );
      } else {
        itemList.insertItem(
          itemList.editing!.index,
          Note(
            title: titleController.text,
            description: descriptionController.text,
            enabled: itemList.editing!.item.enabled,
          ),
        );
        itemList.clearEditingItem();
      }
      Navigator.of(context).pop();
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    controller: titleController,
                    decoration: InputDecoration(
                      labelText: "Title",
                      border: OutlineInputBorder(),
                    ),
                    validator: titleValidator,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    controller: descriptionController,
                    decoration: InputDecoration(
                      labelText: "Description",
                      border: OutlineInputBorder(),
                    ),
                    minLines: 3,
                    maxLines: 1000,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: Text("Save"),
                    onPressed: onSave,
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all<Size>(Size.fromHeight(40)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
