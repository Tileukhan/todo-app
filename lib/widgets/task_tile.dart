import 'package:flutter/material.dart';
import '../task.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final Function(bool?) onCheckboxChanged;
  final VoidCallback onTap;
  final VoidCallback onDismissed;

  const TaskTile({
    required this.task,
    required this.onCheckboxChanged,
    required this.onTap,
    required this.onDismissed,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(task.title + task.hashCode.toString()),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 20),
        child: Icon(Icons.delete, color: Colors.white),
      ),
      secondaryBackground: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        child: Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) => onDismissed(),
      child: Card(
        elevation: 2,
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: ListTile(
          leading: Checkbox(
            value: task.isCompleted,
            onChanged: onCheckboxChanged,
            activeColor: Color(0xFF006A71),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  decoration:
                      task.isCompleted ? TextDecoration.lineThrough : null,
                ),
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    margin: EdgeInsets.only(right: 4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: task.getCategoryColor(),
                    ),
                  ),
                  Text(task.category, style: TextStyle(fontSize: 12)),
                ],
              ),
            ],
          ),
          trailing:
              task.dueDate != null
                  ? Text(
                    task.dueDate!.toLocal().toString().split(' ')[0],
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  )
                  : null,
          onTap: onTap,
        ),
      ),
    );
  }
}
