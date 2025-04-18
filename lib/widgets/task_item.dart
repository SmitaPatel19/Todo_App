import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import '../models/todo_item.dart';
import '../utils/constants.dart';

class TaskItem extends StatelessWidget {
  final TodoItem item;
  final Function(String) onToggle;
  final Function(String) onDelete;

  const TaskItem({
    super.key,
    required this.item,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isOverdue = item.dueDate != null &&
        item.dueDate!.isBefore(DateTime.now()) &&
        !item.isCompleted;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      color: Colors.teal.shade50,
      child: Slidable(
        key: Key(item.id),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) => onDelete(item.id),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: ListTile(
          leading: Checkbox(
            checkColor: Colors.white,
            activeColor: Colors.teal,
            value: item.isCompleted,
            onChanged: (bool? value) => onToggle(item.id),
          ),
          title: Text(
            item.title,
            style: TextStyle(
              fontSize: 20,
              decoration: item.isCompleted
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
              color: item.isCompleted ? Colors.grey : Colors.teal,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (item.category.isNotEmpty)
                Chip(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide(
                      color: Colors.teal,
                      width: 1,
                    ),
                  ),
                  label: Text(item.category,style: TextStyle(color: Colors.teal),),
                  backgroundColor: Colors.teal[100],
                  labelStyle: const TextStyle(fontSize: 12),
                ),
              if (item.dueDate != null)
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 14,
                      color: isOverdue ? Colors.red : Colors.teal,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      DateFormat('MMM dd, yyyy').format(item.dueDate!),
                      style: TextStyle(
                        fontSize: 12,
                        color: isOverdue ? Colors.red : Colors.teal,
                      ),
                    ),
                    if (isOverdue) ...[
                      const SizedBox(width: 4),
                      const Text(
                        '(Overdue)',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]
                  ],
                ),
            ],
          ),
          trailing: Container(
            width: 10,
            height: 40,
            decoration: BoxDecoration(
              color: AppConstants.priorityColors[item.priority] ?? Colors.grey,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
      ),
    );
  }
}