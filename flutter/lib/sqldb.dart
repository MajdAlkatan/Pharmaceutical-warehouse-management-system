import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlDb {
  initialdb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'majd.db');
    Database mydb = await openDatabase(path, onCreate: _create);
    return mydb;
  }

  _create(Database database, int version) {}
}
