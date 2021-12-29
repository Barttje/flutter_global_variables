import 'package:flutter/material.dart';
import 'package:todolist_event_bus/inherited_widget/domain/todo_list_item.dart';
import 'package:todolist_event_bus/inherited_widget/events/todo_list_checked_event.dart';
import 'package:todolist_event_bus/inherited_widget/provider/event_bus_provider.dart';

class TodoListItemWidget extends StatelessWidget {
  final TodoListItem item;

  const TodoListItemWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.text),
      leading: Checkbox(
        value: false,
        onChanged: (bool? value) {
          eventBus.fire(TodoListItemCheckedEvent(item.id));
        },
      ),
    );
  }
}
