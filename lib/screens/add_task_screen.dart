import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:table_calendar/table_calendar.dart';

class AddTaskScreen extends StatefulWidget {
  final Function(Map<String, dynamic>) onAddTask;

  AddTaskScreen({required this.onAddTask});

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  // Variables para la tarea
  final _formKey = GlobalKey<FormState>();
  String _taskName = '';
  String _taskDescription = '';
  String _priority = 'Baja';
  File? _taskIcon;
  DateTime _selectedStartDate = DateTime.now();
  DateTime? _selectedEndDate;
  DateTime _focusedDate = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  String? _startTime; // Variable para la hora de inicio
  String? _endTime; // Variable para la hora de fin
  String _notificationType = 'Notificación push'; // Tipo de notificación
  String? _notificationTime; // Variable para la hora del recordatorio

  final ImagePicker _picker = ImagePicker();

  // Lista de horas para los dropdown
  final List<String> _hours = [
    '00:00',
    '01:00',
    '02:00',
    '03:00',
    '04:00',
    '05:00',
    '06:00',
    '07:00',
    '08:00',
    '09:00',
    '10:00',
    '11:00',
    '12:00',
    '13:00',
    '14:00',
    '15:00',
    '16:00',
    '17:00',
    '18:00',
    '19:00',
    '20:00',
    '21:00',
    '22:00',
    '23:00'
  ];

  // Lista de tipos de notificación
  final List<String> _notificationTypes = [
    'Notificación push',
    'Correo electrónico',
    'Mensaje de texto',
    'Llamada',
  ];

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _taskIcon = File(pickedFile.path);
      });
    }
  }

  void _addTask() {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> newTask = {
        'name': _taskName,
        'description': _taskDescription,
        'priority': _priority,
        'startDate': _selectedStartDate,
        'endDate': _selectedEndDate,
        'icon': _taskIcon,
        'startTime': _startTime,
        'endTime': _endTime,
        'notificationType': _notificationType,
        'notificationTime': _notificationTime,
      };

      widget.onAddTask(newTask);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Se agregó correctamente la tarea')),
      );

      _formKey.currentState!.reset();
      setState(() {
        _taskIcon = null;
        _selectedEndDate = null;
        _startTime = null;
        _endTime = null;
        _notificationTime = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Tarea'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Campo para el nombre de la tarea
              TextFormField(
                decoration: InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa un nombre';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _taskName = value;
                  });
                },
              ),
              SizedBox(height: 10),

              // Campo para la descripción de la tarea
              TextFormField(
                decoration: InputDecoration(labelText: 'Descripción'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa una descripción';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _taskDescription = value;
                  });
                },
              ),
              SizedBox(height: 10),

              // ComboBox de prioridad
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Prioridad'),
                items: ['Baja', 'Media-Baja', 'Media', 'Media-Alta', 'Alta']
                    .map((priority) {
                  return DropdownMenuItem(
                    value: priority,
                    child: Text(priority),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _priority = value!;
                  });
                },
              ),
              SizedBox(height: 10),

              // Campo para subir imagen
              Text(
                'Icono de la tarea:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              _taskIcon != null
                  ? Image.file(
                      _taskIcon!,
                      width: 100,
                      height: 100,
                    )
                  : Text('Ninguna imagen seleccionada'),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Seleccionar Icono'),
              ),
              SizedBox(height: 10),

              // ComboBox para la hora de inicio
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Hora de Inicio'),
                items: _hours.map((hour) {
                  return DropdownMenuItem(
                    value: hour,
                    child: Text(hour),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _startTime = value;
                  });
                },
              ),
              SizedBox(height: 10),

              // ComboBox para la hora de fin
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Hora de Fin'),
                items: _hours.map((hour) {
                  return DropdownMenuItem(
                    value: hour,
                    child: Text(hour),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _endTime = value;
                  });
                },
              ),
              SizedBox(height: 10),

              // ComboBox para el tipo de notificación
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Tipo de Notificación'),
                items: _notificationTypes.map((notificationType) {
                  return DropdownMenuItem(
                    value: notificationType,
                    child: Text(notificationType),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _notificationType = value!;
                  });
                },
              ),
              SizedBox(height: 10),

              // ComboBox para la hora del recordatorio
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Hora de Recordatorio'),
                items: ['Todo el día', ..._hours].map((hour) {
                  return DropdownMenuItem(
                    value: hour,
                    child: Text(hour),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _notificationTime = value;
                  });
                },
              ),
              SizedBox(height: 10),

              // Calendario para seleccionar fecha de inicio
              TableCalendar(
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 1, 1),
                focusedDay: _focusedDate,
                selectedDayPredicate: (day) =>
                    isSameDay(_selectedStartDate, day),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedStartDate = selectedDay;
                    _focusedDate = focusedDay;
                  });
                },
                calendarFormat: _calendarFormat,
                onFormatChanged: (format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                },
              ),
              SizedBox(height: 10),

              // Botón para agregar tarea
              ElevatedButton(
                onPressed: _addTask,
                child: Text('Agregar Tarea'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
