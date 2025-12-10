import 'package:flutter/material.dart';
import 'package:sqlite_database/database/db_helper.dart';
import 'package:sqlite_database/widgets/note_dailoge.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();
  final DbHelper _db = DbHelper.getInstance;
  late Future<List<Map<String, Object?>>> _note;
  @override
  void initState() {
    _note = _db.fetchNote();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes List'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),

      body: FutureBuilder(
        future: _note,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: Text('No Notes available'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text('${index + 1}'),
                  title: Text(
                    snapshot.data?[index][DbHelper.noteTitle].toString() ?? '',
                  ),
                  subtitle: Text(
                    snapshot.data?[index][DbHelper.noteDesc].toString() ?? '',
                  ),
                  trailing: Row(
                    mainAxisSize: .min,
                    children: [
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return NoteDialogm(
                                title: title,
                                desc: desc,
                                onTap: () async {
                                  final msg = ScaffoldMessenger.of(context);
                                  final pop = Navigator.of(context);
                                  final check = await _db.updateNote(
                                    title: title.text,
                                    desc: desc.text,
                                    id:
                                        snapshot.data?[index][DbHelper.sNo]
                                            as int,
                                  );
                                  if (check) {
                                    setState(() {
                                      _note = _db.fetchNote();
                                    });
                                    pop.pop();
                                    msg.showSnackBar(
                                      SnackBar(content: Text('Note Updated')),
                                    );
                                  } else {
                                    msg.showSnackBar(
                                      SnackBar(content: Text('Try Again')),
                                    );
                                  }
                                },
                              );
                            },
                          );
                        },
                        icon: Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {
                          _db.deleteNote(
                            id: snapshot.data?[index][DbHelper.sNo] as int,
                          );
                          setState(() {
                            _note = _db.fetchNote();
                          });
                        },
                        icon: Icon(Icons.delete),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return NoteDialogm(
                title: title,
                desc: desc,
                onTap: () async {
                  final msg = ScaffoldMessenger.of(context);
                  final pop = Navigator.of(context);
                  final check = await _db.addNote(
                    title: title.text,
                    desc: desc.text,
                  );
                  if (check) {
                    setState(() {
                      _note = _db.fetchNote();
                    });
                    pop.pop();
                    msg.showSnackBar(SnackBar(content: Text('Note Added')));
                  } else {
                    msg.showSnackBar(SnackBar(content: Text('Try Again')));
                  }
                },
              );
            },
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
