import 'package:flutter/material.dart';

class AutocompleteShowDialog {
 static showCustomDialog(
      {builder, required context, titleText, contentText, childText}) {
    return showDialog(
        context: context,
        builder: (_) => AlertDialog(
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(childText),
                ),
              ],
              title: Text(titleText),
              content: Text(contentText),
            ));
  }
}
