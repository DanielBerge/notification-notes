import 'package:shared_preferences/shared_preferences.dart';

class StorageHandler {
  setList(List<String> list) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList("data", list);
  }

  Future<List<String>> getList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var stringList = prefs.getStringList("data");
    return stringList == null ? List() : stringList;
  }

  clear() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
