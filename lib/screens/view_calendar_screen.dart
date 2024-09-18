import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/services/api_service.dart'; // Asegúrate de reemplazar 'your_app' con el nombre real de tu paquete

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
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  Future<void> _loadTasks() async {
    final fetchedTasks = await _apiService.getTasks();
    setState(() {
      _tasksByDate = _formatTasksByDate(fetchedTasks);
      _selectedTasks = _tasksByDate[_focusedDay] ?? [];
    });
  }

  Map<DateTime, List<String>> _formatTasksByDate(List<Map<String, dynamic>> tasks) {
    final Map<DateTime, List<String>> tasksByDate = {};
    for (var task in tasks) {
      final date = DateTime.parse(task['startDate']).toLocal();
      if (tasksByDate[date] == null) {
        tasksByDate[date] = [];
      }
      tasksByDate[date]!.add(task['name']);
    }
    return tasksByDate;
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
      _selectedTasks = _tasksByDate[selectedDay] ?? [];
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
