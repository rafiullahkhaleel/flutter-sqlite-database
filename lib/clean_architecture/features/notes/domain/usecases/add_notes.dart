import 'package:sqlite_database/clean_architecture/features/notes/domain/entities/entities.dart';
import 'package:sqlite_database/clean_architecture/features/notes/domain/repositories/note_repository.dart';

class AddNotes {
  final NotesRepository _repo;
  AddNotes(this._repo);
  Future<bool> call(NoteEntity note) => _repo.addNotes(note);
}
