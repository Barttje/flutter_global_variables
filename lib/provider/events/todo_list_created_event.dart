import 'package:todolist_event_bus/provider/domain/todo_list_item.dart';

class TodoListItemCreatedEvent {
  TodoListItem todo;

  TodoListItemCreatedEvent(this.todo);
}
