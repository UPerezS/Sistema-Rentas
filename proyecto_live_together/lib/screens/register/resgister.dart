import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void register(BuildContext context) {
    String username = usernameController.text;
    String password = passwordController.text;

    // Aquí puedes agregar lógica de registro, como enviar los datos a un servidor.
    if (username.isNotEmpty && password.isNotEmpty) {
      print("Usuario registrado con éxito.");
      Navigator.pop(context); // Regresa a la pantalla de inicio de sesión
    } else {
      print("Por favor, completa todos los campos.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registro')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Usuario'),
            ),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => register(context),
              child: Text('Registrarse'),
            ),
          ],
        ),
      ),
    );
  }
}
