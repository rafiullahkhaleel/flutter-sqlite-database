import 'package:sqlite_database/clean_architecture/features/notes/data/model/note_model.dart';
import 'package:sqlite_database/clean_architecture/features/notes/domain/repositories/note_repository.dart';

class FetchNotes {
  final NotesRepository repo;
  FetchNotes(this.repo);
  Future<List<NoteModel>> call() => repo.fetchNotes();
}
