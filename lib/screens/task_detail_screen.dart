// lib/screens/task_detail_screen.dart
import 'package:flutter/material.dart';

import '../models/task.dart'; // Importar el modelo Task

class TaskDetailScreen extends StatefulWidget {
  final Task task;

  TaskDetailScreen({required this.task});

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
                        widget.task.subTasks[index].completed = value ?? false;
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
