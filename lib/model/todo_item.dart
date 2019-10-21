class TodoItem {
  int id;
  String title;
  DateTime createTime;
  bool isComplete;

  TodoItem({this.id, this.title, this.createTime, this.isComplete = false});
  factory TodoItem.create(String title) {
    return TodoItem(
      title: title,
      createTime: DateTime.now(),
      isComplete: false,
    );
  }

  @override
  String toString() {
    return 'TodoItem{id: $id, title: $title, createTime: $createTime, isComplete: $isComplete}';
  }
}
