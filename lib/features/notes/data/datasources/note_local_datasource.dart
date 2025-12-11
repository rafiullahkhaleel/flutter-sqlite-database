
import '../../../../core/db/database_helper.dart';
import '../model/note_model.dart';

class NoteLocalDatasource {
  final dbHelper = DatabaseHelper.getInstance;

  Future<List<NoteModel>> fetchNotes() async {
    final db = await dbHelper.database;
    final data = await db.query('notes');
    return data.map((e) => NoteModel.fromJson(e)).toList();
  }

  Future<bool> addNotes(NoteModel note) async {
    final db = await dbHelper.database;
    final data = await db.insert('notes', note.toMap());
    return data > 0;
  }

  Future<bool> updateNotes(NoteModel note) async {
    final db = await dbHelper.database;
    final data = await db.update(
      'notes',
      note.toMap(),
      where: "id = ?",
      whereArgs: [note.id],
    );
    return data > 0;
  }

  Future<bool> deleteNotes(int id) async {
    final db = await dbHelper.database;
    final data = await db.delete('notes', where: "id = ?", whereArgs: [id]);
    return data > 0;
  }
}
