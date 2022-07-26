import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:get/get.dart';
import 'package:weather/const/hive_box_names.dart';
import 'package:weather/models/openweather_model/weather_data_response.dart';
import 'package:intl/intl.dart';
import 'package:weather/services/repository_services/openweather_repository_service/openweather_repository_service.dart';

class MainPageWeatherContent extends StatefulWidget {
  const MainPageWeatherContent({Key? key}) : super(key: key);

  @override
  State<MainPageWeatherContent> createState() => _MainPageWeatherContentState();
}

class _MainPageWeatherContentState extends State<MainPageWeatherContent> {
  ListWeatherDataModel? weatherDataResponse;

  bool isLoading = false;

  Future<ListWeatherDataModel?> _getWeatherData(lat, lon) async {
    isLoading = true;
    weatherDataResponse =
        await OpenweatherRepositoryService.getOpenweatherData(lat, lon);
    isLoading = false;
    return weatherDataResponse;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final DateFormat dateFormat = DateFormat.Hm();
    var box = Hive.box(mainCity).getAt(0);
    return box.cityName == ''
        ? const Text('Brak wszystkiego TODO')
        : FutureBuilder(
            future: _getWeatherData(
              box.latitude,
              box.longitude,
            ),
            builder: (
              BuildContext context,
              AsyncSnapshot snapshot,
            ) {
              if (snapshot.hasData) {
                var data = snapshot.data;
                double windConverter =
                    ((data.currentWeatherModel.windSpeed * 1 / 1000) /
                        (1 / 3600));
                double windAngle =
                    data.currentWeatherModel.windDegree * 3.14 / 135;

                return Container(
                  padding: const EdgeInsets.only(top: 50),
                  color: Colors.blue.shade200,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${data.currentWeatherModel.temperature.toStringAsFixed(0)} ",
                            style: const TextStyle(
                              fontSize: 120,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.end,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(
                              top: 15,
                            ),
                            child: Text(
                              "\u2103",
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Transform.rotate(
                            angle: windAngle,
                            child: const IconButton(
                              icon: Icon(
                                Icons.arrow_right_alt,
                                color: Colors.white,
                                size: 30,
                              ),
                              onPressed: null,
                            ),
                          ),
                          Text(
                            "${windConverter.toStringAsFixed(1)} km/h",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 20),
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
                                        data.currentWeatherModel.sunrise *
                                            1000),
                                  )}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "${'sunset'.tr}  ${dateFormat.format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        data.currentWeatherModel.sunset * 1000),
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
                                      style: const TextStyle(
                                          color: Colors.white54),
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
                                      style: const TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                    SizedBox(
                                      width: size.width * 0.4,
                                    ),
                                    Text(
                                      "${data.currentWeatherModel.humidity.toStringAsFixed(0)} %",
                                      style: const TextStyle(
                                          fontSize: 18, color: Colors.white),
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
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: Text(
                    "ładowanie",
                  ),
                );
              }
            },
          );
  }
}
