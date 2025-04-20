import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:todo_notes_app/core/repositories/task_repository.dart';
import '../models/task.dart';

final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  return TaskRepository();
});

final tasksProvider = StateNotifierProvider<TasksNotifier, List<Task>>((ref) {
  final repository = ref.read(taskRepositoryProvider);
  return TasksNotifier(repository)..loadTasks();
});

class TasksNotifier extends StateNotifier<List<Task>> {
  final TaskRepository _repository;
  
  TasksNotifier(this._repository) : super([]);
  
  Future<void> loadTasks() async {
    state = await _repository.getAllTasks();
  }
  
  Future<void> addTask(Task task) async {
    await _repository.addTask(task);
    state = await _repository.getAllTasks();
  }
  
  Future<void> updateTask(Task task) async {
    await _repository.updateTask(task);
    state = await _repository.getAllTasks();
  }
  
  Future<void> deleteTask(String id) async {
    await _repository.deleteTask(id);
    state = await _repository.getAllTasks();
  }
  
  Future<void> toggleComplete(String id) async {
    await _repository.toggleComplete(id);
    state = await _repository.getAllTasks();
  }
}