import 'package:flutter/cupertino.dart';
import 'package:notification_notes/handlers/storage_handler.dart';

class ItemList with ChangeNotifier {
  StorageHandler _storageHandler = new StorageHandler();
  List<String> myItems = List();
  Tuple editing = null;

  ItemList() {
    _storageHandler.getList().then((list) {
      myItems = list;
      notifyListeners();
    });
  }

  void updateList(int oldIndex, int newIndex) {
    var old = myItems[oldIndex];
    myItems.removeAt(oldIndex);
    if (newIndex == myItems.length + 1) {
      myItems.add(old);
    } else {
      myItems.insert(newIndex, old);
    }
    _storageHandler.setList(myItems);
    notifyListeners();
  }

  void insertItem(index, item) {
    if (index == myItems.length + 1) {
      myItems.add(item);
    } else {
      myItems.insert(index, item);
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

  void setEditingItem(item) {
    editing = Tuple(index: myItems.indexOf(item), string: item);
    notifyListeners();
  }

  void clearEditingItem() {
    editing = null;
  }
}

class Tuple {
  var string;
  var index;

  Tuple({this.index, this.string});
}
