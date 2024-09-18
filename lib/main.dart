import 'package:flutter/material.dart';
import 'screens/view_all_tasks.dart';
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
  List<String> taskNames = [
    'Tarea 1',
    'Tarea 2',
    'Tarea 3'
  ]; // Ejemplo de tareas
  String selectedTask = 'Sin asignar';
  String selectedFilter = 'Prioridad';
  DateTime? selectedDate;

  void _addTask(Map<String, dynamic> task) {
    setState(() {
      tasks.add(task);
    });
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
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
              leading: Icon(Icons.home),
              title: Text('Inicio'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MainScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Todas mis Tareas'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ViewAllTasks()),
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
                itemCount: 7, // Ejemplo de 7 horas del día
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('${9 + index} AM'),
                  );
                },
              ),
            ),
            // Botón transparente de "Ver más"
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ViewAllTasks()),
                );
              },
              child: Text(
                'Ver más',
                style: TextStyle(color: Colors.blue), // Color del texto azul
              ),
              style: TextButton.styleFrom(
                backgroundColor: Colors.transparent, // Botón transparente
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Agrega una nota importante',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Campo para ingresar el nombre de la nota
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Nombre de la nota',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),

                    // Selección de fecha para la nota
                    Row(
                      children: [
                        Text(
                          selectedDate == null
                              ? 'Selecciona una fecha'
                              : 'Fecha: ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                        ),
                        IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: () => _selectDate(context),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),

                    // ComboBox para seleccionar una tarea
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelText: 'Asigna a una tarea (opcional)',
                              border: OutlineInputBorder(),
                            ),
                            value: selectedTask,
                            items: ['Sin asignar', ...taskNames]
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedTask = newValue!;
                              });
                            },
                          ),
                        ),
                        SizedBox(width: 10),

                        // Filtro de tareas por prioridad o nombre
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelText: 'Filtrar por',
                              border: OutlineInputBorder(),
                            ),
                            value: selectedFilter,
                            items: ['Prioridad', 'Nombre A-Z', 'Nombre Z-A']
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedFilter = newValue!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),

                    // Botón para agregar la nota
                    ElevatedButton(
                      onPressed: () {
                        // Lógica para agregar la nota, conectar con base de datos más tarde
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Nota agregada'),
                          ),
                        );
                      },
                      child: Text('Agregar Nota'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}