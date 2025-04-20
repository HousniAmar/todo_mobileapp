import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_notes_app/core/providers/nav_provider.dart';
import 'package:todo_notes_app/views/screens/tasks/elements_screen.dart';

import 'package:todo_notes_app/views/widgets/bottom_nav.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  final List _icons = [Icons.task, Icons.note_alt];

  // List of pages/screens to display
  final List<Widget> _pages = [
    ElementsScreen(isForTasks: true),
    ElementsScreen(isForTasks: false),
  ];

  @override
  Widget build(BuildContext context) {
    final _currentIndex = ref.watch(navProvider);
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _currentIndex,
        icons: _icons,
        onItemSelected: (index) {
          ref.read(navProvider.notifier).state = index;
        },
      ),
    );
  }
}
