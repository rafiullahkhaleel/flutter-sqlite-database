import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../data/datasources/note_local_datasource.dart';
import '../../data/repositories/note_repository_impl.dart';
import '../../domain/entities/entities.dart';
import '../../domain/usecases/add_notes.dart';
import '../../domain/usecases/delete_notes.dart';
import '../../domain/usecases/fetch_notes.dart';
import '../../domain/usecases/update_notes.dart';

final errorProvider = StateProvider<String?>((ref) => null);
class NotesNotifier extends StateNotifier<AsyncValue<List<NoteEntity>>> {
  final FetchNotes _fetchNotes;
  final AddNotes _addNotes;
  final UpdateNotes _updateNotes;
  final DeleteNotes _deleteNotes;
  NotesNotifier(this._fetchNotes, this._addNotes, this._updateNotes, this._deleteNotes,
  ) : super(const AsyncValue.loading()) {fetch();}

  Future<bool> add(String title, String description, WidgetRef ref) async {
    try {
      return await _addNotes(
        NoteEntity(title: title, description: description),
      );
    } catch (e) {
      ref.read(errorProvider.notifier).state = e.toString();
      return false;
    }
  }

  Future<void> fetch() async {
    final data = await _fetchNotes();
    state = AsyncValue.data(data);
  }



  Future<bool> update(
    int id,
    String title,
    String description,
    WidgetRef ref,
  ) async {
    try {
      return await _updateNotes(
        NoteEntity(id: id, title: title, description: description),
      );
    } catch (e) {
      ref.read(errorProvider.notifier).state = e.toString();
      return false;
    }
  }

  Future<void> delete(int id) async {
    await _deleteNotes(id);
    fetch();
  }
}

final notesProvider =
StateNotifierProvider<NotesNotifier, AsyncValue<List<NoteEntity>>>((ref) {
  final dataSource = NoteLocalDatasource();
  final repo = NoteRepositoryImpl(dataSource);
  return NotesNotifier(
    FetchNotes(repo),
    AddNotes(repo),
    UpdateNotes(repo),
    DeleteNotes(repo),
  );
});