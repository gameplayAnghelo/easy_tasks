class Task {
  String title;
  String description;
  DateTime date;
  List<SubTask> subTasks;

  Task({this.title, this.description, this.date, this.subTasks});
}

class SubTask {
  String title;
  bool completed;

  SubTask({this.title, this.completed = false});
}
