import 'package:shared_preferences/shared_preferences.dart';
import 'task.dart';

Future<void> saveTasks(List<Task> tasks) async {
  final prefs = await SharedPreferences.getInstance();
  final taskList =
      tasks
          .map(
            (task) =>
                "${task.title},${task.isCompleted},${task.dueDate?.toIso8601String() ?? ''},${task.category}",
          )
          .toList();
  await prefs.setStringList("tasks", taskList);
}

Future<List<Task>> loadTasks() async {
  final prefs = await SharedPreferences.getInstance();
  final taskList = prefs.getStringList("tasks") ?? [];
  return taskList.map((task) {
    final parts = task.split(",");
    return Task(
      title: parts[0],
      isCompleted: parts[1] == "true",
      dueDate: parts[2].isNotEmpty ? DateTime.parse(parts[2]) : null,
      category: parts[3],
    );
  }).toList();
}
