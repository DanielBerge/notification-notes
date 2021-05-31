import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notification_notes/handlers/note_list_handler.dart';
import 'package:notification_notes/models/note.dart';
import 'package:notification_notes/utils/validators.dart';

class EditNotificationDialog extends StatelessWidget {
  final NoteListHandler noteListHandler;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  EditNotificationDialog({required this.noteListHandler});

  @override
  Widget build(BuildContext context) {
    titleController.text = noteListHandler.editing?.item.title ?? "";
    descriptionController.text = noteListHandler.editing?.item.description ?? "";

    onSave() {
      if (!_formKey.currentState!.validate()) {
        return null;
      }
      if (noteListHandler.editing == null) {
        noteListHandler.addItem(
          Note(
            title: titleController.text,
            description: descriptionController.text,
            enabled: true,
          ),
        );
      } else {
        noteListHandler.replaceItem(
          noteListHandler.editing!.index,
          noteListHandler.editing!.item,
          Note(
            title: titleController.text,
            description: descriptionController.text,
            enabled: noteListHandler.editing!.item.enabled,
          ),
        );
        noteListHandler.clearEditingItem();
      }
      Navigator.of(context).pop(true);
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
                    autofocus: true,
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
