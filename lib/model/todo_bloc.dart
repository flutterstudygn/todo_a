import 'dart:async';

import 'package:bloc_provider/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todo/repository/todo_repository.dart';

import 'todo_item.dart';

class TodoBloc extends Bloc {
  final TodoRepository _repo;
  TodoBloc(this._repo) {
    getList();
  }

  BehaviorSubject<List<TodoItem>> _behaviorSubject =
      BehaviorSubject<List<TodoItem>>();
  Stream get itemListStream => _behaviorSubject.stream;

  @override
  void dispose() {
    _behaviorSubject.close();
  }

  void getList() {
    _repo
        .getList()
        .then((v) => _behaviorSubject.add(v))
        .catchError((e) => _behaviorSubject.addError(e));
  }

  // create new item
  Future create(TodoItem todoItem) async {
    TodoItem result = await _repo.create(todoItem);
    if (result != null) {
      _behaviorSubject.add(_behaviorSubject.value..add(result));
    }
  }

  // update item
  Future update(TodoItem todoItem) async {
    TodoItem result = await _repo.update(todoItem);
    if (result != null) {
      var todoList = _behaviorSubject.value;
      for (int i = 0; i < (todoList?.length ?? 0); i++) {
        if (todoList[i].id == todoItem.id) {
          todoList[i] = todoItem;
          _behaviorSubject.add(todoList);
          break;
        }
      }
    }
  }

  Future delete(int id) async {
    bool result = await _repo.delete(id);
    if (result == true) {
      _behaviorSubject
          .add(_behaviorSubject.value..removeWhere((item) => item.id == id));
    }
  }
}
