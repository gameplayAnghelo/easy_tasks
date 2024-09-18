class Task {
  String title;
  String description;
  DateTime date;
  List<SubTask> subTasks;

  Task({
    required this.title,        // Parámetro requerido
    required this.description,  // Parámetro requerido
    required this.date,         // Parámetro requerido
    this.subTasks = const [],   // Valor por defecto (lista vacía)
  });
}

class SubTask {
  String title;
  bool completed;

  SubTask({
    required this.title,  // Parámetro requerido
    this.completed = false, // Valor por defecto
  });
}
