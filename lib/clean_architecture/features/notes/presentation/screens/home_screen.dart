import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/entities.dart';
import '../providers/notes_provider.dart';
import '../widgets/note_dialog.dart';

class MyHomeScreen extends ConsumerWidget {
  const MyHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notesState = ref.watch(notesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes List'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),

      body: notesState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
        data: (notes) {
          if (notes.isEmpty) {
            return const Center(child: Text("No Notes available"));
          }

          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final NoteEntity note = notes[index];

              return ListTile(
                leading: Text("${index + 1}"),
                title: Text(note.title),
                subtitle: Text(note.description),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// ---------- Edit Button ----------
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return NoteDialog(
                              isEdit: true,
                              titleText: note.title,
                              descText: note.description,
                              onSubmit: (title, desc) async {
                                await ref
                                    .read(notesProvider.notifier)
                                    .update(note.id!, title, desc);

                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Note Updated")),
                                );
                              },
                            );
                          },
                        );
                      },
                    ),

                    /// ---------- Delete Button ----------
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        await ref
                            .read(notesProvider.notifier)
                            .delete(note.id!);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Note Deleted")),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),

      /// ---------- Floating Button ----------
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return NoteDialog(
                isEdit: false,
                onSubmit: (title, desc) async {
                  await ref
                      .read(notesProvider.notifier)
                      .add(title, desc);

                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Note Added")),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
