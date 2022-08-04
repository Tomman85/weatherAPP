import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/const/hive_box_names.dart';
import 'package:weather/models/openweather_model/weather_data_response.dart';
import 'package:weather/presentation/home_page/components/weather_background_builder.dart';
import 'package:weather/presentation/search_page/search_page.dart';
import 'package:weather/services/repository_services/openweather_repository_service/openweather_repository_service.dart';
import 'current_weather_box.dart';
import 'daily_weather_list.dart';
import 'horizontal_weather_list.dart';
import 'main_current_weather.dart';

class MainPageWeatherContent extends StatefulWidget {
  const MainPageWeatherContent({Key? key}) : super(key: key);

  @override
  State<MainPageWeatherContent> createState() => _MainPageWeatherContentState();
}

class _MainPageWeatherContentState extends State<MainPageWeatherContent> {
  ListWeatherDataModel? weatherDataResponse;
  bool isLoading = false;

  Future<ListWeatherDataModel?> _getWeatherData(lat, lon, lang) async {
    isLoading = true;
    weatherDataResponse =
        await OpenweatherRepositoryService.getOpenweatherData(lat, lon, lang);
    isLoading = false;
    return weatherDataResponse;
  }

  void changeLanguage() {
    if (Get.locale == const Locale('pl', 'PL')) {
      Get.updateLocale(const Locale('en', 'US'));
    } else {
      Get.updateLocale(const Locale('pl', 'PL'));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ValueListenableBuilder(
      valueListenable: Hive.box(favCity).listenable(),
      builder: (BuildContext context, Box<dynamic> value, Widget? child) {
        Box box = Hive.box(favCity);

        return box.isEmpty
            ? Center(
                child: GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(SearchPage.searchPageRouteName);
                    },
                    child:
                        const Text('empty TODO KLIKAJ W TO JAK JEST PUSTO ')))
            : FutureBuilder(
                future: _getWeatherData(
                    box.getAt(Hive.box(favCity).length - 1).latitude,
                    box.getAt(Hive.box(favCity).length - 1).longitude,
                    'language'.tr),
                builder: (
                  BuildContext context,
                  AsyncSnapshot snapshot,
                ) {
                  Widget child;
                  if (snapshot.hasData) {
                    dynamic data = snapshot.data;
                    double windConverter =
                        ((data.currentWeatherModel.windSpeed * 1 / 1000) /
                            (1 / 3600));
                    child = SizedBox(
                      width: double.infinity,
                      child: Stack(
                        children: [
                          WeatherBackgroundBuilder.buildChild(
                            data.currentWeatherModel.weatherDescription[0].id,
                            size.width,
                            size.height,
                            data.currentWeatherModel.currentTime,
                            data.currentWeatherModel.sunrise,
                            data.currentWeatherModel.sunset,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 130.0),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  MainCurrentWeather(
                                    data: data,
                                  ),
                                  Text(
                                    "${data.currentWeatherModel.weatherDescription[0].description} ",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white.withOpacity(0.6),
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                  SizedBox(
                                    height: size.height * 0.2,
                                    child: HorizontalWeatherList(
                                      data: data,
                                      windConverter: windConverter,
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.2,
                                    child: DailyWeatherList(
                                      data: data,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  CurrentWeatherBox(
                                    size: size,
                                    data: data,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    child = Center(
                      child: Lottie.asset(
                        'lib/assets/lottie/61302-weather-icon.json',
                      ),
                    );
                  }
                  return AnimatedSwitcher(
                    transitionBuilder: (child, animation) => FadeTransition(
                      opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                          parent: animation,
                          curve: const Interval(0.4, 0.5),
                        ),
                      ),
                      child: child,
                    ),
                    duration: const Duration(seconds: 8),
                    child: child,
                  );
                },
              );
      },
    );
  }
}
