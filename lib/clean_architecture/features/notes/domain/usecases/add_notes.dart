import 'package:sqlite_database/clean_architecture/features/notes/data/model/note_model.dart';
import 'package:sqlite_database/clean_architecture/features/notes/domain/repositories/note_repository.dart';

class AddNotes {
  final NotesRepository _repo;
  AddNotes(this._repo);
  Future<bool> call(NoteModel note) => _repo.addNotes(note);
}
