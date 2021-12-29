import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';

class EventBusProvider extends InheritedWidget {
  const EventBusProvider({Key? key, required this.eventBus, required Widget child}) : super(key: key, child: child);

  final EventBus eventBus;

  static EventBus of(BuildContext context) {
    final EventBusProvider? result = context.dependOnInheritedWidgetOfExactType<EventBusProvider>();
    assert(result != null, 'No EventBus found in context');
    return result!.eventBus;
  }

  @override
  bool updateShouldNotify(EventBusProvider oldWidget) => eventBus != oldWidget.eventBus;
}

extension EventBusProviderExtension on BuildContext {
  EventBus get eventBus => EventBusProvider.of(this);
}
