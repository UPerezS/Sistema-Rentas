import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  void register(BuildContext context) {
    String password = passwordController.text;
    String email = emailController.text;
    String name = nameController.text;
    String lastName = lastNameController.text;
    String phone = phoneController.text;

    // Validar que todos los campos estén llenos
    if (name.isNotEmpty &&
        lastName.isNotEmpty &&
        email.isNotEmpty &&
        password.isNotEmpty &&
        phone.isNotEmpty) {
      print("Usuario registrado con éxito:");
      print("Correo: $email");
      print("Nombre: $name $lastName");
      print("Teléfono: $phone");
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Nombre'),
              ),
              TextFormField(
                controller: lastNameController,
                decoration: InputDecoration(labelText: 'Apellidos'),
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Correo'),
                keyboardType: TextInputType.emailAddress,
              ),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
              ),
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Teléfono'),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => register(context),
                child: Text('Registrarse'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
