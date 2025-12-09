import 'package:sqlite_database/clean_architecture/features/notes/domain/repositories/note_repository.dart';

class DeleteNotes {
  final NotesRepository _repo;
  DeleteNotes(this._repo);
  Future<bool> call(int id) => _repo.deleteNotes(id);
}
