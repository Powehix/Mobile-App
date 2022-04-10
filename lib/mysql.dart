import 'package:mysql1/mysql1.dart';

class MySQL {
  static String host = '10.0.2.2',
                user = 'root',
                password = 'root',
                db = 'qrcode_webapp';
  static int port = 3306;

  MySQL();

  Future<MySqlConnection> getConnection() async {
    var settings = new ConnectionSettings(
      host: host,
      port: port,
      user: user,
      password: password,
      db: db,
    );
    return await MySqlConnection.connect(settings);
  }
}