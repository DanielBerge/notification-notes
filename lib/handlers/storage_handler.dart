import 'dart:convert';

import 'package:notification_notes/models/notes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageHandler {
  setList(Notes list) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("data", json.encode(list.toJson()));
  }

  Future<Notes> getList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? stringList = prefs.getString("data");
    return stringList == null
        ? Notes(notes: List.empty(growable: true))
        : Notes.fromJson(json.decode(stringList));
  }

  clear() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
