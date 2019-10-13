import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:pdam/pojo/User.dart';

class DBProvider {
  DBProvider._();

  DBProvider();

  static final DBProvider db = DBProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null)
      return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {

    String path = join(await getDatabasesPath(),"pdamdb.db");
    return await openDatabase(path, version: 1, onOpen: (db) {
    }, onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Users ("
          "id VARCHAR(100) PRIMARY KEY,"
          "password TEXT)");
    //TO DO : this will be removed
      //newClient(User(id:"'user1'",password:"'system3298'"));
    });

  }
  newClient(User _user) async {
    final db = await database;
    var res = await db.rawInsert(
        "INSERT INTO Users (id,password)"
            " VALUES (${_user.id},${_user.password})");
    return res;
  }
  Future<User> login(User _user) async {
    final db = await database;
    var res =await  db.query("Users", where: "id = ? AND password = ?", whereArgs: [_user.id, _user.password]);
    if (res.isNotEmpty){
      return User.fromJson(res.first);
    }else{
      throw ("Username atau Password salah, periksa kembali");
    }
   }
}