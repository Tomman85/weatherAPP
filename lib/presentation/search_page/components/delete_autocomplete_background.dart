import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        children: <Widget>[
          const Icon(
            Icons.delete,
            color: Colors.red,
            size: 35,
          ),
          Text(
            "moveToDelete".tr,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 18,
            ),
          )
        ],
      ),
    );
  }
}
