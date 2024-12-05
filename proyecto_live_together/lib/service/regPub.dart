import 'package:mysql_client/mysql_client.dart';
import '../config/mysql_conexion.dart';

class PublicacionService {
  // Método para registrar una publicación
  static Future<void> registrarPublicacion({
    required String titulo,
    required String descripcion,
    required double costo,
    required String ubicacion,
    required int idUsuario,
  }) async {
    final MySQLService mysqlService = MySQLService();
    final conn = await mysqlService.getConnection();

    try {
      String query = """
        INSERT INTO publicaciones (titulo, descripcion, costo, ubicacion, idUsuario)
        VALUES (:titulo, :descripcion, :costo, :ubicacion, :idUsuario)
      """;

      await conn.execute(query, {
        'titulo': titulo,
        'descripcion': descripcion,
        'costo': costo.toStringAsFixed(2), // Formato decimal para MySQL
        'ubicacion': ubicacion,
        'idUsuario': idUsuario,
      });
    } catch (e) {
      print("Error al registrar publicación: $e");
      throw e;
    } finally {
      await conn.close();
    }
  }
}
