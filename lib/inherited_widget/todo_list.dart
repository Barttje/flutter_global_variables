import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:todolist_event_bus/inherited_widget/domain/todo_list_item.dart';
import 'package:todolist_event_bus/inherited_widget/events/todo_list_checked_event.dart';
import 'package:todolist_event_bus/inherited_widget/events/todo_list_created_event.dart';
import 'package:todolist_event_bus/inherited_widget/provider/event_bus_provider.dart';
import 'package:todolist_event_bus/inherited_widget/widgets/new_todo_list_dialog.dart';
import 'package:todolist_event_bus/inherited_widget/widgets/todo_list_item_widget.dart';
import 'package:todolist_event_bus/inherited_widget/widgets/total_todos_widget.dart';
import 'package:uuid/uuid.dart';

Uuid uuid = const Uuid();

void main() {
  runApp(const App());
}

class App extends StatelessWidget {

  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EventBusProvider(
      eventBus: EventBus(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: const TodoList(),
      ),
    );
  }
}

class TodoList extends StatelessWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Event Bus TodoList Provider Example"),
        leading: const TotalTodosWidget(),
      ),
      body: const MyTodoList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showNewTodoDialog(context),
        tooltip: 'Create new todo',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class MyTodoList extends StatefulWidget {
  const MyTodoList({Key? key}) : super(key: key);

  @override
  State<MyTodoList> createState() => _MyTodoListState();
}

class _MyTodoListState extends State<MyTodoList> {
  List<TodoListItem> todos = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      context.eventBus.on<TodoListItemCreatedEvent>().listen((event) {
        setState(() {
          todos.add(event.todo);
        });
      });
      context.eventBus.on<TodoListItemCheckedEvent>().listen((event) {
        setState(() {
          todos.removeWhere((element) => element.id == event.id);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (todos.isEmpty) {
      return const Center(child: Text("Add a new todo to get started"));
    }
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(20.0),
      children: todos.map((item) => TodoListItemWidget(item: item)).toList(),
    );
  }
}
