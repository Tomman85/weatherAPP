import 'package:flutter/material.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:weather/reusable_widgets/border_text_style.dart';

import 'package:weather/utils/custom_typography.dart';
import 'package:weather/utils/data_custom_format.dart';

class HorizontalWeatherList extends StatelessWidget {
  final dynamic data;

  const HorizontalWeatherList({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: data.hourlyWeatherModel.length,
      itemBuilder: (BuildContext context, int index) {
        double itemTemperature = data.hourlyWeatherModel[index].temperature;
        int itemTime =
            data.hourlyWeatherModel[index].currentTime + data.timeOffset;
        double itemWindAngle = data.hourlyWeatherModel[index].windDegree;
        String itemIcon =
            data.hourlyWeatherModel[index].weatherDescription[0].icon;
        double windConverter =
            ((data.hourlyWeatherModel[index].windSpeed * 1 / 1000) /
                (1 / 3600));
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //TODO zmienic 7200 na czas lokalny/offset lokalnycurrentTime< itemTime2
              BorderTextStyle(
                child: Text(
                  DataCustomFormat.getCustomDateFormat(itemTime),
                  style: CustomTypography.textStyleBasic,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              BorderTextStyle(
                child: Text("${itemTemperature.toStringAsFixed(0)}\u00B0",
                    style: CustomTypography.textStyleHourTemp),
              ),
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
                    child: const DecoratedIcon(
                      icon: Icon(
                        Icons.arrow_right_alt,
                        color: Colors.white,
                        size: 20,
                      ),
                      decoration: IconDecoration(
                        border: IconBorder(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  BorderTextStyle(
                    child: Text(
                      "${windConverter.toStringAsFixed(1)} km/h",
                      style: CustomTypography.textStyleWindSpeed,
                    ),
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
