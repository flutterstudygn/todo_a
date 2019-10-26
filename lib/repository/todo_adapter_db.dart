import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo/model/todo_item.dart';
import 'package:todo/repository/todo_adapter.dart';

class TodoDbAdapter implements TodoAdapter {
  SqfliteAdapter _dbAdapter;
  TodoDbAdapter();

  @override
  Future<TodoDbAdapter> init() async {
    String dirPath = (await getApplicationSupportDirectory()).path;
    _dbAdapter = SqfliteAdapter(join(dirPath, 'todo.db'));
    return _dbAdapter.connect().then((_) {
      _createTable();
      return this;
    }).catchError((e) {
      return null;
    });
  }

  static const String _tableName = 'todo';
  final IntField _id = new IntField('id');
  final StrField _title = new StrField('title');
  final DateTimeField _createTime = new DateTimeField('createTime');
  final BoolField _isComplete = new BoolField('isComplete');

  Future<Null> _createTable() async {
    final st = new Create(_tableName, ifNotExists: true)
        .addInt(_id.name, primary: true, autoIncrement: true)
        .addStr(_title.name)
        .addDateTime(_createTime.name)
        .addBool(_isComplete.name);

    await _dbAdapter.createTable(st);
  }

  @override
  Future<List<TodoItem>> getList() async {
    Find finder = new Find(_tableName);

    List<Map> maps = (await _dbAdapter.find(finder)).toList();
    List<TodoItem> items = new List<TodoItem>();

    for (Map map in maps) {
      items.add(TodoItem.map(map));
    }

    return items;
  }

  @override
  Future<TodoItem> getTodoItemById(int id) async {
    Find updater = Find(_tableName);

    updater.where(this._id.eq(id));

    Map map = await _dbAdapter.findOne(updater);

    TodoItem todoItem = new TodoItem(
      id: map[_id.name],
      title: map[_title.name],
      createTime: map[_createTime.name],
      isComplete: map[_isComplete.name],
    );
    return todoItem;
  }

  @override
  Future<TodoItem> create(TodoItem todoItem) async {
    Insert insert = Insert(_tableName);
    insert.set(_title, todoItem.title);
    insert.set(_createTime, todoItem.createTime ?? DateTime.now());
    insert.set(_isComplete, false);

    int result = await _dbAdapter.insert(insert);
    return todoItem..id = result;
  }

  @override
  Future<TodoItem> update(TodoItem todoItem) async {
    Update update = Update(_tableName);
    update.where(_id.eq(todoItem.id));
    update.set(_title, todoItem.title);
    update.set(_isComplete, todoItem.isComplete);

    await _dbAdapter.update(update);
    return todoItem;
  }

  @override
  Future<bool> delete(int id) async {
    Remove deleter = new Remove(_tableName);
    deleter.where(this._id.eq(id));

    int result = await _dbAdapter.remove(deleter);
    return result > 0;
  }
}
