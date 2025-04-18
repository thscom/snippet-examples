import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {
  final String id;
  final String title;
  final bool isCompleted;
  final Function(String)? onChanged;

  const TodoItem({super.key, required this.id, required this.title, required this.isCompleted, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: TextStyle(color: isCompleted ? Colors.grey : Colors.black)),
      trailing: Checkbox(
        value: isCompleted,
        onChanged: (value) {
          // Handle checkbox change here  
          debugPrint('Checkbox changed: $value');
          if (onChanged != null) {
            onChanged!(id); // Call the onChanged callback with the todo id 
          }
        }
      ),
    );
  }
}
