import 'package:mysql_client/mysql_client.dart';
import '../config/mysql_conexion.dart';

class PerfilService {
  // Obtener los detalles de un usuario
  static Future<Map<String, dynamic>> obtenerDetallesUsuario(
      int idUsuario) async {
    final MySQLService mysqlService = MySQLService();
    final conn = await mysqlService.getConnection();

    try {
      String query = """
        SELECT nombre, apellidos, correo, telefono, estatus
        FROM usuarios
        WHERE idUsuario = :idUsuario
      """;

      final result = await conn.execute(query, {'idUsuario': idUsuario});

      if (result.rows.isEmpty) {
        throw Exception("Usuario no encontrado.");
      }

      final row = result.rows.first;

      return {
        'nombre': row.colByName('nombre'),
        'apellidos': row.colByName('apellidos'),
        'correo': row.colByName('correo'),
        'telefono': row.colByName('telefono'),
        'estatus': row.colByName('estatus'),
      };
    } catch (e) {
      print("Error al obtener detalles del usuario: $e");
      throw e;
    } finally {
      await conn.close();
    }
  }

  // Actualizar los datos de un usuario
  static Future<void> actualizarUsuario({
    required int idUsuario,
    required String nombre,
    required String apellidos,
    required String correo,
    required String telefono,
  }) async {
    final MySQLService mysqlService = MySQLService();
    final conn = await mysqlService.getConnection();

    try {
      const query = """
        UPDATE usuarios
        SET nombre = :nombre,
            apellidos = :apellidos,
            correo = :correo,
            telefono = :telefono
        WHERE idUsuario = :idUsuario
      """;

      final params = {
        'idUsuario': idUsuario,
        'nombre': nombre,
        'apellidos': apellidos,
        'correo': correo,
        'telefono': telefono,
      };

      await conn.execute(query, params);

      print("Usuario actualizado correctamente.");
    } catch (e) {
      print("Error al actualizar el usuario: $e");
      throw e;
    } finally {
      await conn.close();
    }
  }

  /// Eliminar un usuario y todas sus publicaciones asociadas.
  static Future<void> eliminarUsuario(int idUsuario) async {
    final MySQLService mysqlService = MySQLService();
    final conn = await mysqlService.getConnection();

    try {
      // Eliminar las imágenes relacionadas con las publicaciones del usuario
      const deleteImagesQuery = """
        DELETE i
        FROM imagenes i
        JOIN publicaciones p ON i.idPublicacion = p.idPublicacion
        WHERE p.idUsuario = :idUsuario
      """;
      await conn.execute(deleteImagesQuery, {'idUsuario': idUsuario});

      // Eliminar las publicaciones relacionadas con el usuario
      const deletePostsQuery = """
        DELETE FROM publicaciones
        WHERE idUsuario = :idUsuario
      """;
      await conn.execute(deletePostsQuery, {'idUsuario': idUsuario});

      // Eliminar el usuario
      const deleteUserQuery = """
        DELETE FROM usuarios
        WHERE idUsuario = :idUsuario
      """;
      await conn.execute(deleteUserQuery, {'idUsuario': idUsuario});

      print("Usuario y sus publicaciones eliminados correctamente.");
    } catch (e) {
      print("Error al eliminar el usuario: $e");
      throw e;
    } finally {
      await conn.close();
    }
  }
}
