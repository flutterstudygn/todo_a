class TodoItem {
  int id;
  String title;
  DateTime createTime;
  bool isComplete;

  TodoItem({this.id, this.title, this.createTime, this.isComplete = false});

  factory TodoItem.map(Map map) {
    var isComplete = map['isComplete'];
    return TodoItem(
      id: map['id'],
      title: map['title'],
      createTime: DateTime.parse(map['createTime']),
      isComplete: isComplete is bool
          ? isComplete
          : (isComplete is int && isComplete == 1) ? true : false,
    );
  }

  String display() {
    return '$id [$title]\n $createTime';
  }

  @override
  String toString() {
    return 'TodoItem{id: $id, title: $title, createTime: $createTime, isComplete: $isComplete}';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'createTime': createTime.toIso8601String(),
      'isComplete': isComplete,
    };
  }

  TodoItem clone() {
    return TodoItem.map(this.toMap());
  }
}
