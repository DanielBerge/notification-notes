import 'note.dart';

class Notes {
  late List<Note> notes;

  Notes({required this.notes});

  Notes.fromJson(Map<String, dynamic> json) {
    notes = List.empty(growable: true);
    if (json['notes'] != null) {
      (json['notes'] as List).forEach((v) {
        notes.add(Note.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['notes'] = this.notes.map((v) => v.toJson()).toList();
    return data;
  }
}
