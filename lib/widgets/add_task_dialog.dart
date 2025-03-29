import 'package:flutter/material.dart';
import '../task.dart';

class AddTaskDialog extends StatefulWidget {
  final Function(Task) onAdd;

  const AddTaskDialog({required this.onAdd});

  @override
  _AddTaskDialogState createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  String newTaskTitle = "";
  DateTime? selectedDate;
  String selectedCategory = Task.categories[0];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Новая задача"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            onChanged: (value) => newTaskTitle = value,
            decoration: InputDecoration(
              hintText: "Введите задачу",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 10),
          TextButton(
            onPressed: () async {
              selectedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2100),
              );
              setState(() {});
            },
            child: Text(
              selectedDate == null
                  ? "Выбрать дату"
                  : "Дата: ${selectedDate!.toLocal().toString().split(' ')[0]}",
              style: TextStyle(color: Color(0xFF26A69A)),
            ),
          ),
          SizedBox(height: 10),
          DropdownButton<String>(
            value: selectedCategory,
            items:
                Task.categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
            onChanged: (value) => setState(() => selectedCategory = value!),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Отмена"),
        ),
        TextButton(
          onPressed: () {
            if (newTaskTitle.isNotEmpty) {
              widget.onAdd(
                Task(
                  title: newTaskTitle,
                  dueDate: selectedDate,
                  category: selectedCategory,
                ),
              );
              Navigator.pop(context);
            }
          },
          child: Text("Добавить", style: TextStyle(color: Color(0xFF26A69A))),
        ),
      ],
    );
  }
}
