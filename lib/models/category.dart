

import 'package:flutter/material.dart';

enum NoteCategory {
  work,
  home,
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
    }
  }

  String get text {
    switch (this) {
      case NoteCategory.work:
        return "Work";
      case NoteCategory.home:
        return "Home";
      case NoteCategory.unknown:
        return "Other";
    }
  }
}