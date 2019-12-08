import 'package:flutter/cupertino.dart';
import 'package:notification_notes/handlers/StorageHandler.dart';

class ItemList with ChangeNotifier {
  StorageHandler _storageHandler = new StorageHandler();
  List<String> myItems = List();

  ItemList() {
    _storageHandler.getList().then((list) {
      myItems = list;
    });
    notifyListeners();
  }

  void updateList(int oldIndex, int newIndex) {
    var old = myItems[oldIndex];
    myItems.removeAt(oldIndex);
    if(newIndex == myItems.length+1) {
      myItems.add(old);
    } else {
      myItems.insert(newIndex, old);
    }
    _storageHandler.setList(myItems);
    notifyListeners();
  }

  void removeItem(item) {
    myItems.remove(item);
    _storageHandler.setList(myItems);
    notifyListeners();
  }

  void addItem(item) {
    myItems.add(item);
    _storageHandler.setList(myItems);
    notifyListeners();
  }
}
