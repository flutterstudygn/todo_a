import 'package:todo/model/todo_item.dart';
import 'package:todo/repository/todo_adapter.dart';

/*
 * Adapter using dummy data
 */
class TodoDummyAdapter extends TodoAdapter {
  static List<TodoItem> _items = [
    TodoItem(id: 0, title: 'Todo item 1'),
    TodoItem(id: 1, title: 'Todo item 2'),
    TodoItem(id: 2, title: 'Todo item 3'),
    TodoItem(id: 3, title: 'Todo item 4'),
    TodoItem(id: 4, title: 'Todo item 5'),
    TodoItem(id: 5, title: 'Todo item 6'),
  ];

  @override
  Future<List<TodoItem>> getList() async {
    return _items ?? [];
  }

  @override
  Future<TodoItem> getTodoItemById(int id) async {
    for (var item in _items) {
      if (item.id == id) return item;
    }
    return null;
  }

  @override
  Future<TodoItem> create(TodoItem todoItem) async {
    todoItem.id = DateTime.now().millisecondsSinceEpoch;
    _items.add(todoItem);
    return todoItem;
  }

  @override
  Future<TodoItem> update(TodoItem todoItem) async {
    bool found = false;
    for (var item in _items) {
      if (item.id == todoItem.id) {
        item = todoItem;
        found = true;
        break;
      }
    }
    if (!found) {
      throw Exception('Not found');
    }
    return todoItem;
  }

  @override
  Future<bool> delete(int id) async {
    int prevLength = _items.length;
    _items.removeWhere((v) => id == v.id);
    return prevLength != _items.length;
  }
}
