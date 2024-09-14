import 'package:flutter/material.dart';

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
