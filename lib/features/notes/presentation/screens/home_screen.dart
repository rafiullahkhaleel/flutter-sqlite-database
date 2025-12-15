import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqlite_database/core/utils/snackbar_helper.dart';
import 'package:sqlite_database/features/notes/presentation/widgets/delete_confirmation_dailoge.dart';
import '../../domain/entities/entities.dart';
import '../providers/notes_provider.dart';
import '../widgets/note_dialog.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    ref.listen<String?>(errorProvider, (previous, next) {
      if (next != null) {
        SnackBarHelper.show(context, next);
        ref.read(errorProvider.notifier).state = null;
      }
    });

    final notesState = ref.watch(notesProvider);
    final noteNotifier = ref.read(notesProvider.notifier);

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
                                final check = await noteNotifier.update(
                                  note.id!,
                                  title,
                                  desc,
                                  ref,
                                );
                                if (!context.mounted) return;
                                Navigator.pop(context);
                                if (check) {
                                  SnackBarHelper.show(context, 'Note Updated');
                                  noteNotifier.fetch();
                                }
                              },
                            );
                          },
                        );
                      },
                    ),

                    /// ---------- Delete Button ----------
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        showDeleteConfirmationDialog(
                          context: context,
                          onDelete: () async {
                            await noteNotifier.delete(note.id!);
                            noteNotifier.fetch();
                            if (!context.mounted) return;
                            SnackBarHelper.show(context, 'Note Deleted');
                          },
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
                  final check = await noteNotifier.add(title, desc, ref);
                  if (!context.mounted) return;
                  Navigator.pop(context);
                  if (check) {
                    SnackBarHelper.show(context, 'Note Added');
                    noteNotifier.fetch();
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
