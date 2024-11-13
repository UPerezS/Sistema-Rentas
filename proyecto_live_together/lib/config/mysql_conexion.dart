import 'package:mysql_client/mysql_client.dart';

class MySQLService {
  Future<MySQLConnection> getConnection() async {
    final conn = await MySQLConnection.createConnection(
      host: 'b5gpr0dt5vig4v4fuchq-mysql.services.clever-cloud.com',
      port: 3306,
      userName: 'urgmhrwzu9dh2rmv',
      password: '6mENK3R0vqeFDMimZVXw',
      databaseName: 'b5gpr0dt5vig4v4fuchq',
    );
    await conn.connect();
    return conn;
  }
}
