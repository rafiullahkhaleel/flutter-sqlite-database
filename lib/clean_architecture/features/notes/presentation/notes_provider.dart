import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:sqlite_database/clean_architecture/features/notes/domain/entities/entities.dart';

import '../data/model/note_model.dart';
import '../domain/usecases/add_notes.dart';
import '../domain/usecases/delete_notes.dart';
import '../domain/usecases/fetch_notes.dart';
import '../domain/usecases/update_notes.dart';

class NotesNotifier extends StateNotifier<AsyncValue<List<NoteModel>>> {
  final FetchNotes _fetchNotes;
  final AddNotes _addNotes;
  final UpdateNotes _updateNotes;
  final DeleteNotes _deleteNotes;
  NotesNotifier(
    this._fetchNotes,
    this._addNotes,
    this._updateNotes,
    this._deleteNotes,
  ) : super(const AsyncValue.loading()) {
    fetch();
  }
  Future<void> fetch() async {
    final data = await _fetchNotes();
    state = AsyncValue.data(data);
  }

  Future<void> add(String title, String description) async {
    await _addNotes(NoteEntity(title: title, description: description));
    fetch();
  }

  Future<void> update(int id, String title, String description) async {
    await _updateNotes(
      NoteEntity(id: id, title: title, description: description),
    );
    fetch();
  }

  Future<void> delete(int id) async {
    await _deleteNotes(id);
    fetch();
  }
}
