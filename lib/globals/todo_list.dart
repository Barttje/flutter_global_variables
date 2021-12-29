import 'package:flutter/material.dart';
import 'package:todolist_event_bus/globals/domain/todo_list_item.dart';
import 'package:todolist_event_bus/globals/events/todo_list_checked_event.dart';
import 'package:todolist_event_bus/globals/events/todo_list_created_event.dart';
import 'package:todolist_event_bus/globals/provider/globals.dart';
import 'package:todolist_event_bus/globals/widgets/new_todo_list_dialog.dart';
import 'package:todolist_event_bus/globals/widgets/todo_list_item_widget.dart';
import 'package:todolist_event_bus/globals/widgets/total_todos_widget.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const TodoList(),
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
    eventBus.on<TodoListItemCreatedEvent>().listen((event) {
      setState(() {
        todos.add(event.todo);
      });
    });
    eventBus.on<TodoListItemCheckedEvent>().listen((event) {
      setState(() {
        todos.removeWhere((element) => element.id == event.id);
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
