import 'package:flutter/material.dart';

class BuildSettingsPageRow extends StatelessWidget {
  final String firstColumnData;
  final Widget secondColumnData;
  final TextStyle firstStyle;
  final TextStyle secondStyle;

  const BuildSettingsPageRow({
    Key? key,
    required this.firstStyle,
    required this.secondStyle,
    required this.firstColumnData,
    required this.secondColumnData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,right: 40
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            firstColumnData,
            style: firstStyle,
          ),
          const Spacer(),
          secondColumnData,
        ],
      ),
    );
  }
}
