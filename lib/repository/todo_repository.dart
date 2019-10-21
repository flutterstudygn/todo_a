import 'package:todo/model/todo_item.dart';
import 'package:todo/repository/todo_adapter.dart';

class TodoRepository {
  final TodoAdapter _adapter;
  TodoRepository._(this._adapter);

  static TodoRepository _instance;
  static TodoRepository getInstance(TodoAdapter adapter) {
    if (_instance == null) {
      _instance = TodoRepository._(adapter);
    }
    return _instance;
  }

  // fetch all item list
  Future<List<TodoItem>> getList() => _adapter.getList();

  // fetch item by item id
  Future<TodoItem> getTodoItemById(int id) => _adapter.getTodoItemById(id);

  // create new item
  Future<TodoItem> create(TodoItem todoItem) => _adapter.create(todoItem);

  // update item
  Future<TodoItem> update(TodoItem todoItem) => _adapter.update(todoItem);

  // delete item by id.
  // if not exists, return false.
  Future<bool> delete(int id) => _adapter.delete(id);
}
