import 'package:flutter/material.dart';

class AppConstants {
  static const List<String> categories = ['Work', 'Personal', 'Shopping'];
  static const List<String> priorities = ['High', 'Medium', 'Low'];

  static const Map<String, Color> priorityColors = {
    'High': Colors.red,
    'Medium': Colors.orange,
    'Low': Colors.green,
  };
}