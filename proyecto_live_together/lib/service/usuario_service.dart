import 'package:mysql_client/mysql_client.dart';
import '../config/mysql_conexion.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class UsuarioService {
  // Método para registrar un usuario
  static Future<void> registrarUsuario({
    required String nombre,
    required String apellidos,
    required String correo,
    required String contrasena,
    required String telefono,
  }) async {
    final MySQLService mysqlService = MySQLService();
    final conn = await mysqlService.getConnection();

    try {
      // Encriptar la contraseña
      var hashedPassword = sha256.convert(utf8.encode(contrasena)).toString();

      String query = """
        INSERT INTO usuarios (nombre, apellidos, correo, contrasena, telefono, estatus)
        VALUES (:nombre, :apellidos, :correo, :contrasena, :telefono, 'inactivo')
      """;

      await conn.execute(query, {
        'nombre': nombre,
        'apellidos': apellidos,
        'correo': correo,
        'contrasena': hashedPassword,
        'telefono': telefono,
      });
    } catch (e) {
      print("Error al registrar usuario: $e");
      throw e;
    } finally {
      await conn.close();
    }
  }

  // Método para verificar credenciales (login)
  static Future<bool> loginUsuario({
    required String correo,
    required String contrasena,
  }) async {
    final MySQLService mysqlService = MySQLService();
    final conn = await mysqlService.getConnection();

    try {
      // Encriptar la contraseña ingresada
      var hashedPassword = sha256.convert(utf8.encode(contrasena)).toString();

      String query = """
      SELECT COUNT(*) as count
      FROM usuarios
      WHERE correo = :correo AND contrasena = :contrasena
    """;

      final result = await conn.execute(query, {
        'correo': correo,
        'contrasena': hashedPassword,
      });

      // Verificar si hay filas y si el valor de COUNT es mayor que 0
      if (result.rows.isNotEmpty) {
        final count = result.rows.first.colAt(0);
        return count != null && int.tryParse(count.toString())! > 0;
      }

      return false; // Si no hay filas, el usuario no existe o la contraseña no coincide
    } catch (e) {
      print("Error al iniciar sesión: $e");
      throw e;
    } finally {
      await conn.close();
    }
  }
}
