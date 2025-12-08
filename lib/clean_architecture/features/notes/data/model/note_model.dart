import '../../domain/entities.dart';

class NoteModel extends NoteEntity {
  NoteModel({super.id, required super.title, required super.description});
  factory NoteModel.fromJson(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
    );
  }
  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'description': description};
  }
}
