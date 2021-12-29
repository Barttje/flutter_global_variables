import 'package:flutter/material.dart';
import 'package:todolist_event_bus/globals/domain/todo_list_item.dart';
import 'package:todolist_event_bus/globals/events/todo_list_created_event.dart';
import 'package:todolist_event_bus/globals/provider/globals.dart';

showNewTodoDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      TextEditingController controller = TextEditingController();
      Widget cancelButton = TextButton(child: const Text("Cancel"), onPressed: () => Navigator.pop(context));
      Widget continueButton = TextButton(
        child: const Text("Submit"),
        onPressed: () {
          eventBus.fire(TodoListItemCreatedEvent(TodoListItem(uuid.v1(), controller.text)));
          Navigator.pop(context);
        },
      );
      return AlertDialog(
        title: const Text('Create new Todo'),
        content: TextFormField(
          controller: controller,
          decoration: const InputDecoration(
            label: Text("Item"),
          ),
        ),
        actions: [
          cancelButton,
          continueButton,
        ],
      );
    },
  );
}
