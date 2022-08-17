import 'category.dart';

class Note {
  late String title;
  late String description;
  late bool enabled;
  late NoteCategory category;

  Note({
    required this.title,
    required this.description,
    required this.enabled,
    required this.category,
  });

  Note.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    enabled = json['enabled'];
    category = NoteCategory.values.firstWhere(
        (element) => element.toString().toLowerCase() == 'NoteCategory.${json['category']}'.toLowerCase(),
        orElse: () => NoteCategory.unknown);
    print(json['category']);
    print(category);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['enabled'] = this.enabled;
    data['category'] = this.category.toString();
    print(data);
    return data;
  }
}
