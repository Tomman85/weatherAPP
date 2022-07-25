import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:weather/const/hive_box_names.dart';
import 'package:weather/credentials.dart';

import 'package:weather/presentation/models/openweather_model/weather_data_response.dart';

import 'package:weather/presentation/search_page/search_page.dart';
import 'package:weather/presentation/services/http_openweather_service.dart';

import 'components/main_page_weather_content.dart';

class HomePage extends StatefulWidget {
  static const homePageRouteName = '/homepage';

  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HttpWeatherService? httpService;

  @override
  void initState() {
    httpService = HttpWeatherService();
    // Hive.openBox(mainCity);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(getWeatherData(50.122, 16.02232).);
    return Scaffold(
      appBar: AppBar(
        title: ValueListenableBuilder(
          valueListenable: Hive.box(mainCity).listenable(),
          builder: (BuildContext context, value, Widget? child) {
            var box = Hive.box(mainCity).getAt(0);
            return Text(
              box.cityName.toString().split(',')[0],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            );
          },
        ),
        elevation: 0.0,
        backgroundColor: Colors.blue.shade200,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              SearchPage.searchPageRouteName,
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
      body: const MainPageWeatherContent(),
    );
  }
}
