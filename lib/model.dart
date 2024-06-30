class ToDo {
  String id;
  String task;
  bool isCompleted;

  ToDo({
    required this.id,
    required this.task,
    this.isCompleted = false,
  });
}
