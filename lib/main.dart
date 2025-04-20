import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_notes_app/core/models/note.dart';
import 'package:todo_notes_app/core/models/task.dart';
import 'package:todo_notes_app/views/screens/main/main_screen.dart';
import 'package:todo_notes_app/views/theme/theme_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(NoteAdapter());
  await Hive.openBox<Task>('tasks');
  await Hive.openBox<Note>('notes');
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeController.getLightTheme(),
      home: const MainScreen(),
    );
  }
}
