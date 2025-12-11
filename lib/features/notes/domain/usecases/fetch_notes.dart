import '../entities/entities.dart';
import '../repositories/note_repository.dart';
class FetchNotes {
  final NotesRepository repo;
  FetchNotes(this.repo);
  Future<List<NoteEntity>> call() => repo.fetchNotes();
}
