class TodoItem {
  final String id;
  final String title;
  bool isCompleted;
  String category;
  DateTime? dueDate;
  String priority;

  TodoItem({
    required this.id,
    required this.title,
    this.isCompleted = false,
    this.category = 'Personal',
    this.dueDate,
    this.priority = 'Medium',
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'isCompleted': isCompleted,
    'category': category,
    'dueDate': dueDate?.toIso8601String(),
    'priority': priority,
  };

  factory TodoItem.fromJson(Map<String, dynamic> json) => TodoItem(
    id: json['id'],
    title: json['title'],
    isCompleted: json['isCompleted'],
    category: json['category'] ?? 'Personal',
    dueDate: json['dueDate'] != null ? DateTime.parse(json['dueDate']) : null,
    priority: json['priority'] ?? 'Medium',
  );
}