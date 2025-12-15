import 'package:flutter/material.dart';

class NoteDialog extends StatefulWidget {
  final bool isEdit;
  final String? titleText;
  final String? descText;
  final Function(String title, String desc) onSubmit;

  const NoteDialog({
    super.key,
    required this.onSubmit,
    this.isEdit = false,
    this.titleText,
    this.descText,
  });

  @override
  State<NoteDialog> createState() => _NoteDialogState();
}

class _NoteDialogState extends State<NoteDialog> {
  late TextEditingController titleController;
  late TextEditingController descController;

  @override
  void initState() {
    titleController = TextEditingController(text: widget.titleText ?? "");
    descController = TextEditingController(text: widget.descText ?? "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Text(widget.isEdit ? "Edit Note" : "Add Note"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: 'Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: descController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onSubmit(titleController.text, descController.text);
          },
          child: Text(widget.isEdit ? "Update" : "Add"),
        ),
      ],
    );
  }
}
