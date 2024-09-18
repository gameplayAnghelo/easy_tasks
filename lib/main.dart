import 'package:flutter/material.dart';

// Modelo de SubTask
class SubTask {
  String title;
  bool completed;

  SubTask({
    required this.title,  // Parámetro requerido
    this.completed = false, // Valor por defecto
  });
}

// Modelo de Task
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


void main() {
  runApp(EasyTasksApp());
}

class EasyTasksApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EasyTasks',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
    );
  }
}

// Pantalla principal (Main Screen)
class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  
  //Creacion de tareas
  List<Task> tasks = [
    Task(
      title: 'Tarea 1',
      description: 'Descripción de la Tarea 1',
      date:DateTime.now(),
      subTasks: [
        SubTask(title: 'Subtarea 1-1', completed: false),
        SubTask(title: 'Subtarea 1-2', completed: true),
      ],
    ),
    Task(
      title: 'Tarea 2',
      description: 'Descripción de la Tarea 2',
      date:DateTime.now(),
      subTasks: [
        SubTask(title: 'Subtarea 2-1', completed: false),
      ],
    ),
  ];
  @override
  
  //
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EasyTasks'),
        actions: [
          DropdownButton<String>(
            value: _selectedFilter,
            onChanged: (String? newValue) {
              setState(() {
                _selectedFilter = newValue!;
              });
            },
            items: _filters.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menú',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Agregar Calendario'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddCalendarScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.task),
              title: Text('Agregar Tarea'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddTaskScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.note),
              title: Text('Agregar Nota'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddNoteScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_view_day),
              title: Text('Ver Calendario'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ViewCalendarScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddCalendarScreen()),
                    );
                  },
                  child: Text('Agregar Calendario'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddTaskScreen()),
                    );
                  },
                  child: Text('Agregar Tarea'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewCalendarScreen()),
                    );
                  },
                  child: Text('Ver Calendario'),
                ),
                Expanded(
                  child: _buildTaskList(),
                ),
              ],
              
            ),
            SizedBox(height: 20),
            Text(
              'Tarea importante de la semana',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Card(
              elevation: 2,
              child: ListTile(
                leading: Icon(Icons.image),
                title: Text('Nombre Tarea'),
                subtitle: Text('Descripción tarea'),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Fecha'),
                    Text('Hora'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Tareas del día',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 7,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('${9 + index} AM'),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Acción para ver más tareas
              },
              child: Text('Ver más'),
            ),
            SizedBox(height: 20),
            Text(
              'Agrega una nota importante',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Card(
              elevation: 2,
              child: ListTile(
                title: Text('Nombre'),
                trailing: Text('Fecha'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
 //botones para vistas de tareas por fecha o prioridad
  String _selectedFilter = 'Fecha';

  List<String> _filters = ['Fecha', 'Prioridad', 'Proyecto'];

Widget _buildTaskList() {
    List<Map<String, String>> tasks = [
      /*{'name': 'Tarea 1', 'fecha': '2024-09-19', 'prioridad': 'Alta', 'proyecto': 'Proyecto A'},
      {'name': 'Tarea 2', 'fecha': '2024-09-20', 'prioridad': 'Media', 'proyecto': 'Proyecto B'},
      // Agrega más tareas según sea necesario*/

    ];

    if (_selectedFilter == 'Fecha') {
      tasks.sort((a, b) => a['fecha']!.compareTo(b['fecha']!));
    } else if (_selectedFilter == 'Prioridad') {
      tasks.sort((a, b) => a['prioridad']!.compareTo(b['prioridad']!));
    } else if (_selectedFilter == 'Proyecto') {
      tasks.sort((a, b) => a['proyecto']!.compareTo(b['proyecto']!));
    }

    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(tasks[index]['name']!),
          subtitle: Text('Fecha: ${tasks[index]['fecha']} - Prioridad: ${tasks[index]['prioridad']} - Proyecto: ${tasks[index]['proyecto']}'),
        );
      },
    );
  }



// Pantalla de Detalles de la Tarea (Task Detail Screen)
class TaskDetailScreen extends StatefulWidget {
  final Task task;

  TaskDetailScreen({ required this.task});

  @override
  _TaskDetailScreenState createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              widget.task.description,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Subtareas:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.task.subTasks.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    title: Text(widget.task.subTasks[index].title),
                    value: widget.task.subTasks[index].completed,
                    onChanged: (bool? value) {
                      setState(() {
                        widget.task.subTasks[index].completed = value?? false;
                      });
                    },
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _addSubTask(context);
              },
              child: Text('Agregar Subtarea'),
            ),
          ],
        ),
      ),
    );
  }

  // Método para agregar una subtarea
  void _addSubTask(BuildContext context) {
    TextEditingController subTaskController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Nueva Subtarea'),
          content: TextField(
            controller: subTaskController,
            decoration: InputDecoration(hintText: 'Título de la subtarea'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  widget.task.subTasks.add(SubTask(
                    title: subTaskController.text,
                    completed: false,
                  ));
                });
                Navigator.of(context).pop();
              },
              child: Text('Agregar'),
            ),
          ],
        );
      },
    );
  }
}

// Pantallas para Agregar Calendario
class AddCalendarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Calendario'),
      ),
      body: Center(
        child: Text('Pantalla para agregar un calendario'),
      ),
    );
  }
}

// Pantallas para Agregar Tarea
class AddTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Tarea'),
      ),
      body: Center(
        child: Text('Pantalla para agregar una tarea'),
      ),
    );
  }
}

// Pantallas para Agregar Nota
class AddNoteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Nota'),
      ),
      body: Center(
        child: Text('Pantalla para agregar una nota'),
      ),
    );
  }
}

// Pantallas para Ver Calendario
class ViewCalendarScreen extends StatelessWidget {
  const ViewCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ver Calendario'),
      ),
      body: const Center(
        child: Text('Pantalla para ver el calendario'),
      ),
    );
  }
}
