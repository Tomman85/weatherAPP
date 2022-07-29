import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather/utils/custom_typography.dart';
import 'package:weather/utils/dataCustomFormat.dart';

class HorizontalWeatherList extends StatelessWidget {
  final dynamic data;
  final double windConverter;

  const HorizontalWeatherList({
    Key? key,
    required this.data,
    required this.windConverter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: data.hourlyWeatherModel.length,
      itemBuilder: (BuildContext context, int index) {
        int currentTime = data.currentWeatherModel.currentTime;
        double itemTemperature = data.hourlyWeatherModel[index].temperature;
        int itemTime =
            data.hourlyWeatherModel[index].currentTime + data.timeOffset - 7200;
        double itemWindAngle = data.hourlyWeatherModel[index].windDegree;
        String itemIcon =
            data.hourlyWeatherModel[index].weatherDescription[0].icon;
        int timeOffset = data.timeOffset;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //TODO zmienic 7200 na czas lokalny/offset lokalny
              currentTime - 7200 + timeOffset < itemTime
                  ? Text(
                      DataCustomFormat.getCustomDateFormat(itemTime),
                      style: CustomTypography.textStyleHour,
                    )
                  : Text(
                      'now'.tr,
                      style: CustomTypography.textStyleHour,
                    ),
              const SizedBox(
                height: 5,
              ),
              Text("${itemTemperature.toStringAsFixed(0)}\u00B0",
                  style: CustomTypography.textStyleHourTemp),
              SizedBox(
                  width: 50,
                  height: 50,
                  child: Image.network(
                      "http://openweathermap.org/img/wn/$itemIcon@2x.png")),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RotationTransition(
                    turns: AlwaysStoppedAnimation(itemWindAngle / 360),
                    child: const Icon(
                      Icons.arrow_right_alt,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  Text(
                    "${windConverter.toStringAsFixed(1)} km/h",
                    style:  CustomTypography.textStyleWindSpeed,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
