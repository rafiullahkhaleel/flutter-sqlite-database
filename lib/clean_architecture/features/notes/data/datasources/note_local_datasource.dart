import 'package:sqlite_database/clean_architecture/core/db/database_helper.dart';
import 'package:sqlite_database/clean_architecture/features/notes/data/model/note_model.dart';

class NoteLocalDatasource {
  final dbHelper = DatabaseHelper.getInstance;

  Future<List<NoteModel>> fetchNotes() async {
    final db = await dbHelper.database;
    final data = await db.query('notes');
    return data.map((e) => NoteModel.fromJson(e)).toList();
  }
}
