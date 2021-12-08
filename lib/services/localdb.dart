import 'dart:io';


import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static late Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    return await openDatabase('trapp_db.db',
        onCreate: (Database db, int version) async {
          await db.execute(
              "CREATE TABLE Places ("
                  "id TEXT PRIMARY KEY,"
                  "name TEXT,"
                  "img TEXT,"
                  "address TEXT,"
                  "latitude REAL,"
                  "longitude REAL,"
                  ")");
        });
  }
}

