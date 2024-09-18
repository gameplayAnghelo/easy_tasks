import 'package:flutter/material.dart';
import 'screens/add_calendar_screen.dart';
import 'screens/add_task_screen.dart';
import 'screens/add_note_screen.dart';
import 'screens/view_calendar_screen.dart';

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

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Map<String, dynamic>> tasks = [];

  void _addTask(Map<String, dynamic> task) {
    setState(() {
      tasks.add(task);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EasyTasks'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
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
                  MaterialPageRoute(
                      builder: (context) => AddTaskScreen(
                            onAddTask: _addTask, // Pasa la función aquí
                          )),
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
                      MaterialPageRoute(
                          builder: (context) => AddTaskScreen(
                                onAddTask: _addTask, // Pasa la función aquí
                              )),
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
