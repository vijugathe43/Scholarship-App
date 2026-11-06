import 'package:flutter/material.dart';
import 'question_model.dart';

class Chapter {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final List<Question> questions;

  Chapter({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.questions,
  });
}

class Subject {
  final String id;
  final String title;
  final String subtitle;
  final Color primaryColor;
  final Color secondaryColor;
  final IconData icon;
  final List<Chapter> chapters;

  Subject({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.primaryColor,
    required this.secondaryColor,
    required this.icon,
    required this.chapters,
  });

  int get totalQuestions => chapters.fold(
        0,
        (sum, chapter) => sum + chapter.questions.length,
      );
}
