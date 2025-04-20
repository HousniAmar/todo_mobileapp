import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_notes_app/core/models/note.dart';
import 'package:todo_notes_app/core/models/task.dart';
import 'package:todo_notes_app/core/providers/note_provider.dart';
import 'package:todo_notes_app/core/providers/task_provider.dart';
import 'package:todo_notes_app/views/widgets/custom_button.dart';
import 'package:todo_notes_app/views/widgets/custom_input.dart';

class CustomForm extends ConsumerWidget {
  bool isForTask;
  bool isAdd;
  dynamic element;

  CustomForm({
    super.key,
    this.isForTask = true,
    this.isAdd = true,
    this.element,
  });
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  void addLogic(ref) {
    if (isForTask) {
      ref
          .read(tasksProvider.notifier)
          .addTask(
            Task(
              id: DateTime.now().toString(),
              title: titleController.text.trim(),
              isCompleted: false,
              createdAt: DateTime.now(),
            ),
          );
    } else {
      ref
          .read(notesProvider.notifier)
          .addNote(
            Note(
              content: contentController.text.trim(),
              id: DateTime.now().toString(),
              title: titleController.text.trim(),
              createdAt: DateTime.now(),
            ),
          );
    }
  }

  void updateLogic(ref) {
    if (isForTask) {
      ref
          .read(tasksProvider.notifier)
          .updateTask(
            element.copyWith(
                  title: titleController.text.trim(),
                  createdAt: DateTime.now(),
                )
                as Task,
          );
    } else {
      ref
          .read(notesProvider.notifier)
          .updateNote(
            element.copyWith(
                  content: contentController.text.trim(),
                  title: titleController.text.trim(),
                  createdAt: DateTime.now(),
                )
                as Note,
          );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log('Is for task: $isForTask');
    log('Is add: $isAdd');
    log('Element: $element');
    if (!isForTask && !isAdd) {
      titleController.text = element.title;
      contentController.text = element.content;
    }
    if (isForTask && !isAdd) {
      titleController.text = element.title;
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isAdd ? 'Add New Element' : "Update Form",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 16),
        CustomInputField(hintText: 'Title', controller: titleController),

        if (!isForTask)
          Column(
            children: [
              const SizedBox(height: 16),
              CustomInputField(
                hintText: 'Content',
                controller: contentController,
                maxLines: 5,
              ),
            ],
          ),

        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(color: Colors.blue),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: CustomButton(
                text:isAdd? 'Add': 'Update',
                onPressed: () {
                  if (isAdd) {
                    addLogic(ref);
                  } else {
                    updateLogic(ref);
                  }
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
