import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._();
  static final DatabaseHelper getInstance = DatabaseHelper._();
  static Database? _db;

  Future<Database> get database async {
    return _db ?? await initDB();
  }

  Future<Database> initDB() async {
    Directory docDir = await getApplicationDocumentsDirectory();
    String path = join(docDir.path, 'notes.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
      CREATE TABLE notes(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      description TEXT
      )
      ''');
      },
    );
  }
}
