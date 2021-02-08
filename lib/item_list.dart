import 'package:flutter/cupertino.dart';
import 'package:notification_notes/handlers/storage_handler.dart';

import 'models/item.dart';

class ItemList with ChangeNotifier {
  StorageHandler _storageHandler = StorageHandler();
  Items myItems = Items(items: List());
  Tuple editing;

  ItemList() {
    _storageHandler.getList().then((list) {
      myItems = list;
      notifyListeners();
    });
  }

  void updateList(int oldIndex, int newIndex) {
    var old = myItems.items[oldIndex];
    myItems.items.removeAt(oldIndex);
    if (newIndex == myItems.items.length + 1) {
      myItems.items.add(old);
    } else {
      myItems.items.insert(newIndex, old);
    }
    _storageHandler.setList(myItems);
    notifyListeners();
  }

  void insertItem(int index, Item item) {
    if (index == myItems.items.length + 1) {
      myItems.items.add(item);
    } else {
      myItems.items.insert(index, item);
    }
    _storageHandler.setList(myItems);
    notifyListeners();
  }

  void removeItem(Item item) {
    myItems.items.remove(item);
    _storageHandler.setList(myItems);
    notifyListeners();
  }

  void addItem(Item item) {
    myItems.items.add(item);
    _storageHandler.setList(myItems);
    notifyListeners();
  }

  void setEditingItem(Item item) {
    editing = Tuple(index: myItems.items.indexOf(item), item: item);
    notifyListeners();
  }

  void clearEditingItem() {
    editing = null;
  }
}

class Tuple {
  Item item;
  int index;

  Tuple({this.index, this.item});
}
