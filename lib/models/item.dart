import 'package:flutter/cupertino.dart';

class Items {
  List<Item> items;

  Items({this.items});

  Items.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = List<Item>();
      json['items'].forEach((v) {
        items.add(Item.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Item {
  String title;
  String description;
  bool enabled;

  Item({
    @required this.title,
    @required this.description,
    @required this.enabled,
  });

  Item.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    enabled = json['enabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['enabled'] = this.enabled;
    return data;
  }
}
