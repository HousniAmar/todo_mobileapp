import 'package:hive/hive.dart';
import '../models/task.dart';

class TaskRepository {
  static const _boxName = 'tasks';

  Future<Box<Task>> get _box async => await Hive.openBox<Task>(_boxName);

  Future<List<Task>> getAllTasks() async {
    final box = await _box;
    return box.values.toList();
  }

  Future<void> addTask(Task task) async {
    final box = await _box;
    await box.put(task.id, task);
  }

  Future<void> updateTask(Task task) async {
    final box = await _box;
    await box.put(task.id, task);
  }

  Future<void> deleteTask(String id) async {
    final box = await _box;
    await box.delete(id);
  }

  Future<void> toggleComplete(String id) async {
    final box = await _box;
    final task = box.get(id);
    if (task != null) {
      task.isCompleted = !task.isCompleted;
      await box.put(id, task);
    }
  }
}