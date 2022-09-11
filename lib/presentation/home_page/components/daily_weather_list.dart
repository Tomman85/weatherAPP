import 'package:flutter/material.dart';
import 'package:weather/reusable_widgets/border_text_style.dart';
import 'package:weather/utils/custom_typography.dart';
import 'package:weather/utils/data_custom_format.dart';

class DailyWeatherList extends StatelessWidget {
  const DailyWeatherList({
    Key? key,
    required this.data,
  }) : super(key: key);

  final dynamic data;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: data.dailyWeatherModel.length,
      itemBuilder: (BuildContext context, int index) {
        String itemIcon =
            data.dailyWeatherModel[index].weatherDescription[0].icon;
        int itemDateTime = data.dailyWeatherModel[index].currentTime;
        double itemDayTemperature =
            data.dailyWeatherModel[index].temperature['day'];
        double itemNightTemperature =
            data.dailyWeatherModel[index].temperature['night'];
        return ListTile(
          trailing: BorderTextStyle(
            child: Text(
              "${itemDayTemperature.toStringAsFixed(0)}\u00B0 / ${itemNightTemperature.toStringAsFixed(0)}\u00B0",
              style: CustomTypography.textStyleBasic,
            ),
          ),
          leading: Image.network(
              "http://openweathermap.org/img/wn/$itemIcon@2x.png"),
          title: Align(
            alignment: Alignment.centerLeft,
            child: BorderTextStyle(
              child: Text(
                "${DataCustomFormat.getDailyDateFormat(itemDateTime)} ",
                style: CustomTypography.textStyleBasic,
              ),
            ),
          ),
        );
      },
    );
  }
}
