import 'package:flutter/material.dart';
import '../task.dart';

class EditTaskDialog extends StatefulWidget {
  final Task task;
  final Function(Task) onEdit;

  const EditTaskDialog({required this.task, required this.onEdit});

  @override
  _EditTaskDialogState createState() => _EditTaskDialogState();
}

class _EditTaskDialogState extends State<EditTaskDialog> {
  late String editedTitle;
  late DateTime? editedDate;
  late String editedCategory;

  @override
  void initState() {
    super.initState();
    editedTitle = widget.task.title;
    editedDate = widget.task.dueDate;
    editedCategory = widget.task.category;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Редактировать задачу"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            onChanged: (value) => editedTitle = value,
            decoration: InputDecoration(
              hintText: "Введите задачу",
              border: OutlineInputBorder(),
            ),
            controller: TextEditingController(text: widget.task.title),
          ),
          SizedBox(height: 10),
          TextButton(
            onPressed: () async {
              editedDate = await showDatePicker(
                context: context,
                initialDate: editedDate ?? DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2100),
              );
              setState(() {});
            },
            child: Text(
              editedDate == null
                  ? "Выбрать дату"
                  : "Дата: ${editedDate!.toLocal().toString().split(' ')[0]}",
              style: TextStyle(color: Color(0xFF26A69A)),
            ),
          ),
          SizedBox(height: 10),
          DropdownButton<String>(
            value: editedCategory,
            items:
                Task.categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
            onChanged: (value) => setState(() => editedCategory = value!),
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
            if (editedTitle.isNotEmpty) {
              widget.onEdit(
                Task(
                  title: editedTitle,
                  isCompleted: widget.task.isCompleted,
                  dueDate: editedDate,
                  category: editedCategory,
                ),
              );
              Navigator.pop(context);
            }
          },
          child: Text("Сохранить", style: TextStyle(color: Color(0xFF26A69A))),
        ),
      ],
    );
  }
}
