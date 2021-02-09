import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notification_notes/handlers/storage_handler.dart';
import 'package:notification_notes/models/notes.dart';

import '../models/notes.dart';

class NoteListHandler with ChangeNotifier {
  StorageHandler _storageHandler = StorageHandler();
  Notes _notes = Notes(notes: List());
  Tuple editing;

  NoteListHandler() {
    _storageHandler.getList().then((Notes list) {
      _notes = list;
      notifyListeners();
    });
  }

  List<Note> get noteList => _notes.notes;

  void updateList(int oldIndex, int newIndex) {
    Note old = _notes.notes[oldIndex];
    noteList.removeAt(oldIndex);
    if (newIndex == _notes.notes.length + 1) {
      noteList.add(old);
    } else {
      noteList.insert(newIndex, old);
    }
    _storageHandler.setList(_notes);
    notifyListeners();
  }

  void insertItem(int index, Note item) {
    if (index == noteList.length + 1) {
      noteList.add(item);
    } else {
      noteList.insert(index, item);
    }
    _storageHandler.setList(_notes);
    notifyListeners();
  }

  void removeItem(Note item) {
    noteList.remove(item);
    _storageHandler.setList(_notes);
    notifyListeners();
  }

  void addItem(Note item) {
    _notes.notes.add(item);
    _storageHandler.setList(_notes);
    notifyListeners();
  }

  void setEditingItem(Note item) {
    editing = Tuple(index: noteList.indexOf(item), item: item);
    notifyListeners();
  }

  void clearEditingItem() {
    editing = null;
  }

  void toggleEnabled(Note item) {
    noteList[noteList.indexOf(item)].enabled = !item.enabled;
    notifyListeners();
  }
}

class Tuple {
  Note item;
  int index;

  Tuple({this.index, this.item});
}
