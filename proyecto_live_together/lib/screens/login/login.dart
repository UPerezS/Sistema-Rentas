import 'package:flutter/material.dart';
import 'package:proyecto_live_together/screens/home/home.dart';
import 'package:proyecto_live_together/screens/register/resgister.dart';
import 'package:proyecto_live_together/service/usuario_service.dart';
import 'package:proyecto_live_together/utils/session.dart';

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
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void navigateToRegister(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterScreen()),
    );
  }

  Future<void> login(BuildContext context) async {
  String email = emailController.text;
  String password = passwordController.text;

  if (email.isEmpty || password.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Por favor, ingresa tus credenciales.")),
    );
    return;
  }

  try {
    int? userId = await UsuarioService.loginUsuario(
      correo: email,
      contrasena: password,
    );

    if (userId != null) {
      // Guardar el idUsuario en la sesión global
      Session().setUserId(userId);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Inicio de sesión exitoso.")),
      );

      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Credenciales incorrectas.")),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error al iniciar sesión: $e")),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Iniciar Sesión')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Correo'),
            ),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => login(context),
              child: const Text('Iniciar Sesión'),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () => navigateToRegister(context),
              child: const Text(
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
