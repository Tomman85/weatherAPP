import 'package:flutter/material.dart';

class MainCurrentWeather extends StatelessWidget {
  const MainCurrentWeather({
    Key? key,
    required this.data,
  }) : super(key: key);

  final dynamic data;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "${data.currentWeatherModel.temperature.toStringAsFixed(0)} ",
          style: const TextStyle(
            fontSize: 120,
            color: Colors.white,
          ),
          textAlign: TextAlign.end,
        ),
        const Padding(
          padding: EdgeInsets.only(
            top: 15,
          ),
          child: Text(
            "\u2103",
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
