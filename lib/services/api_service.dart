import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String _baseUrl = 'http://172.18.4.174/api/tasks.php';

  // Método para obtener tareas
  Future<List<Map<String, dynamic>>> getTasks() async {
    final response = await http.get(Uri.parse('$_baseUrl?action=getTasks'));

    if (response.statusCode == 200) {
      // Decodificar el JSON en una lista de mapas
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  // Método para agregar una tarea
  Future<void> addTask(Map<String, dynamic> task) async {
    final response = await http.post(
      Uri.parse('$_baseUrl?action=addTask'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(task),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add task: ${response.body}');
    }
  }
}


