class ToDo {
  String? id;
  String? todoText;
  String? description;
  DateTime? dueDate;
  String? priority;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.description,
    this.dueDate,
    this.priority,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(
        id: '01',
        todoText: 'Morning Exercise',
        description: '30-minute run',
        dueDate: DateTime.now().add(Duration(days: 1)),
        priority: 'High',
        isDone: true,
      ),
      // Add more initial ToDo items here
    ];
  }
}
