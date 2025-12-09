import 'package:sqlite_database/clean_architecture/features/notes/data/datasources/note_local_datasource.dart';
import 'package:sqlite_database/clean_architecture/features/notes/data/model/note_model.dart';
import 'package:sqlite_database/clean_architecture/features/notes/domain/repositories/note_repository.dart';

class NoteRepositoryImpl extends NotesRepository {
  final NoteLocalDatasource localDatasource;
  NoteRepositoryImpl(this.localDatasource);

  @override
  Future<List<NoteModel>> fetchNotes() async {
    return await localDatasource.fetchNotes();
  }

  @override
  Future<bool> addNotes(NoteModel note) async {
    return await localDatasource.addNotes(note);
  }

  @override
  Future<bool> deleteNotes(int id) async {
    return await localDatasource.deleteNotes(id);
  }

  @override
  Future<bool> updateNotes(NoteModel note) async {
    return await localDatasource.updateNotes(note);
  }
}
