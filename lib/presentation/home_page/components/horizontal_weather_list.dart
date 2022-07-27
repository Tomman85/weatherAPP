import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HorizontalWeatherList extends StatelessWidget {
  const HorizontalWeatherList({
    Key? key,
    required this.data,
    required this.dateFormat,
    required this.windConverter,
  }) : super(key: key);

  final dynamic data;
  final DateFormat dateFormat;
  final double windConverter;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: data.hourlyWeatherModel.length,
      itemBuilder: (BuildContext context, int index) {
        double itemTemperature = data.hourlyWeatherModel[index].temperature;
        int itemTime = data.hourlyWeatherModel[index].currentTime;
        double itemWindAngle = data.hourlyWeatherModel[index].windDegree;
        String itemIcon =
            data.hourlyWeatherModel[index].weatherDescription[0].icon;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                dateFormat.format(
                  DateTime.fromMillisecondsSinceEpoch(itemTime * 1000),
                ),
                style: TextStyle(color: Colors.white.withOpacity(0.6)),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "${itemTemperature.toStringAsFixed(0)}\u00B0",
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
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
                    child: const Icon(
                      Icons.arrow_right_alt,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  Text(
                    "${windConverter.toStringAsFixed(1)} km/h",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
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
