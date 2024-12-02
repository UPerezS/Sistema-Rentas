import 'package:mysql_client/mysql_client.dart';
import '../config/mysql_conexion.dart';

class PublicacionService {
  // Método para crear una publicación
  static Future<void> crearPublicacion({
    required int idPublicacion,
    required String titulo,
    required double costo,
    required String descripcion,
    required String ubicacion,
    required int idUsuario, // Relacionar publicación con un usuario
  }) async {
    final MySQLService mysqlService = MySQLService();
    final conn = await mysqlService.getConnection();

    try {
      String query = """
        INSERT INTO publicaciones (titulo, descripcion, costo, usuario_id)
        VALUES (:titulo, :descripcion, :costo, :usuario_id)
      """;

      await conn.execute(query, {
        'titulo': titulo,
        'descripcion': descripcion,
        'costo': costo,
        'ubicacion': ubicacion,
        'idUsuario': idUsuario,
      });
    } catch (e) {
      print("Error al crear publicación: $e");
      throw e;
    } finally {
      await conn.close();
    }
  }

 // Método para listar todas las publicaciones
static Future<List<Map<String, dynamic>>> listarPublicaciones() async {
  final MySQLService mysqlService = MySQLService();
  final conn = await mysqlService.getConnection();

  try {
    // Consulta simple para obtener todas las publicaciones
    String query = "SELECT * FROM publicaciones";

    final result = await conn.execute(query);

    // Convertir los resultados en una lista de mapas
    return result.rows.map((row) {
      return {
        'idPublicacion': row.colByName('idPublicacion'),
        'titulo': row.colByName('titulo'),
        'descripcion': row.colByName('descripcion'),
        'costo': row.colByName('costo'),
        'ubicacion': row.colByName('ubicacion'),
        'idUsuario': row.colByName('idUsuario'),
      };
    }).toList();
  } catch (e) {
    print("Error al listar publicaciones: $e");
    throw e;
  } finally {
    await conn.close();
  }
}

  // Método para eliminar una publicación por su ID
  static Future<void> eliminarPublicacion(int publicacionId) async {
    final MySQLService mysqlService = MySQLService();
    final conn = await mysqlService.getConnection();

    try {
      String query = """
        DELETE FROM publicaciones
        WHERE id = :id
      """;

      await conn.execute(query, {'id': publicacionId});
    } catch (e) {
      print("Error al eliminar publicación: $e");
      throw e;
    } finally {
      await conn.close();
    }
  }
}
