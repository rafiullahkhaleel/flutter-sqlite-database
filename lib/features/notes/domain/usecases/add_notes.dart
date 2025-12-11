
import '../entities/entities.dart';
import '../repositories/note_repository.dart';

class AddNotes {
  final NotesRepository _repo;
  AddNotes(this._repo);
  Future<bool> call(NoteEntity note) => _repo.addNotes(note);
}
