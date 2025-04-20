import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_notes_app/core/providers/note_provider.dart';
import 'package:todo_notes_app/core/providers/task_provider.dart';
import 'package:todo_notes_app/views/widgets/custom_form.dart';

class ElementCard extends ConsumerWidget {
  final dynamic element;
  final bool isForTasks;

  const ElementCard({super.key, required this.element, this.isForTasks = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log('ElementCard: $element isForTasks: $isForTasks');
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading:
                  isForTasks
                      ? Checkbox(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        value: element.isCompleted,
                        onChanged: (value) {
                          ref
                              .read(tasksProvider.notifier)
                              .toggleComplete(element.id);
                        },
                      )
                      : null,
              title: Text(
                element.title,
                style:
                    isForTasks
                        ? TextStyle(
                          decoration:
                              element.isCompleted
                                  ? TextDecoration.lineThrough
                                  : null,
                          color: element.isCompleted ? Colors.grey : null,
                        )
                        : Theme.of(context).textTheme.titleMedium,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit_outlined),
                    onPressed: () {
                      _showUpdateModal(context, element, isForTasks);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () {
                      _showDeleteConfirmation(context, ref, isForTasks);
                    },
                  ),
                ],
              ),
            ),
            if (!isForTasks)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  element.content,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmation(
    BuildContext context,
    WidgetRef ref,
    isForTasks,
  ) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Text('Delete Confirmation'),
            content: Text(
              'Are you sure you want to delete "${element.title}"?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  if (isForTasks) {
                    ref.read(tasksProvider.notifier).deleteTask(element.id);
                  } else {
                    ref.read(notesProvider.notifier).deleteNote(element.id);
                  }
                  Navigator.pop(context);
                },
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
    );
  }

  void _showUpdateModal(
    BuildContext context,
    dynamic element,
    bool isForTasks,
  ) {
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
          child: CustomForm(
            isAdd: false,
            element: element,
            isForTask: isForTasks,
          ),
        );
      },
    );
  }
}
