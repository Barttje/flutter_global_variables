import 'package:todolist_event_bus/inherited_widget/domain/todo_list_item.dart';

class TodoListItemCreatedEvent {
  TodoListItem todo;

  TodoListItemCreatedEvent(this.todo);
}
