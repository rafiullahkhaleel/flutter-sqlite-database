import '../entities/entities.dart';
import '../repositories/note_repository.dart';

class UpdateNotes {
  final NotesRepository _repo;
  UpdateNotes(this._repo);
  Future<bool> call(NoteEntity note) {
    final title = note.title.trim();
    final desc = note.description.trim();

    if (title.isEmpty && desc.isEmpty) {
      throw Exception('Title and Description both are required');
    }

    if (title.isEmpty) {
      throw Exception('Description is required');
    }

    if (desc.isEmpty) {
      throw Exception('Title is required');
    }
    return _repo.updateNotes(note);
  }
}
