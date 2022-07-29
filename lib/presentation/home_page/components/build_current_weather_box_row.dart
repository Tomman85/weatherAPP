import 'package:flutter/material.dart';
class BuildCurrentWeatherBoxRow extends StatelessWidget {
  final String firstColumnData;
  final String secondColumnData;
  final TextStyle style;

  const BuildCurrentWeatherBoxRow({
    Key? key,
    required this.style,
    required this.firstColumnData,
    required this.secondColumnData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(firstColumnData, style: style),
          const Spacer(),
          Text(
            secondColumnData,
            style: style,
          ),
        ],
      ),
    );
  }
}
