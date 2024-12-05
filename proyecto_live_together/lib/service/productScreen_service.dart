import 'package:mysql_client/mysql_client.dart';
import '../config/mysql_conexion.dart';

class ProductoService {
  // Obtener los detalles de un producto
  static Future<Map<String, dynamic>> obtenerDetallesProducto(
      int idProducto) async {
    final MySQLService mysqlService = MySQLService();
    final conn = await mysqlService.getConnection();

    try {
      String query = """
        SELECT p.idPublicacion, p.titulo, p.costo, p.descripcion, p.ubicacion, 
               u.nombre AS vendedor, u.correo, u.telefono
        FROM publicaciones p
        INNER JOIN usuarios u ON p.idUsuario = u.idUsuario
        WHERE p.idPublicacion = :idPublicacion
      """;

      final result = await conn.execute(query, {'idPublicacion': idProducto});

      if (result.rows.isEmpty) {
        throw Exception("Producto no encontrado.");
      }

      final row = result.rows.first;

      return {
        'idPublicacion': row.colByName('idPublicacion'),
        'titulo': row.colByName('titulo'),
        'costo': row.colByName('costo'),
        'descripcion': row.colByName('descripcion'),
        'ubicacion': row.colByName('ubicacion'),
        'vendedor': row.colByName('vendedor'),
        'correo': row.colByName('correo'),
        'telefono': row.colByName('telefono'),
      };
    } catch (e) {
      print("Error al obtener detalles del producto: $e");
      throw e;
    } finally {
      await conn.close();
    }
  }

  // Verificar si el usuario puede editar o eliminar
  static Future<bool> puedeEditarEliminar(
      int idProducto, int? idUsuario) async {
    if (idUsuario == null) {
      return false; // Si el idUsuario es nulo, no se puede editar ni eliminar
    }

    final MySQLService mysqlService = MySQLService();
    final conn = await mysqlService.getConnection();

    try {
      String query = """
      SELECT COUNT(*) AS count
      FROM publicaciones
      WHERE idPublicacion = :idPublicacion AND idUsuario = :idUsuario
    """;

      final result = await conn.execute(query, {
        'idPublicacion': idProducto,
        'idUsuario': idUsuario,
      });

      // Obtén el valor de count como un String y conviértelo a int
      final countString = result.rows.first.colByName('count') as String?;
      final count = int.tryParse(countString ?? '0') ??
          0; // Maneja el caso en que count es nulo o no es un número

      // Devuelve true si count > 0
      return count > 0;
    } catch (e) {
      print("Error al verificar permisos: $e");
      throw e;
    } finally {
      await conn.close();
    }
  }

// Método para obtener las imágenes de una publicación por su idPublicacion
  static Future<List<String>> obtenerImagenes(int idPublicacion) async {
    final MySQLService mysqlService = MySQLService();
    final conn = await mysqlService.getConnection();

    try {
      String query = """
        SELECT rutaimagen
        FROM imagenes
        WHERE idPublicacion = :idPublicacion
      """;

      final result = await conn.execute(query, {
        'idPublicacion': idPublicacion,
      });

      // Convertir los resultados en una lista de URLs de imágenes
      return result.rows
          .map((row) => row.colByName('rutaimagen') as String)
          .toList();
    } catch (e) {
      print("Error al obtener imágenes: $e");
      throw e;
    } finally {
      await conn.close();
    }
  }
}
