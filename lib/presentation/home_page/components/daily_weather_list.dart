import 'package:flutter/material.dart';
import 'package:weather/utils/dataCustomFormat.dart';

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
          trailing: Text(
            "${itemDayTemperature.toStringAsFixed(0)}\u00B0 / ${itemNightTemperature.toStringAsFixed(0)}\u00B0",
            style: const TextStyle(color: Colors.white),
          ),
          leading: Image.network(
              "http://openweathermap.org/img/wn/$itemIcon@2x.png"),
          title: Text(
            "${DataCustomFormat.getDailyDateFormat(itemDateTime)} ",
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
