import 'package:flutter/material.dart';

import 'package:weather/models/custom_error_model/custom_error_model.dart';

void errorDialog(BuildContext context, CustomError e) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(e.code),
          content: Text('${e.plugin}\n${e.message}'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      });
}
