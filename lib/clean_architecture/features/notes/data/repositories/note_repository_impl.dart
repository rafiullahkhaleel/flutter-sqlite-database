import 'package:sqlite_database/clean_architecture/features/notes/data/datasources/note_local_datasource.dart';
import 'package:sqlite_database/clean_architecture/features/notes/data/model/note_model.dart';
import 'package:sqlite_database/clean_architecture/features/notes/domain/entities/entities.dart';
import 'package:sqlite_database/clean_architecture/features/notes/domain/repositories/note_repository.dart';

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
      NoteModel(title: note.title, description: note.description),
    );
  }
}
