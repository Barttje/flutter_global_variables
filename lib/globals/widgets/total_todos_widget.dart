import 'package:flutter/material.dart';
import 'package:todolist_event_bus/globals/events/todo_list_checked_event.dart';
import 'package:todolist_event_bus/globals/provider/globals.dart';

class TotalTodosWidget extends StatefulWidget {
  const TotalTodosWidget({Key? key}) : super(key: key);

  @override
  _TotalTodosWidgetState createState() => _TotalTodosWidgetState();
}

class _TotalTodosWidgetState extends State<TotalTodosWidget> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    eventBus.on<TodoListItemCheckedEvent>().listen((event) {
      setState(() {
        _counter++;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
      alignment: Alignment.center,
      child: Text(
        '$_counter',
        style: const TextStyle(color: Colors.black87),
      ),
    );
  }
}
