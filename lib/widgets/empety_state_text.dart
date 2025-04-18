import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  final bool isSearching;

  const EmptyState({
    super.key,
    required this.isSearching,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.assignment_outlined,
            size: 100,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 20),
          Text(
            isSearching ? 'No matching tasks found' : 'No tasks yet!',
            style: const TextStyle(fontSize: 18, color: Colors.grey),
          ),
          const SizedBox(height: 10),
          if (!isSearching) ...[
            const Text(
              'Tap the + button to add your first task',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            const Text(
              'Tip: Swipe left on any task to delete it',
              style: TextStyle(
                color: Colors.teal,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }
}