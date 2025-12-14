import '../entities/entities.dart';
import '../repositories/note_repository.dart';

class AddNotes {
  final NotesRepository _repo;
  AddNotes(this._repo);
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

    return _repo.addNotes(note);
  }
}
