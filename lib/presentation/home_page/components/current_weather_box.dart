import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/presentation/home_page/components/build_current_weather_box_row.dart';
import 'package:weather/presentation/home_page/components/sun_arch.dart';
import 'package:weather/utils/custom_typography.dart';
import 'package:weather/utils/data_custom_format.dart';

class CurrentWeatherBox extends StatefulWidget {
  CurrentWeatherBox({
    Key? key,
    required this.size,
    required this.data,
  }) : super(key: key);

  final Size size;
  final dynamic data;

  @override
  State<CurrentWeatherBox> createState() => _CurrentWeatherBoxState();
}

class _CurrentWeatherBoxState extends State<CurrentWeatherBox> {
  DateTime dateTime = DateTime.now();
  late Timer timer;

  double getDegree() {
    if ((widget.data.currentWeatherModel.currentTime ) <
        (widget.data.currentWeatherModel.sunrise )) {
      return 0;
    } else if ((widget.data.currentWeatherModel.currentTime >
        widget.data.currentWeatherModel.sunset)) {
      return 2.05;
    }

    double dailyHour = double.parse(DataCustomFormat.getHourDateFormat(
        (widget.data.currentWeatherModel.sunset -
                widget.data.currentWeatherModel.sunrise) +
            widget.data.timeOffset));
    double angle = (2 / dailyHour) *
        double.parse(DataCustomFormat.getHourDateFormat(
            ((widget.data.currentWeatherModel.currentTime -
                    widget.data.currentWeatherModel.sunrise) +
                widget.data.timeOffset)));
    return angle;
  }

  @override
  Widget build(BuildContext context) {
    double degree = getDegree();
    print(degree);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20.0),
      ),
      height: widget.size.height * 0.4,
      child: Column(
        children: [
          SunArch(
            lineDegree: degree,
            sunDegree:degree,
            color: degree >= 2.05 ? Colors.grey.shade500 : Colors.yellow,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: BuildCurrentWeatherBoxRow(
              style: CustomTypography.textStyleDetailedRowTime,
              firstColumnData:
                  "${'sunrise'.tr} ${DataCustomFormat.getCustomDateFormat(widget.data.currentWeatherModel.sunrise + widget.data.timeOffset)}",
              secondColumnData:
                  "${'sunset'.tr} ${DataCustomFormat.getCustomDateFormat(widget.data.currentWeatherModel.sunset + widget.data.timeOffset)}",
            ),
          ),
          const Spacer(),
          BuildCurrentWeatherBoxRow(
            style: CustomTypography.textStyleDetailedRowTitle,
            firstColumnData: "feelTemperature".tr,
            secondColumnData: "humidity".tr,
          ),
          BuildCurrentWeatherBoxRow(
            style: CustomTypography.textStyleDetailedRowSubtitle,
            firstColumnData:
                "${widget.data.currentWeatherModel.feelTemperature.toStringAsFixed(0)} \u2103",
            secondColumnData:
                "${widget.data.currentWeatherModel.humidity.toStringAsFixed(0)} %",
          ),
          const Spacer(),
          BuildCurrentWeatherBoxRow(
            style: CustomTypography.textStyleDetailedRowTitle,
            firstColumnData: "indexUV".tr,
            secondColumnData: "pressure".tr,
          ),
          BuildCurrentWeatherBoxRow(
            style: CustomTypography.textStyleDetailedRowSubtitle,
            firstColumnData:
                "${widget.data.currentWeatherModel.uv.toStringAsFixed(0)}",
            secondColumnData:
                "${widget.data.currentWeatherModel.pressure.toStringAsFixed(0)} hPa",
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
