import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/presentation/home_page/components/build_current_weather_box_row.dart';
import 'package:weather/utils/custom_typography.dart';
import 'package:weather/utils/data_custom_format.dart';

class CurrentWeatherBox extends StatelessWidget {
   CurrentWeatherBox({
    Key? key,
    required this.size,
    required this.data,
  }) : super(key: key);

  final Size size;
  final dynamic data;
 DateTime dateTime = DateTime.now();
 

  //TODO Dodana tu jeszcze bedzie animacja słońca
  @override
  Widget build(BuildContext context) {print(dateTime.timeZoneOffset.inSeconds);
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
          const Spacer(),
          BuildCurrentWeatherBoxRow(
            style: CustomTypography.textStyleDetailedRowTime,
            firstColumnData:
                "${'sunrise'.tr} ${DataCustomFormat.getCustomDateFormat(data.currentWeatherModel.sunrise + data.timeOffset )}",
            secondColumnData:
                "${'sunset'.tr} ${DataCustomFormat.getCustomDateFormat(data.currentWeatherModel.sunset + data.timeOffset)}",
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
                "${data.currentWeatherModel.feelTemperature.toStringAsFixed(0)} \u2103",
            secondColumnData:
                "${data.currentWeatherModel.humidity.toStringAsFixed(0)} %",
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
                "${data.currentWeatherModel.uv.toStringAsFixed(0)}",
            secondColumnData:
                "${data.currentWeatherModel.pressure.toStringAsFixed(0)} hPa",
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
