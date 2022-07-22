import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:weather/const/hive_box_names.dart';
import 'package:weather/credentials.dart';
import 'package:weather/presentation/models/autocomplete_model/prediction_model.dart';
import 'package:weather/presentation/models/hive_box_models/model_list_of_cities.dart';
import 'package:weather/presentation/models/hive_box_models/model_single_city.dart';
import 'package:weather/presentation/models/openweather_model/weather_model.dart';
import 'package:weather/presentation/models/openweather_model/hourly_data_response.dart';
import 'package:weather/presentation/search_page/search_page.dart';
import 'package:weather/presentation/services/http_openweather_service.dart';

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

  ListHourlyModelData? currentDataResponse;
  ListHourlyModelData? hourlyDataResponse;
  ListHourlyModelData? dailyDataResponse;
  List<WeatherModel>? hourlyWeatherData;

  bool isLoading = false;

  Future getWeatherData(lat, lon) async {
    Response? response;
    try {
      isLoading = true;
      response = await httpService
          ?.getRequest("lat=$lat&lon=$lon&units=metric&appid=$openWeatherApi3");

      isLoading = false;

      if (response?.statusCode == 200) {
        hourlyDataResponse = ListHourlyModelData.fromJson(response?.data);
        hourlyWeatherData = hourlyDataResponse?.hourlyWeatherModel;
      } else {
        print('not good');
      }
    } on Exception catch (e) {
      isLoading = false;
      print(e);
    }
    return hourlyWeatherData;
  }

  @override
  void initState() {
    httpService = HttpWeatherService();
    // Hive.openBox(mainCity);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: Container(
        color: Colors.blue.shade200,
        child: Center(
          child: FutureBuilder(
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasData) {
                List<ListHourlyModelData> elo =
                    hourlyWeatherData!.cast<ListHourlyModelData>();

                return Text("sa");
              }
              if (snapshot.hasError) {
                print(snapshot.error);

                return Text(snapshot.error.toString());
              } else {
                return CircularProgressIndicator();
              }
            },
            future: getWeatherData(51.0212, 14.0000),
          ),
          // child: ValueListenableBuilder(
          //   valueListenable: Hive.box(mainCity).listenable(),
          //   builder: (BuildContext context, value, Widget? child) {
          //     final citiesList =
          //         Hive.box(mainCity).values.toList().cast<DataSingleModel>();
          //     return Text(citiesList[0].cityName.toString());
          //   },
          // ),
        ),
      ),
    );
  }
}
