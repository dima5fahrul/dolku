import 'package:flutter/material.dart';

class Component {
  static void showSnackbar(
          {required String message,
          required Color color,
          required BuildContext context}) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.white)),
        backgroundColor: color,
      ));

  static void showLoading(BuildContext context) => showDialog(
      context: context,
      builder: (context) => const Center(
              child: CircularProgressIndicator(
            color: Colors.green,
          )),
      barrierDismissible: false);
}
