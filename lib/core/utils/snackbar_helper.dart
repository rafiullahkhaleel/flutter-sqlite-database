import 'package:flutter/material.dart';

class SnackBarHelper {
  static void show(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: .floating,
        margin: .all(5),
        shape: RoundedRectangleBorder(borderRadius: .circular(12)),
      ),
    );
  }
}
