import 'package:flutter/material.dart';

class AtrapaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Atrapa'),
      ),
      body: Center(
        child: Text(
          'Pantalla Atrapa',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
