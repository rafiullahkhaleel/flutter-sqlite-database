
import '../../data/model/note_model.dart';
import '../entities/entities.dart';

abstract class NotesRepository {
  Future<List<NoteModel>> fetchNotes();
  Future<bool> addNotes(NoteEntity note);
  Future<bool> updateNotes(NoteEntity note);
  Future<bool> deleteNotes(int id);
}
