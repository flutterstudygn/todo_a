import 'package:todo/model/todo_item.dart';

/*
 * Adapter interface
 */
abstract class TodoAdapter {
  Future<TodoAdapter> init() async {
    return this;
  }

  Future<List<TodoItem>> getList();
  Future<TodoItem> getTodoItemById(int id);
  Future<TodoItem> create(TodoItem todoItem);
  Future<TodoItem> update(TodoItem todoItem);
  Future<bool> delete(int id);
}
