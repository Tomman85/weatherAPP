import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/presentation/home_page/components/build_current_weather_box_row.dart';
import 'package:weather/utils/custom_typography.dart';
import 'package:weather/utils/dataCustomFormat.dart';

class CurrentWeatherBox extends StatelessWidget {
  const CurrentWeatherBox({
    Key? key,
    required this.size,
    required this.data,
  }) : super(key: key);

  final Size size;
  final dynamic data;

  //TODO Dodana tu jeszcze bedzie ilustracja słońca
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(
          20,
        ),
      ),
      height: size.height * 0.4,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "${'sunrise'.tr} ${DataCustomFormat.getCustomDateFormat(data.currentWeatherModel.sunrise + data.timeOffset - 7200)}",
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 10,
                ),
              ),
              Text(
                "${'sunset'.tr} ${DataCustomFormat.getCustomDateFormat(data.currentWeatherModel.sunset + data.timeOffset - 7200)}",
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 10,
                ),
              ),
            ],
          ),
          Spacer(),
          BuildCurrentWeatherBoxRow(
            style: CustomTypography.textStyleDetailedRowTitle,
            firstColumnData: "feelTemperature".tr,
            secondColumnData: "humidity".tr,
          ),
          BuildCurrentWeatherBoxRow(
            style: CustomTypography.textStyleDetailedRowSubtitle,
            firstColumnData:
                "${data.currentWeatherModel.feelTemperature.toStringAsFixed(0)} \u2103",
            secondColumnData:
                "${data.currentWeatherModel.humidity.toStringAsFixed(0)} %",
          ),
          Spacer(),
          BuildCurrentWeatherBoxRow(
            style: CustomTypography.textStyleDetailedRowTitle,
            firstColumnData: "indexUV".tr,
            secondColumnData: "pressure".tr,
          ),
          BuildCurrentWeatherBoxRow(
            style: CustomTypography.textStyleDetailedRowSubtitle,
            firstColumnData:
                "${data.currentWeatherModel.uv.toStringAsFixed(0)}",
            secondColumnData:
                "${data.currentWeatherModel.pressure.toStringAsFixed(0)} hPa",
          ),
          Spacer(),
        ],
      ),
    );
  }
}
