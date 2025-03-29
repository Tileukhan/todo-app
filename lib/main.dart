import 'package:flutter/material.dart';
import 'storage.dart';
import 'task.dart';
import 'widgets/app_bar.dart';
import 'widgets/task_tile.dart';
import 'widgets/add_task_dialog.dart';
import 'widgets/edit_task_dialog.dart';
import 'widgets/floating_button.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TodoListScreen(),
      theme: ThemeData(scaffoldBackgroundColor: Color(0xFFF2EFE7)),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    loadTasks().then((loadedTasks) {
      setState(() {
        tasks = loadedTasks;
      });
    });
  }

  void _addTask(Task task) {
    setState(() {
      tasks.add(task);
      saveTasks(tasks);
    });
  }

  void _editTask(int index, Task editedTask) {
    setState(() {
      tasks[index] = editedTask;
      saveTasks(tasks);
    });
  }

  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
      saveTasks(tasks);
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Задача удалена")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "ToDo List"),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return TaskTile(
            task: tasks[index],
            onCheckboxChanged: (value) {
              setState(() {
                tasks[index].isCompleted = value!;
                saveTasks(tasks);
              });
            },
            onTap: () {
              showDialog(
                context: context,
                builder:
                    (context) => EditTaskDialog(
                      task: tasks[index],
                      onEdit: (editedTask) => _editTask(index, editedTask),
                    ),
              );
            },
            onDismissed: () => _deleteTask(index),
          );
        },
      ),
      floatingActionButton: CustomFloatingButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddTaskDialog(onAdd: _addTask),
          );
        },
      ),
    );
  }
}
