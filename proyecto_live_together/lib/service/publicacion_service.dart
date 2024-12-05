import 'package:mysql_client/mysql_client.dart';
import '../config/mysql_conexion.dart';

class PublicacionService {
  static Future<void> crearPublicacion({
    required int idPublicacion,
    required String titulo,
    required double costo,
    required String descripcion,
    required String ubicacion,
    required int idUsuario,
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
      print("Error al crear publicaci√≥n: $e");
      throw e;
    } finally {
      await conn.close();
    }
  }

  //  MÈtodo para listar publicaciones con sus im·genes
  static Future<List<Map<String, dynamic>>> listarPublicaciones() async {
    final MySQLService mysqlService = MySQLService();
    final conn = await mysqlService.getConnection();

    try {
      String query = """
      SELECT 
        p.idPublicacion, 
        p.titulo, 
        p.descripcion, 
        p.costo, 
        p.ubicacion, 
        p.idUsuario, 
        i.rutaimagen
      FROM 
        publicaciones p
      LEFT JOIN 
        imagenes i 
      ON 
        p.idPublicacion = i.idPublicacion;
    """;

      final result = await conn.execute(query);

      Map<int, Map<String, dynamic>> publicacionesMap = {};

      result.rows.forEach((row) {
        int? idPublicacion = row.colByName('idPublicacion') != null
            ? int.tryParse(row.colByName('idPublicacion')!)
            : null;

        if (idPublicacion != null) {
          if (!publicacionesMap.containsKey(idPublicacion)) {
            publicacionesMap[idPublicacion] = {
              'idPublicacion': idPublicacion,
              'titulo': row.colByName('titulo'),
              'descripcion': row.colByName('descripcion'),
              'costo': double.parse(row.colByName('costo')!),
              'ubicacion': row.colByName('ubicacion'),
              'idUsuario': int.parse(row.colByName('idUsuario')!),
              'imagenes': []
            };
          }

          String? rutaimagen = row.colByName('rutaimagen');
          if (rutaimagen != null) {
            publicacionesMap[idPublicacion]!['imagenes'].add(rutaimagen);
          }
        }
      });

      return publicacionesMap.values.toList();
    } catch (e) {
      print("Error al listar publicaciones: $e");
      throw e;
    } finally {
      await conn.close();
    }
  }

  static Future<List<Map<String, dynamic>>> filtrarPublicaciones({
    double? costoMaximo,
    String? ubicacion,
  }) async {
    final MySQLService mysqlService = MySQLService();
    final conn = await mysqlService.getConnection();

    try {
      // Construir la consulta SQL din·mica
      String query = """
      SELECT 
        p.idPublicacion, 
        p.titulo, 
        p.descripcion, 
        p.costo, 
        p.ubicacion, 
        p.idUsuario, 
        i.rutaimagen
      FROM 
        publicaciones p
      LEFT JOIN 
        imagenes i 
      ON 
        p.idPublicacion = i.idPublicacion
      WHERE 1=1
      """;

      // Lista de par·metros para la consulta
      Map<String, dynamic> params = {};

      // Agregar condiciones de filtro din·micamente
      if (costoMaximo != null) {
        query += " AND p.costo <= :costoMaximo";
        params['costoMaximo'] = costoMaximo;
      }

      if (ubicacion != null && ubicacion.isNotEmpty) {
        query += " AND p.ubicacion = :ubicacion";
        params['ubicacion'] = ubicacion;
      }

      final result = await conn.execute(query, params);

      // Procesar los resultados
      Map<int, Map<String, dynamic>> publicacionesMap = {};

      result.rows.forEach((row) {
        int? idPublicacion = row.colByName('idPublicacion') != null
            ? int.tryParse(row.colByName('idPublicacion')!)
            : null;

        if (idPublicacion != null) {
          if (!publicacionesMap.containsKey(idPublicacion)) {
            publicacionesMap[idPublicacion] = {
              'idPublicacion': idPublicacion,
              'titulo': row.colByName('titulo'),
              'descripcion': row.colByName('descripcion'),
              'costo': double.tryParse(row.colByName('costo') ?? '0'),
              'ubicacion': row.colByName('ubicacion'),
              'idUsuario': int.tryParse(row.colByName('idUsuario') ?? '0'),
              'imagenes': []
            };
          }

          String? rutaimagen = row.colByName('rutaimagen');
          if (rutaimagen != null) {
            publicacionesMap[idPublicacion]!['imagenes'].add(rutaimagen);
          }
        }
      });

      return publicacionesMap.values.toList();
    } catch (e) {
      print("Error al filtrar publicaciones: $e");
      throw e;
    } finally {
      await conn.close();
    }
  }

  // M√©todo para eliminar una publicaci√≥n por su ID
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
      print("Error al eliminar publicaci√≥n: $e");
      throw e;
    } finally {
      await conn.close();
    }
  }
}
