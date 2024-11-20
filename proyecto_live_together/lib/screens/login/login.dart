import 'package:flutter/material.dart';
import 'package:proyecto_live_together/screens/register/resgister.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login',
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void navigateToRegister(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterScreen()),
    );
  }

  void login(BuildContext context) {
    String username = usernameController.text;
    String password = passwordController.text;

    // Aquí puedes agregar lógica de autenticación
    if (username.isNotEmpty && password.isNotEmpty) {
      // Si la autenticación es exitosa, navega a la pantalla principal o realiza alguna acción.
      print("Usuario autenticado con éxito.");
    } else {
      print("Por favor, ingresa tus credenciales.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Iniciar Sesión')),
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
              onPressed: () => login(context),
              child: Text('Iniciar Sesión'),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () => navigateToRegister(context),
              child: Text(
                '¿No tienes cuenta? Regístrate aquí',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
