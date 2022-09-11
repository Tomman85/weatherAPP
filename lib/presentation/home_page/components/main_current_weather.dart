import 'package:flutter/material.dart';
import 'package:weather/reusable_widgets/border_text_style.dart';
import 'package:weather/utils/custom_typography.dart';

class MainCurrentWeather extends StatelessWidget {
  const MainCurrentWeather({
    Key? key,
    required this.data,
  }) : super(key: key);

  final dynamic data;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: [
        WidgetSpan(
          child: BorderTextStyle(
            child: Text(
              data.currentWeatherModel.temperature.toStringAsFixed(0),
              style: CustomTypography.textStyleCurrentMain,
            ),
          ),
        ),
        WidgetSpan(
          child: Transform.translate(
            offset: const Offset(2, -90),
            child: BorderTextStyle(
              child: Text(
                '\u2103',
                style: CustomTypography.textStyleCurrentDegree,
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
