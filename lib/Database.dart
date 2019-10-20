import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:pdam/pojo/User.dart';
import 'package:pdam/pojo/Data.dart';

class DBProvider {
  DBProvider._();

  DBProvider();

  static final DBProvider db = DBProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    String path = join(await getDatabasesPath(), "pdamdb.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      print("CREATING DATABASE TABLES...");
      Batch batch = db.batch();
      batch.execute("CREATE TABLE Users ("
          "id VARCHAR(100) PRIMARY KEY,"
          "password TEXT)");
      batch.execute(
          "CREATE TABLE Datas(nik VARCHAR(40), noregsl VARCHAR(40), namapelanggan VARCHAR(40), alamat VARCHAR(100), notelp VARCHAR(20), nometer VARCHAR(20), fotorumah TEXT, fotoba TEXT, fotometeran TEXT)");
      List<dynamic> res = await batch.commit();
      print("DATABASE TABLES CREATED");
      
      
    });
  }

  newClient(User user) async {
    final db = await database;
    var res = await db.insert("Users", user.toJson());
    return res;
  }

  newData(Data d) async {
    final db = await database;
    var res = await db.insert("Datas", d.toJson());
    return res;
  }

  Future<User> login(User _user) async {
    final db = await database;
    var res = await db.query("Users",
        where: "id = ? AND password = ?",
        whereArgs: [_user.id, _user.password]);
    if (res.isNotEmpty) {
      return User.fromJson(res.first);
    } else {
      throw ("Username atau Password salah, periksa kembali");
    }
  }
}
