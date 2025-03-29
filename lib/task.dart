import 'dart:ui';
import 'package:flutter/material.dart';

class Task {
  String title;
  bool isCompleted;
  DateTime? dueDate;
  String category;

  Task({
    required this.title,
    this.isCompleted = false,
    this.dueDate,
    this.category = "Без категории",
  });

  static List<String> categories = [
    "Без категории",
    "Работа",
    "Личное",
    "Учёба",
    "Другое",
  ];

  Color getCategoryColor() {
    switch (category) {
      case "Работа":
        return Colors.redAccent;
      case "Личное":
        return Colors.greenAccent;
      case "Учёба":
        return Colors.blueAccent;
      case "Другое":
        return Colors.orangeAccent;
      default:
        return Colors.grey;
    }
  }
}
