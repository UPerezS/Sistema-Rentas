import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:proyecto_live_together/screens/login/login.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedEstado;
  String? selectedLocalidad;
  String? selectedCategoria;
  final TextEditingController costoController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();

  void navigateToAtrapa(BuildContext context) {
    
  }

  void onSubmit() {
    print('Estado: $selectedEstado');
    print('Localidad: $selectedLocalidad');
    print('Categor�a: $selectedCategoria');
    print('Costo: ${costoController.text}');
    print('Descripci�n: ${descripcionController.text}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        toolbarHeight: 80,
        actions: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: FaIcon(FontAwesomeIcons.home, color: Colors.white),
                      onPressed: () => navigateToAtrapa(context),
                    ),
                    Text('Inicio', style: TextStyle(color: Colors.white)),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: FaIcon(FontAwesomeIcons.user, color: Colors.white),
                      onPressed: () => navigateToAtrapa (context),
                    ),
                    Text('Iniciar Sesi�n',
                        style: TextStyle(color: Colors.white)),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: FaIcon(FontAwesomeIcons.comments,
                          color: Colors.white),
                      onPressed: () => navigateToAtrapa(context),
                    ),
                    Text('Chat', style: TextStyle(color: Colors.white)),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: FaIcon(FontAwesomeIcons.star, color: Colors.white),
                      onPressed: () => navigateToAtrapa(context),
                    ),
                    Text('Membrec�a', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'Filtros',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
                letterSpacing: 1.5,
              ),
            ),
            SizedBox(height: 20),
            // Primera fila: Dropdowns
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Estado'),
                    items: [
                      DropdownMenuItem(
                          value: 'En espera', child: Text('En espera')),
                      DropdownMenuItem(value: 'Activo', child: Text('Activo')),
                      DropdownMenuItem(
                          value: 'Finalizado', child: Text('Finalizado')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedEstado = value;
                      });
                    },
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Localidad'),
                    items: [
                      DropdownMenuItem(
                          value: 'En espera', child: Text('En espera')),
                      DropdownMenuItem(
                          value: 'Ciudad A', child: Text('Ciudad A')),
                      DropdownMenuItem(
                          value: 'Ciudad B', child: Text('Ciudad B')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedLocalidad = value;
                      });
                    },
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Categor�a'),
                    items: [
                      DropdownMenuItem(
                          value: 'En espera', child: Text('En espera')),
                      DropdownMenuItem(
                          value: 'Opci�n 1', child: Text('Opci�n 1')),
                      DropdownMenuItem(
                          value: 'Opci�n 2', child: Text('Opci�n 2')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedCategoria = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Segunda fila: Campos de texto y bot�n
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: costoController,
                    decoration: InputDecoration(
                      labelText: 'Costo',
                      hintText: 'Ingrese el costo',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: descripcionController,
                    decoration: InputDecoration(
                      labelText: 'Descripci�n',
                      hintText: 'Ingrese una descripci�n',
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: onSubmit,
                  child: Text('Enviar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
}
