import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/todo_item.dart';

class AppFunctions {
  static String formatDate(DateTime? date) {
    if (date == null) return 'No date';
    return DateFormat('MMM dd, yyyy').format(date);
  }

  static Future<List<TodoItem>> loadTodoItems() async {
    final prefs = await SharedPreferences.getInstance();
    final String? todoItemsString = prefs.getString('todo_items');

    if (todoItemsString != null) {
      final List<dynamic> jsonList = json.decode(todoItemsString);
      return jsonList.map((item) => TodoItem.fromJson(item)).toList();
    }
    return [];
  }

  static Future<void> saveTodoItems(List<TodoItem> items) async {
    final prefs = await SharedPreferences.getInstance();
    final String todoItemsString = json.encode(
      items.map((item) => item.toJson()).toList(),
    );
    await prefs.setString('todo_items', todoItemsString);
  }
}