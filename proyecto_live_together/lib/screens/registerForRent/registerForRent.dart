import 'package:flutter/material.dart';
import 'package:proyecto_live_together/screens/home/home.dart';
import '../../service/regPub.dart';

class PropertyRegistrationPage extends StatefulWidget {
  @override
  _PropertyRegistrationPageState createState() =>
      _PropertyRegistrationPageState();
}

class _PropertyRegistrationPageState extends State<PropertyRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _locationController = TextEditingController();

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        await PublicacionService.registrarPublicacion(
          titulo: _titleController.text,
          descripcion: _descriptionController.text,
          costo: double.parse(_priceController.text),
          ubicacion: _locationController.text,
          idUsuario: 1, // Cambia por el ID del usuario actual si es necesario
        );

        // Mostrar notificación de éxito
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Publicación registrada exitosamente')),
        );

        // Navegar a la pantalla Home
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (route) => false, // Elimina todas las pantallas anteriores de la pila
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al registrar publicación: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar Inmueble'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Título'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un título';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Descripción'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa una descripción';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Precio'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el precio';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Por favor ingresa un precio válido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(labelText: 'Ubicación'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa la ubicación';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Registrar Inmueble'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
