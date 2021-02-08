import 'dart:convert';

import 'package:notification_notes/models/item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageHandler {
  setList(Items list) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("data", json.encode(list.toJson()));
  }

  Future<Items> getList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringList = prefs.getString("data");
    return stringList == null ? Items(items: List()) : Items.fromJson(json.decode(stringList));
  }

  clear() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
