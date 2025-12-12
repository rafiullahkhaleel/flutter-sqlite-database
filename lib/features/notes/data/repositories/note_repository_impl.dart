import '../../domain/entities/entities.dart';
import '../../domain/repositories/note_repository.dart';
import '../datasources/note_local_datasource.dart';
import '../model/note_model.dart';

class NoteRepositoryImpl extends NotesRepository {
  final NoteLocalDatasource localDatasource;
  NoteRepositoryImpl(this.localDatasource);

  @override
  Future<List<NoteModel>> fetchNotes() async {
    return await localDatasource.fetchNotes();
  }

  @override
  Future<bool> addNotes(NoteEntity note) async {
    return await localDatasource.addNotes(
      NoteModel(title: note.title, description: note.description),
    );
  }

  @override
  Future<bool> deleteNotes(int id) async {
    return await localDatasource.deleteNotes(id);
  }

  @override
  Future<bool> updateNotes(NoteEntity note) async {
    return await localDatasource.updateNotes(
      NoteModel(title: note.title, description: note.description, id: note.id),
    );
  }
}
