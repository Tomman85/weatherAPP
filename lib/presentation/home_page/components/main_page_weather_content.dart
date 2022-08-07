import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/const/hive_box_names.dart';
import 'package:weather/models/openweather_model/weather_data_response.dart';
import 'package:weather/presentation/home_page/components/weather_background_builder.dart';
import 'package:weather/presentation/home_page/home_page.dart';
import 'package:weather/presentation/search_page/search_page.dart';
import 'package:weather/presentation/settings_page/settings_page.dart';
import 'package:weather/services/repository_services/openweather_repository_service/openweather_repository_service.dart';
import 'package:weather/reusable_widgets/border_text_style.dart';
import 'current_weather_box.dart';
import 'daily_weather_list.dart';
import 'horizontal_weather_list.dart';
import 'main_current_weather.dart';

class MainPageWeatherContent extends StatefulWidget {
  static const mainPageWeatherContent = '/mainPage';

  const MainPageWeatherContent({Key? key}) : super(key: key);

  @override
  State<MainPageWeatherContent> createState() => _MainPageWeatherContentState();
}

class _MainPageWeatherContentState extends State<MainPageWeatherContent>
    with SingleTickerProviderStateMixin {
  ListWeatherDataModel? weatherDataResponse;
  bool isLoading = false;

  Future<ListWeatherDataModel?> _getWeatherData(lat, lon, lang) async {
    isLoading = true;
    weatherDataResponse =
        await OpenweatherRepositoryService.getOpenweatherData(lat, lon, lang);
    isLoading = false;
    return weatherDataResponse;
  }

  Widget? child;

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

        return FutureBuilder(
          future: Hive.box(favCity).isEmpty?null: _getWeatherData(
                  box.getAt(Hive.box(favCity).length - 1).latitude,
                  box.getAt(Hive.box(favCity).length - 1).longitude,
                  'language'.tr),
          builder: (
            BuildContext context,
            AsyncSnapshot snapshot,
          ) {
             if (snapshot.hasData) {
              dynamic data = snapshot.data;

              child = Scaffold(
                key: ValueKey(1),

                extendBodyBehindAppBar: true,
                appBar: AppBar(
                  title: BorderTextStyle(
                    child: Text(
                      splitBox(box),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  elevation: 0.0,
                  centerTitle: true,
                  actions: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(SettingsPage.settingsPageRouteName);
                      },
                      icon: const DecoratedIcon(
                        decoration: IconDecoration(
                          border: IconBorder(
                            color: Colors.black26,
                            width: 5,
                          ),
                        ),
                        icon: Icon(
                          Icons.settings,
                        ),
                      ),
                    ),
                  ],
                  backgroundColor: Colors.transparent,
                  leading: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        SearchPage.searchPageRouteName,
                      );
                    },
                    child: const DecoratedIcon(
                      icon: Icon(Icons.add_circle_outlined),
                      decoration: IconDecoration(
                        border: IconBorder(
                          color: Colors.black26,
                          width: 5,
                        ),
                      ),
                    ),
                  ),
                ),
                body: SizedBox(
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
                              BorderTextStyle(
                                child: Text(
                                  "${data.currentWeatherModel.weatherDescription[0].description} ",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.2,
                                child: HorizontalWeatherList(
                                  data: data,
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
                ),
              );
            } else {
              child = Scaffold(
                key: ValueKey(0),
                body: Center(
                  child: Lottie.asset(
                    'lib/assets/lottie/61302-weather-icon.json',
                  ),
                ),
              );
            }
            return Scaffold(
              body: AnimatedSwitcher(
                transitionBuilder: (child, animation) => FadeTransition(
                  opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: const Interval(0.4, 0.5),
                    ),
                  ),
                  child: child,
                ),
                duration:  Hive.box(favCity).isEmpty?const Duration(milliseconds: 100 ):const Duration(seconds:8 ),
                child: child,
              ),
            );
          },
        );
      },
    );
  }
}
