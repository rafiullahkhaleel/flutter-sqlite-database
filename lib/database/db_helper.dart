import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  DbHelper._();
  static final DbHelper getInstance = DbHelper._();
  static Database? _db;
  Future<Database> get database async {
    return _db ?? await initDB();
  }

  Future<Database> initDB() async{
    Directory docDir = await getApplicationDocumentsDirectory();
    String path = join(docDir.path, 'test.db');
    return openDatabase(path);
  }
}
