import 'package:flutter/material.dart';

class ViewAllTasks extends StatefulWidget {
  @override
  _ViewAllTasksState createState() => _ViewAllTasksState();
}

class _ViewAllTasksState extends State<ViewAllTasks> {
  // Lista de opciones para el ComboBox
  final List<String> _timeOptions = [
    'Hoy',
    'Esta semana',
    '2 semanas',
    'Mes entero'
  ];
  String _selectedTimeOption = 'Hoy'; // Opción predeterminada

  // Aquí simularemos una lista de tareas que provendrían de la base de datos
  List<Map<String, dynamic>> tasks = [
    {
      'name': 'Tarea 1',
      'startTime': '10:00 AM',
      'endTime': '11:00 AM',
      'description': 'Descripción de la tarea 1'
    },
    {
      'name': 'Tarea 2',
      'startTime': '12:00 PM',
      'endTime': '1:00 PM',
      'description': 'Descripción de la tarea 2'
    },
    // Más tareas de ejemplo
  ];

  // Esta función generará una lista de Widgets tipo tarjeta para cada tarea
  List<Widget> _buildTaskCards() {
    return tasks.map((task) {
      return Card(
        elevation: 2,
        margin: EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          leading: Icon(Icons.task, color: Colors.blue),
          title:
              Text(task['name'], style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Inicio: ${task['startTime']} - Fin: ${task['endTime']}'),
              Text(task['description']),
            ],
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ver Todas las Tareas'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                // Dropdown para seleccionar el rango de tiempo
                DropdownButton<String>(
                  value: _selectedTimeOption,
                  items: _timeOptions.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedTimeOption = newValue!;
                      // Aquí más adelante puedes filtrar las tareas dependiendo de la opción seleccionada
                    });
                  },
                ),
                Spacer(),
                // Mostrar la fecha actual
                Text(
                  'Fecha: ${DateTime.now().toLocal().toString().split(' ')[0]}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Lista de tareas que provendrían de la base de datos
            Expanded(
              child: ListView(
                children: _buildTaskCards(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
