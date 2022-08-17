import 'package:flutter/material.dart';
import 'package:notification_notes/handlers/note_list_handler.dart';
import 'package:notification_notes/models/category.dart';
import 'package:notification_notes/models/note.dart';
import 'package:notification_notes/utils/statics.dart';
import 'package:notification_notes/utils/validators.dart';

class EditNotificationDialog extends StatelessWidget {
  final NoteListHandler noteListHandler;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  NoteCategory noteCategory = NoteCategory.unknown;

  final _formKey = GlobalKey<FormState>();

  EditNotificationDialog({required this.noteListHandler});

  @override
  Widget build(BuildContext context) {
    titleController.text = noteListHandler.editing?.item.title ?? "";
    descriptionController.text =
        noteListHandler.editing?.item.description ?? "";
    print(noteListHandler.editing?.item.category);
    this.noteCategory =
        noteListHandler.editing?.item.category ?? NoteCategory.unknown;

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
            category: noteCategory,
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
            category: noteCategory,
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
          padding: const EdgeInsets.all(GENERAL_PADDING * 2),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(GENERAL_PADDING),
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
                  padding: const EdgeInsets.all(GENERAL_PADDING),
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
                  padding: const EdgeInsets.all(GENERAL_PADDING),
                  child: DropdownButtonFormField<NoteCategory>(
                    value: noteCategory,
                    decoration: InputDecoration(
                      labelText: "Category",
                      border: OutlineInputBorder(),
                    ),
                    items: NoteCategory.values
                        .map(
                          (NoteCategory e) => DropdownMenuItem(
                            child: Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.all(GENERAL_PADDING),
                                  child: Icon(
                                    e.icon,
                                    color: Colors.grey,
                                    size: ICON_SIZE,
                                  ),
                                ),
                                Text(e.text),
                              ],
                            ),
                            value: e,
                          ),
                        )
                        .toList(),
                    onChanged: (NoteCategory? value) {
                      noteCategory = value ?? NoteCategory.unknown;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(GENERAL_PADDING),
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
