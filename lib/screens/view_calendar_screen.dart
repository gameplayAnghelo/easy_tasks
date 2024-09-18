import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/services.dart';

class ViewCalendarScreen extends StatefulWidget {
  @override
  _ViewCalendarScreenState createState() => _ViewCalendarScreenState();
}

class _ViewCalendarScreenState extends State<ViewCalendarScreen> {
  late Map<DateTime, List<String>> _tasksByDate;
  late List<String> _selectedTasks;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();

    // Forzar la orientación horizontal al entrar en esta pantalla
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    // Simulamos algunas tareas para los días
    _tasksByDate = {
      DateTime.utc(2024, 9, 18): ['Tarea 1', 'Tarea 2'],
      DateTime.utc(2024, 9, 19): ['Tarea 3'],
      DateTime.utc(2024, 9, 20): ['Tarea 4', 'Tarea 5'],
    };

    _selectedTasks = _tasksByDate[_focusedDay] ?? [];
  }

  @override
  void dispose() {
    // Restaurar la orientación predeterminada cuando salimos de la pantalla
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  List<String> _getTasksForDay(DateTime day) {
    return _tasksByDate[day] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
      _selectedTasks = _getTasksForDay(selectedDay);
    });
  }

  void _showTaskDetails(BuildContext context, String task) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Detalles de la Tarea'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Información completa sobre "$task"'),
              // Aquí puedes añadir más detalles de la tarea
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ver Calendario'),
      ),
      body: Row(
        children: [
          Expanded(
            child: TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: _onDaySelected,
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
              ),
            ),
          ),
          Expanded(
            child: _selectedTasks.isNotEmpty
                ? ListView.builder(
                    itemCount: _selectedTasks.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_selectedTasks[index]),
                        onTap: () {
                          _showTaskDetails(context, _selectedTasks[index]);
                        },
                      );
                    },
                  )
                : Center(
                    child: Text('No hay tareas para este día.'),
                  ),
          ),
        ],
      ),
    );
  }
}
