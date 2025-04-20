import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_notes_app/core/providers/note_provider.dart';
import 'package:todo_notes_app/core/providers/search_provider.dart';
import 'package:todo_notes_app/core/providers/task_provider.dart';
import 'package:todo_notes_app/views/widgets/custom_form.dart';
import 'package:todo_notes_app/views/widgets/custom_card.dart';

class ElementsScreen extends ConsumerWidget {
  final bool isForTasks;
  ElementsScreen({super.key, this.isForTasks = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchQuery = ref.watch(searchQueryProvider);
    List<dynamic> allElements =
        isForTasks ? ref.watch(tasksProvider) : ref.watch(notesProvider);

    final filteredElements =
        allElements.where((element) {
          return isForTasks
              ? element.title.toLowerCase().contains(searchQuery.toLowerCase())
              : (element.title.toLowerCase().contains(
                    searchQuery.toLowerCase(),
                  ) ||
                  element.content.toLowerCase().contains(
                    searchQuery.toLowerCase(),
                  ));
        }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isForTasks ? 'Tasks' : "Notes",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: TextField(
              style: Theme.of(context).textTheme.bodyLarge,
              decoration: InputDecoration(
                hintText: isForTasks ? 'Search tasks...' : 'Search notes...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged:
                  (value) =>
                      ref.read(searchQueryProvider.notifier).state = value,
            ),
          ),
          Expanded(
            child:
                filteredElements.isEmpty
                    ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.task_alt,
                            size: 64,
                            color: Colors.grey,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            isForTasks
                                ? 'No matching tasks found.'
                                : 'No matching notes found.',
                            style: Theme.of(
                              context,
                            ).textTheme.bodyLarge?.copyWith(color: Colors.grey),
                          ),
                        ],
                      ),
                    )
                    : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListView.builder(
                        itemCount: filteredElements.length,
                        itemBuilder: (context, index) {
                          final element = filteredElements[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: ElementCard(
                              element: element,
                              isForTasks: isForTasks,
                            ),
                          );
                        },
                      ),
                    ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          _showAddModal(context, isForTasks);
        },
      ),
    );
  }

  void _showAddModal(BuildContext context, bool isForTasks) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: CustomForm(isForTask: isForTasks),
        );
      },
    );
  }
}
