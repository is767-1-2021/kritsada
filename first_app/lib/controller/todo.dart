import 'package:first_app/Services/services.dart';
import 'package:first_app/model/todo.dart';

import 'dart:async';

class TodoController {
  final HttpServices service;
  List<Todo> todos = List.empty();

  StreamController<bool> onSyncController = StreamController();
  Stream<bool> get OnSync => onSyncController.stream;

  TodoController(this.service);

  Future<List<Todo>> fetchTodos() async {
    onSyncController.add(true);
    todos = await service.getTodos();
    onSyncController.add(false);
    return todos;
  }
}
