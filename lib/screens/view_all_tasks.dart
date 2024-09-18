import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/api_service.dart'; // Asegúrate de reemplazar 'your_app' con el nombre real de tu paquete

class ViewAllTasks extends StatefulWidget {
  @override
  _ViewAllTasksState createState() => _ViewAllTasksState();
}

class _ViewAllTasksState extends State<ViewAllTasks> {
  final ApiService _apiService = ApiService();
  List<Map<String, dynamic>> tasks = [];
  final List<String> _timeOptions = ['Hoy', 'Esta semana', '2 semanas', 'Mes entero'];
  String _selectedTimeOption = 'Hoy';

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _loadTasks() async {
    final fetchedTasks = await _apiService.getTasks();
    setState(() {
      tasks = fetchedTasks;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ver Todas las Tareas'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                _selectedTimeOption = value;
                // Aquí podrías agregar lógica para filtrar tareas según el tiempo seleccionado
              });
            },
            itemBuilder: (context) {
              return _timeOptions.map((option) {
                return PopupMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: tasks.isNotEmpty
          ? ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return ListTile(
                  title: Text(task['name'] ?? 'Sin nombre'),
                  subtitle: Text(task['description'] ?? 'Sin descripción'),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Detalles de la Tarea'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Nombre: ${task['name']}'),
                              Text('Descripción: ${task['description']}'),
                              Text('Prioridad: ${task['priority']}'),
                              Text('Fecha de Inicio: ${task['startDate']}'),
                              Text('Fecha de Fin: ${task['endDate']}'),
                              // Aquí puedes agregar más detalles si es necesario
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Cerrar'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
