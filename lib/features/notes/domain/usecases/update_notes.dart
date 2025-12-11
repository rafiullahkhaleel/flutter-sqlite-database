import '../entities/entities.dart';
import '../repositories/note_repository.dart';

class UpdateNotes {
  final NotesRepository _repo;
  UpdateNotes(this._repo);
  Future<bool> call(NoteEntity note) => _repo.updateNotes(note);

}