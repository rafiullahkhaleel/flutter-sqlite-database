import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  DbHelper._();
  static final DbHelper getInstance = DbHelper._();
  static final tableName = 'note';
  static final sNo = 'sNo';
  static final noteTitle = 'title';
  static final noteDesc = 'desc';
  static Database? _db;
  Future<Database> get getDB async {
    return _db ?? await initDB();
  }

  Future<Database> initDB() async {
    Directory docDir = await getApplicationDocumentsDirectory();
    String path = join(docDir.path, 'test.db');
    return openDatabase(
      path,
      onCreate: (db, version) {
        db.execute('''
        CREATE TABLE $tableName(
          $sNo INTEGER PRIMARY KEY AUTOINCREMENT,
          $noteTitle TEXT,
          $noteDesc TEXT
        )
      ''');

        /// you can make multiple tables like that but names of table should be unique
        // db.execute('''
        //   CREATE TABLE $anotherName(
        //     $sNo INTEGER PRIMARY KEY AUTOINCREMENT,
        //     $noteTitle TEXT,
        //     $noteDesc TEXT
        //   )
        // ''');
      },
      version: 1,
    );
  }

  Future<bool> addNote({required String title, required String desc}) async {
    final db = await getDB;
    int rowsEffected = await db.insert(tableName, {
      noteTitle: title,
      noteDesc: desc,
    });
    await getDB;
    return rowsEffected > 0;
  }

  Future<List<Map<String, Object?>>> fetchNote() async {
    final db = await getDB;
    return await db.query(tableName);
  }

  Future<bool> updateNote({
    required String title,
    required String desc,
    required int id,
  }) async {
    final db = await getDB;
    final isUpdate = await db.update(
      tableName,
      {noteTitle: title, noteDesc: desc},
      where: '$sNo = ?',
      whereArgs: [id],
    );
    return isUpdate > 0;
  }

  Future<bool> deleteNote({required int id}) async {
    final db = await getDB;
    final isDelete = await db.delete(
      tableName,
      where: '$sNo = ?',
      whereArgs: [id],
    );
    return isDelete > 0;
  }
}
