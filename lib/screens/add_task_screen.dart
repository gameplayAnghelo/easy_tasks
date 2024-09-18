// lib/screens/add_task_screen.dart
import 'package:flutter/material.dart';
import '../models/task.dart'; // Importar el modelo Task

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  List<SubTask> subTasks = [];

  TextEditingController taskController = TextEditingController();
  TextEditingController subTaskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Tarea'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: taskController,
              decoration: InputDecoration(labelText: 'Título de la tarea'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: subTaskController,
              decoration: InputDecoration(labelText: 'Subtarea'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  subTasks.add(SubTask(title: subTaskController.text));
                  subTaskController.clear();
                });
              },
              child: Text('Agregar subtarea'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: subTasks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(subTasks[index].title),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Guardar la tarea con sus subtareas
              },
              child: Text('Guardar Tarea'),
            ),
          ],
        ),
      ),
    );
  }
}
