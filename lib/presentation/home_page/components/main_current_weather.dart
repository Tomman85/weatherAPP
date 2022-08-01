import 'package:flutter/material.dart';
import 'package:weather/utils/custom_typography.dart';

class MainCurrentWeather extends StatelessWidget {
  const MainCurrentWeather({
    Key? key,
    required this.data,
  }) : super(key: key);

  final dynamic data;

  @override
  Widget build(BuildContext context) {
    //TODO Dodac jakiś background, nie widać napisu na białym tle
    return RichText(
      text: TextSpan(children: [
        TextSpan(
          text: data.currentWeatherModel.temperature.toStringAsFixed(0),
          style: CustomTypography.textStyleCurrentMain,
        ),
        WidgetSpan(
          child: Transform.translate(
            offset: const Offset(2, -60),
            child: Text(
              '\u2103',
              style: CustomTypography.textStyleCurrentDegree,
            ),
          ),
        ),
      ]),
    );
  }
}
