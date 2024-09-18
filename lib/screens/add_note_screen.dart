import 'package:flutter/material.dart';

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
