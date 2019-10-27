import 'package:flutter/cupertino.dart';
import 'package:todo/model/todo_item.dart';
import 'package:todo/repository/todo_repository.dart';

class TodoState with ChangeNotifier {
  final TodoRepository _repo;
  TodoState(this._repo);

  List<TodoItem> _todoList;
  List<TodoItem> get todoList => _todoList;

  // fetch all item list
  Future getList() async {
    _todoList = await _repo.getList();
    notifyListeners();
  }

  // fetch item by item id
  void getTodoItemById(int id) => _repo.getTodoItemById(id);

  // create new item
  Future create(TodoItem todoItem) async {
    TodoItem result = await _repo.create(todoItem);
    if (result != null) {
      _todoList.add(result);
      notifyListeners();
    }
  }

  // update item
  Future update(TodoItem todoItem) async {
    TodoItem result = await _repo.update(todoItem);
    if (result != null) {
      for (int i = 0; i < _todoList.length; i++) {
        if (_todoList[i].id == todoItem.id) {
          _todoList[i] = todoItem;
          break;
        }
      }
      notifyListeners();
    }
  }

  // delete item by id.
  // if not exists, return false.
  Future delete(int id) async {
    bool result = await _repo.delete(id);
    if (result == true) {
      _todoList.removeWhere((item) => item.id == id);
      notifyListeners();
    }
  }
}
