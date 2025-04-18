import 'package:flutter/material.dart';
import '../models/todo_item.dart';
import '../utils/functions.dart';
import '../widgets/dialog_add_task.dart';
import '../widgets/empety_state_text.dart';
import '../widgets/task_item.dart';
import '../widgets/task_statistic_card.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  List<TodoItem> _todoItems = [];
  List<TodoItem> _filteredItems = [];
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _loadTodoItems();
    _searchController.addListener(_searchTasks);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadTodoItems() async {
    final items = await AppFunctions.loadTodoItems();
    setState(() {
      _todoItems = items;
      _filteredItems = List.from(_todoItems);
    });
  }

  Future<void> _saveTodoItems() async {
    await AppFunctions.saveTodoItems(_todoItems);
  }

  void _searchTasks() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredItems = _todoItems.where((item) {
        return item.title.toLowerCase().contains(query) ||
            item.category.toLowerCase().contains(query);
      }).toList();
    });
  }

  void _addTodoItem(String task, String category, String priority, DateTime? dueDate) {
    if (task.isNotEmpty) {
      setState(() {
        _todoItems.add(TodoItem(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: task,
          isCompleted: false,
          category: category,
          priority: priority,
          dueDate: dueDate,
        ));
        _filteredItems = List.from(_todoItems);
      });
      _saveTodoItems();
    }
  }

  void _removeTodoItem(String id) async {
    final confirmed = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.teal.shade100,
        title: const Text('Confirm Delete'),
        content: const Text('Are you sure you want to delete this task?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      setState(() {
        _todoItems.removeWhere((item) => item.id == id);
        _filteredItems.removeWhere((item) => item.id == id);
      });
      _saveTodoItems();
    }
  }

  void _toggleTodoItem(String id) {
    setState(() {
      for (var item in _todoItems) {
        if (item.id == id) {
          item.isCompleted = !item.isCompleted;
          break;
        }
      }
      _filteredItems = List.from(_todoItems);
    });
    _saveTodoItems();
  }

  Future<void> _displayAddDialog() async {
    await showDialog(
      context: context,
      builder: (context) => AddTaskDialog(
        onAdd: (task, category, priority, dueDate) =>
            _addTodoItem(task, category, priority, dueDate),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final completedCount = _todoItems.where((item) => item.isCompleted).length;
    final pendingCount = _todoItems.length - completedCount;
    final highPriorityCount = _todoItems.where((item) => item.priority == 'High').length;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: _isSearching
            ? TextField(
          controller: _searchController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search tasks...',
            hintStyle: TextStyle(color: Colors.white),
            border: InputBorder.none,
          ),
        )
            : const Text('To-Do List',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search,color: Colors.white,),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchController.clear();
                  _filteredItems = List.from(_todoItems);
                }
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          if (_todoItems.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Task Statistics',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: Colors.teal),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      children: [
                        StatisticsCard(
                          title: 'Total',
                          count: _todoItems.length,
                          color: Colors.blue,
                        ),
                        const SizedBox(width: 8),
                        StatisticsCard(
                          title: 'Completed',
                          count: completedCount,
                          color: Colors.green,
                        ),
                        const SizedBox(width: 8),
                        StatisticsCard(
                          title: 'Pending',
                          count: pendingCount,
                          color: Colors.orange,
                        ),
                        const SizedBox(width: 8),
                        StatisticsCard(
                          title: 'High Priority',
                          count: highPriorityCount,
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
          Expanded(
            child: _filteredItems.isEmpty
                ? EmptyState(isSearching: _isSearching)
                : ListView.builder(
              itemCount: _filteredItems.length,
              itemBuilder: (context, index) {
                final todoItem = _filteredItems[index];
                return TaskItem(
                  item: todoItem,
                  onToggle: _toggleTodoItem,
                  onDelete: _removeTodoItem,
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: _displayAddDialog,
        tooltip: 'Add Task',
        child: const Icon(Icons.add,color: Colors.white,),
      ),
    );
  }
}