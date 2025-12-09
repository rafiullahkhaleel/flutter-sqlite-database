import 'package:sqlite_database/clean_architecture/features/notes/domain/repositories/note_repository.dart';

import '../../data/model/note_model.dart';

class UpdateNotes {
  final NotesRepository _repo;
  UpdateNotes(this._repo);
  Future<bool> call(NoteModel note) => _repo.updateNotes(note);

}