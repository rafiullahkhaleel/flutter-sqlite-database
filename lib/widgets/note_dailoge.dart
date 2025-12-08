import 'package:flutter/material.dart';

class NoteDialog extends StatelessWidget {
  final TextEditingController title;
  final TextEditingController desc;
  final VoidCallback onTap;
  const NoteDialog({
    super.key,
    required this.title,
    required this.desc,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Text('Add Notes'),
      content: Column(
        mainAxisSize: .min,
        children: [
          TextField(
            controller: title,
            decoration: InputDecoration(
              hintText: 'Title',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: 10),
          TextField(
            controller: desc,
            maxLines: 5,
            minLines: 1,
            decoration: InputDecoration(
              hintText: 'Description',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
      contentPadding: .all(10),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(onPressed: onTap, child: Text('Add')),
      ],
    );
  }
}
