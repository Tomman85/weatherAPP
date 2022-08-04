import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';

class BorderTextStyle extends StatelessWidget {
  final Text child;

  const BorderTextStyle({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BorderedText(
      strokeWidth: 4.0,
      strokeColor: Colors.black26,
      child: child,
    );
  }
}
