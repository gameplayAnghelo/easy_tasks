List<Map<String, String>> tasks = [];

void addTask(String name, String fecha, String prioridad, String proyecto) {
  tasks.add({'name': name, 'fecha': fecha, 'prioridad': prioridad, 'proyecto': proyecto});
}

void deleteTask(int index) {
  tasks.removeAt(index);
}
