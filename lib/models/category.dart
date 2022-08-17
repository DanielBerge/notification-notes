import 'package:flutter/material.dart';

enum NoteCategory {
  work,
  home,
  sport,
  shopping,
  personal,
  unknown,
}

extension NoteCategoryExtension on NoteCategory {
  IconData get icon {
    switch (this) {
      case NoteCategory.work:
        return Icons.work;
      case NoteCategory.home:
        return Icons.home;
      case NoteCategory.unknown:
        return Icons.question_mark;
      case NoteCategory.sport:
        return Icons.sports_gymnastics;
      case NoteCategory.shopping:
        return Icons.shopping_cart;
      case NoteCategory.personal:
        return Icons.person;
    }
  }

  String get text {
    switch (this) {
      case NoteCategory.unknown:
        return "Other";
      case NoteCategory.work:
        return "Work";
      case NoteCategory.home:
        return "Home";
      case NoteCategory.sport:
        return "Sport";
      case NoteCategory.shopping:
        return "Shopping";
      case NoteCategory.personal:
        return "Personal";
    }
  }
}
