import 'package:flutter/material.dart';

class DeleteAutocompleteBackground extends StatelessWidget {
  const DeleteAutocompleteBackground({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const <Widget>[
          Icon(
            Icons.delete,
            color: Colors.red,
            size: 35,
          ),
          Text(
            "Przesuń aby usunąć",
            style: TextStyle(color: Colors.red, fontSize: 18,),
          )
        ],
      ),
    );
  }
}
