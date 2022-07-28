import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CurrentWeatherBox extends StatelessWidget {
  const CurrentWeatherBox({
    Key? key,
    required this.size,
    required this.dateFormat,
    required this.data,
  }) : super(key: key);

  final Size size;
  final DateFormat dateFormat;

  final dynamic data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.blue.shade300,
        borderRadius: BorderRadius.circular(
          20,
        ),
      ),
      height: size.height * 0.4,
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "${'sunrise'.tr} ${dateFormat.format(
                  DateTime.fromMillisecondsSinceEpoch(
                      (data.currentWeatherModel.sunrise +
                              data.timeOffset -
                              7200) * 1000),
                )}",
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              Text(
                "${'sunset'.tr}  ${dateFormat.format(
                  DateTime.fromMillisecondsSinceEpoch(
                      (data.currentWeatherModel.sunset + data.timeOffset-7200) * 1000),
                )}",
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "feelTemperature".tr,
                    style: const TextStyle(color: Colors.white54),
                  ),
                  SizedBox(
                    width: size.width * 0.3,
                  ),
                  Text(
                    "humidity".tr,
                    style: const TextStyle(color: Colors.white54),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "${data.currentWeatherModel.feelTemperature.toStringAsFixed(0)} \u2103",
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  SizedBox(
                    width: size.width * 0.4,
                  ),
                  Text(
                    "${data.currentWeatherModel.humidity.toStringAsFixed(0)} %",
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "indexUV".tr,
                    style: const TextStyle(
                      color: Colors.white54,
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.35,
                  ),
                  Text(
                    "pressure".tr,
                    style: const TextStyle(
                      color: Colors.white54,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "${data.currentWeatherModel.uv.toStringAsFixed(0)}   ",
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.45,
                  ),
                  Text(
                    "${data.currentWeatherModel.pressure.toStringAsFixed(0)} hPa",
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
