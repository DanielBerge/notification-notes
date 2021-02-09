import 'package:flutter/cupertino.dart';

class Notes {
  List<Note> notes;

  Notes({@required this.notes});

  Notes.fromJson(Map<String, dynamic> json) {
    if (json['notes'] != null) {
      notes = List<Note>();
      (json['notes'] as List).forEach((v) {
        notes.add(Note.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.notes != null) {
      data['notes'] = this.notes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Note {
  String title;
  String description;
  bool enabled;

  Note({
    @required this.title,
    @required this.description,
    @required this.enabled,
  });

  Note.fromJson(Map<String, dynamic> json) {
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
