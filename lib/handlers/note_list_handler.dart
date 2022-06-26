import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notification_notes/handlers/storage_handler.dart';
import 'package:notification_notes/models/note.dart';
import 'package:notification_notes/models/note_wrapper.dart';
import 'package:notification_notes/models/notes.dart';

import '../models/notes.dart';

class NoteListHandler with ChangeNotifier {
  StorageHandler _storageHandler = StorageHandler();
  Notes _notes = Notes(notes: List.empty(growable: true));
  NoteWrapper? editing;

  NoteListHandler() {
    _storageHandler.getList().then((Notes list) {
      _notes = list;
      notifyListeners();
    });
  }

  List<Note> get noteList => _notes.notes;

  void updateList(int oldIndex, int newIndex) {
    Note old = noteList[oldIndex];
    noteList.removeAt(oldIndex);
    if (newIndex > noteList.length) {
      noteList.add(old);
    } else {
      if (newIndex < oldIndex) {
        noteList.insert(newIndex, old);
      } else {
        noteList.insert(newIndex - 1, old);
      }
    }
    noteList.sort(compareList);
    _storageHandler.setList(_notes);
    notifyListeners();
  }

  void insertItem(int index, Note item) {
    if (index > noteList.length) {
      noteList.add(item);
    } else {
      noteList.insert(index, item);
    }
    noteList.sort(compareList);
    _storageHandler.setList(_notes);
    notifyListeners();
  }

  void replaceItem(int atIndex, Note oldItem, Note newItem) {
    removeItem(oldItem);
    insertItem(atIndex, newItem);
  }

  void removeItem(Note item) {
    noteList.remove(item);
    _storageHandler.setList(_notes);
    notifyListeners();
  }

  void addItem(Note item) {
    noteList.insert(0, item);
    noteList.sort(compareList);
    _storageHandler.setList(_notes);
    notifyListeners();
  }

  void setEditingItem(Note item) {
    editing = NoteWrapper(index: noteList.indexOf(item), item: item);
    notifyListeners();
  }

  void clearEditingItem() {
    editing = null;
  }

  void toggleEnabled(Note item) {
    noteList[noteList.indexOf(item)].enabled = !item.enabled;
    noteList.sort(compareList);
    _storageHandler.setList(_notes);
    notifyListeners();
  }

  int compareList(Note a, Note b) {
    if (a.enabled && !b.enabled) {
      return -1;
    } else if (!a.enabled && b.enabled) {
      return 1;
    } else {
      return 0;
    }
  }
}
