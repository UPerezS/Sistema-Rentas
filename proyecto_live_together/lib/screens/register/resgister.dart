import 'package:flutter/material.dart';
import 'package:proyecto_live_together/service/usuario_service.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  // Método para registrar al usuario usando UsuarioService
  Future<void> register(BuildContext context) async {
    String password = passwordController.text;
    String email = emailController.text;
    String name = nameController.text;
    String lastName = lastNameController.text;
    String phone = phoneController.text;

    // Validar que todos los campos estén llenos
    if (name.isEmpty ||
        lastName.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Por favor, completa todos los campos.")),
      );
      return;
    }

    try {
      // Llamar al servicio para registrar el usuario
      await UsuarioService.registrarUsuario(
        nombre: name,
        apellidos: lastName,
        correo: email,
        contrasena: password,
        telefono: phone,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Usuario registrado con éxito.")),
      );

      // Regresar a la pantalla de inicio de sesión
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al registrar el usuario: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
              TextFormField(
                controller: lastNameController,
                decoration: const InputDecoration(labelText: 'Apellidos'),
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Correo'),
                keyboardType: TextInputType.emailAddress,
              ),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
              ),
              TextFormField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: 'Teléfono'),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => register(context),
                child: const Text('Registrarse'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
