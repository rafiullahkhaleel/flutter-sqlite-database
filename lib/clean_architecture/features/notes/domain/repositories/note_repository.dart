import 'package:sqlite_database/clean_architecture/features/notes/data/model/note_model.dart';

abstract class NotesRepository {
  Future<List<NoteModel>> fetchNotes();
  Future<bool> addNotes(NoteModel note);
  Future<bool> updateNotes(NoteModel note);
  Future<bool> deleteNotes(int id);
}
