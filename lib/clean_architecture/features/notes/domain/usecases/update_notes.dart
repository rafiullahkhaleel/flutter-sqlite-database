import 'package:sqlite_database/clean_architecture/features/notes/domain/entities/entities.dart';
import 'package:sqlite_database/clean_architecture/features/notes/domain/repositories/note_repository.dart';


class UpdateNotes {
  final NotesRepository _repo;
  UpdateNotes(this._repo);
  Future<bool> call(NoteEntity note) => _repo.updateNotes(note);

}